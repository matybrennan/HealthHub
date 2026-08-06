//
//  VisionPrescriptionsService.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/7/2026.
//

import Foundation
import HealthKit

public final class VisionPrescriptionsService {

    struct Unit {
        static let diopter = HKUnit.diopter()
        static let prismDiopter = HKUnit.prismDiopter()
        static let degree = HKUnit.degreeAngle()
        static let millimeter = HKUnit.meterUnit(with: .milli)
    }

    public init() { }
}

// MARK: - VisionPrescriptionsServiceProtocol
extension VisionPrescriptionsService: VisionPrescriptionsServiceProtocol {

    public func glassesPrescriptions() async throws -> GlassesPrescription {
        let samples = try await fetchVisionPrescriptionSamples()
        let items = samples.compactMap { $0 as? HKGlassesPrescription }.map { sample -> GlassesPrescription.Item in
            GlassesPrescription.Item(
                rightEye: Self.glassesEyeSpecification(from: sample.rightEye),
                leftEye: Self.glassesEyeSpecification(from: sample.leftEye),
                dateIssued: sample.dateIssued,
                expirationDate: sample.expirationDate
            )
        }

        return GlassesPrescription(items: items)
    }

    public func contactsPrescriptions() async throws -> ContactsPrescription {
        let samples = try await fetchVisionPrescriptionSamples()
        let items = samples.compactMap { $0 as? HKContactsPrescription }.map { sample -> ContactsPrescription.Item in
            ContactsPrescription.Item(
                rightEye: Self.contactsEyeSpecification(from: sample.rightEye),
                leftEye: Self.contactsEyeSpecification(from: sample.leftEye),
                brand: sample.brand,
                dateIssued: sample.dateIssued,
                expirationDate: sample.expirationDate
            )
        }

        return ContactsPrescription(items: items)
    }

    public func saveGlassesPrescription(model: GlassesPrescription.Item, extra: [String: Sendable]?) async throws {
        let type = HKObjectType.visionPrescriptionType()
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sample = HKGlassesPrescription(
            rightEyeSpecification: model.rightEye.map(Self.glassesLensSpecification),
            leftEyeSpecification: model.leftEye.map(Self.glassesLensSpecification),
            dateIssued: model.dateIssued,
            expirationDate: model.expirationDate,
            device: nil,
            metadata: extra
        )

        try await HealthStoreProvider.shared.save(sample)
    }

    public func saveContactsPrescription(model: ContactsPrescription.Item, extra: [String: Sendable]?) async throws {
        let type = HKObjectType.visionPrescriptionType()
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sample = HKContactsPrescription(
            rightEyeSpecification: model.rightEye.map(Self.contactsLensSpecification),
            leftEyeSpecification: model.leftEye.map(Self.contactsLensSpecification),
            brand: model.brand,
            dateIssued: model.dateIssued,
            expirationDate: model.expirationDate,
            device: nil,
            metadata: extra
        )

        try await HealthStoreProvider.shared.save(sample)
    }
}

// MARK: - Fetching
private extension VisionPrescriptionsService {

    func fetchVisionPrescriptionSamples() async throws -> [HKVisionPrescription] {
        let type = HKObjectType.visionPrescriptionType()
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.sample(type: type)],
            sortDescriptors: [SortDescriptor(\HKSample.startDate, order: .reverse)]
        )
        let samples = try await descriptor.result(for: HealthStoreProvider.shared)
        return samples.compactMap { $0 as? HKVisionPrescription }
    }
}

// MARK: - Read Mapping
private extension VisionPrescriptionsService {

    static func lensSpecification(from lens: HKLensSpecification) -> LensSpecification {
        LensSpecification(
            sphere: lens.sphere.doubleValue(for: Unit.diopter),
            cylinder: lens.cylinder?.doubleValue(for: Unit.diopter),
            axis: lens.axis?.doubleValue(for: Unit.degree),
            addPower: lens.addPower?.doubleValue(for: Unit.diopter)
        )
    }

    static func glassesEyeSpecification(from spec: HKGlassesLensSpecification?) -> GlassesPrescription.EyeSpecification? {
        guard let spec else { return nil }
        return GlassesPrescription.EyeSpecification(
            lens: lensSpecification(from: spec),
            vertexDistance: spec.vertexDistance?.doubleValue(for: Unit.millimeter),
            prism: spec.prism.map(Self.readVisionPrism),
            farPupillaryDistance: spec.farPupillaryDistance?.doubleValue(for: Unit.millimeter),
            nearPupillaryDistance: spec.nearPupillaryDistance?.doubleValue(for: Unit.millimeter)
        )
    }

    static func contactsEyeSpecification(from spec: HKContactsLensSpecification?) -> ContactsPrescription.EyeSpecification? {
        guard let spec else { return nil }
        return ContactsPrescription.EyeSpecification(
            lens: lensSpecification(from: spec),
            baseCurve: spec.baseCurve?.doubleValue(for: Unit.millimeter),
            diameter: spec.diameter?.doubleValue(for: Unit.millimeter)
        )
    }

    static func readVisionPrism(from prism: HKVisionPrism) -> VisionPrism {
        VisionPrism(
            amount: prism.amount.doubleValue(for: Unit.prismDiopter),
            angle: prism.angle.doubleValue(for: Unit.degree),
            verticalAmount: prism.verticalAmount.doubleValue(for: Unit.prismDiopter),
            horizontalAmount: prism.horizontalAmount.doubleValue(for: Unit.prismDiopter),
            verticalBase: prismBaseString(prism.verticalBase),
            horizontalBase: prismBaseString(prism.horizontalBase),
            eye: eyeString(prism.eye)
        )
    }

    static func prismBaseString(_ base: HKPrismBase) -> String {
        switch base {
        case .none: "none"
        case .up: "up"
        case .down: "down"
        case .in: "in"
        case .out: "out"
        @unknown default: "unknown"
        }
    }

    static func eyeString(_ eye: HKVisionEye) -> String {
        switch eye {
        case .left: "left"
        case .right: "right"
        @unknown default: "unknown"
        }
    }
}

// MARK: - Save Mapping
private extension VisionPrescriptionsService {

    static func glassesLensSpecification(from spec: GlassesPrescription.EyeSpecification) -> HKGlassesLensSpecification {
        let prism: HKVisionPrism?
        if let sourcePrism = spec.prism {
            prism = Self.buildVisionPrism(from: sourcePrism)
        } else {
            prism = nil
        }

        return HKGlassesLensSpecification(
            sphere: HKQuantity(unit: Unit.diopter, doubleValue: spec.lens.sphere),
            cylinder: spec.lens.cylinder.map { HKQuantity(unit: Unit.diopter, doubleValue: $0) },
            axis: spec.lens.axis.map { HKQuantity(unit: Unit.degree, doubleValue: $0) },
            addPower: spec.lens.addPower.map { HKQuantity(unit: Unit.diopter, doubleValue: $0) },
            vertexDistance: spec.vertexDistance.map { HKQuantity(unit: Unit.millimeter, doubleValue: $0) },
            prism: prism,
            farPupillaryDistance: spec.farPupillaryDistance.map { HKQuantity(unit: Unit.millimeter, doubleValue: $0) },
            nearPupillaryDistance: spec.nearPupillaryDistance.map { HKQuantity(unit: Unit.millimeter, doubleValue: $0) }
        )
    }

    static func contactsLensSpecification(from spec: ContactsPrescription.EyeSpecification) -> HKContactsLensSpecification {
        HKContactsLensSpecification(
            sphere: HKQuantity(unit: Unit.diopter, doubleValue: spec.lens.sphere),
            cylinder: spec.lens.cylinder.map { HKQuantity(unit: Unit.diopter, doubleValue: $0) },
            axis: spec.lens.axis.map { HKQuantity(unit: Unit.degree, doubleValue: $0) },
            addPower: spec.lens.addPower.map { HKQuantity(unit: Unit.diopter, doubleValue: $0) },
            baseCurve: spec.baseCurve.map { HKQuantity(unit: Unit.millimeter, doubleValue: $0) },
            diameter: spec.diameter.map { HKQuantity(unit: Unit.millimeter, doubleValue: $0) }
        )
    }

    /// Builds an `HKVisionPrism`, preferring rectangular coordinates (vertical/horizontal) when both
    /// axis pairs are supplied, otherwise falling back to polar coordinates (amount/angle).
    static func buildVisionPrism(from prism: VisionPrism) -> HKVisionPrism? {
        let eye: HKVisionEye = prism.eye == "left" ? .left : .right

        if let verticalAmount = prism.verticalAmount, let horizontalAmount = prism.horizontalAmount {
            return HKVisionPrism(
                verticalAmount: HKQuantity(unit: Unit.prismDiopter, doubleValue: verticalAmount),
                verticalBase: prismBase(from: prism.verticalBase),
                horizontalAmount: HKQuantity(unit: Unit.prismDiopter, doubleValue: horizontalAmount),
                horizontalBase: prismBase(from: prism.horizontalBase),
                eye: eye
            )
        }

        if let amount = prism.amount, let angle = prism.angle {
            return HKVisionPrism(
                amount: HKQuantity(unit: Unit.prismDiopter, doubleValue: amount),
                angle: HKQuantity(unit: Unit.degree, doubleValue: angle),
                eye: eye
            )
        }

        return nil
    }

    static func prismBase(from value: String?) -> HKPrismBase {
        switch value {
        case "up": .up
        case "down": .down
        case "in": .in
        case "out": .out
        default: .none
        }
    }
}
