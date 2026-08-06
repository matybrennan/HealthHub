//
//  MobilityService.swift
//  HealthHub
//
//  Created by Maty Brennan on 24/2/2024.
//

import Foundation
import HealthKit

public final class MobilityService {

    public init() { }
}

private extension MobilityService {
    func fetchCategorySamples(categoryIdentifier: HKCategoryTypeIdentifier, from dateRange: DateRangeType, sortDescriptors: [SortDescriptor<HKCategorySample>]) async throws -> [HKCategorySample] {
        let samples = try await fetchCategorySamples(categoryIdentifier: categoryIdentifier, sortDescriptors: sortDescriptors)
        guard let predicate = try dateRange.predicate() else { return samples }
        return samples.filter { predicate.evaluate(with: $0) }
    }
}

// MARK: - FetchQuantitySample
extension MobilityService: FetchQuantitySample, FetchCategorySample, SixMinuteWalkCase, CardioFitnessCase { }

// MARK: - MobilityServiceProtocol
extension MobilityService: MobilityServiceProtocol {

    public func cardioFitness(from dateRange: DateRangeType) async throws -> CardioFitness {
        try await baseCardioFitness(from: dateRange)
    }

    public func doubleSupportTime(from dateRange: DateRangeType) async throws -> DoubleSupportTime {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .walkingDoubleSupportPercentage, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> DoubleSupportTime.Item in
            let percentage = item.quantity.doubleValue(for: .percent())
            return DoubleSupportTime.Item(percentage: percentage, startDate: item.startDate, endDate: item.endDate)
        }

        return DoubleSupportTime(items: items)
    }
    
    public func groundContactTime(from dateRange: DateRangeType) async throws -> GroundContactTime {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .runningGroundContactTime, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> GroundContactTime.Item in
            let durationMS = item.quantity.doubleValue(for: HKUnit.secondUnit(with: .milli))
            return GroundContactTime.Item(duration: durationMS, startDate: item.startDate, endDate: item.endDate)
        }

        return GroundContactTime(items: items)
    }
    
    public func runningStrideLength(from dateRange: DateRangeType) async throws -> RunningStrideLength {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .runningStrideLength, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> RunningStrideLength.Item in
            let distanceMeters = item.quantity.doubleValue(for: HKUnit.meter())
            return RunningStrideLength.Item(distance: distanceMeters, startDate: item.startDate, endDate: item.endDate)
        }

        return RunningStrideLength(items: items)
    }

    public func sixMinuteWalk(from dateRange: DateRangeType) async throws -> SixMinuteWalk {
        try await baseSixMinuteWalk(from: dateRange)
    }

    public func stairSpeedDown(from dateRange: DateRangeType) async throws -> StairSpeedDown {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .stairDescentSpeed, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> StairSpeedDown.Item in
            let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
            let velocity = item.quantity.doubleValue(for: speedUnit)
            return StairSpeedDown.Item(velocity: velocity, startDate: item.startDate, endDate: item.endDate)
        }

        return StairSpeedDown(items: items)
    }

    public func stairSpeedUp(from dateRange: DateRangeType) async throws -> StairSpeedUp {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .stairAscentSpeed, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> StairSpeedUp.Item in
            let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
            let velocity = item.quantity.doubleValue(for: speedUnit)
            return StairSpeedUp.Item(velocity: velocity, startDate: item.startDate, endDate: item.endDate)
        }

        return StairSpeedUp(items: items)
    }

    public func verticalOscillation(from dateRange: DateRangeType) async throws -> VerticalOscillation {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .runningVerticalOscillation, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> VerticalOscillation.Item in
            let distanceCM = item.quantity.doubleValue(for: HKUnit.meterUnit(with: .centi))
            return VerticalOscillation.Item(distance: distanceCM, startDate: item.startDate, endDate: item.endDate)
        }

        return VerticalOscillation(items: items)
    }

    public func walkingAsymmetry(from dateRange: DateRangeType) async throws -> WalkingAsymmetry {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .walkingAsymmetryPercentage, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> WalkingAsymmetry.Item in
            let percentage = item.quantity.doubleValue(for: .percent())
            return WalkingAsymmetry.Item(percentage: percentage, startDate: item.startDate, endDate: item.endDate)
        }

        return WalkingAsymmetry(items: items)
    }

    public func walkingSpeed(from dateRange: DateRangeType) async throws -> WalkingSpeed {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .walkingSpeed, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> WalkingSpeed.Item in
            let speedUnit = HKUnit.meterUnit(with: .kilo).unitDivided(by: HKUnit.hour())
            let velocity = item.quantity.doubleValue(for: speedUnit)
            return WalkingSpeed.Item(velocity: velocity, startDate: item.startDate, endDate: item.endDate)
        }

        return WalkingSpeed(items: items)
    }

    public func walkingSteadiness(from dateRange: DateRangeType) async throws -> WalkingSteadiness {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .appleWalkingSteadiness, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> WalkingSteadiness.Item in
            let percentage = item.quantity.doubleValue(for: .percent())
            return WalkingSteadiness.Item(percentage: percentage, startDate: item.startDate, endDate: item.endDate)
        }

        return WalkingSteadiness(items: items)
    }

    public func walkingSteadinessEvent(from dateRange: DateRangeType) async throws -> WalkingSteadinessEvent {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .appleWalkingSteadinessEvent, from: dateRange, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> WalkingSteadinessEvent.Item in
            let classification = WalkingSteadinessEvent.Classification(rawValue: item.value) ?? .initialLow
            return WalkingSteadinessEvent.Item(classification: classification, startDate: item.startDate, endDate: item.endDate)
        }

        return WalkingSteadinessEvent(items: items)
    }

    public func walkingStepLength(from dateRange: DateRangeType) async throws -> WalkingStepLength {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .walkingStepLength, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> WalkingStepLength.Item in
            let distanceCM = item.quantity.doubleValue(for: HKUnit.meterUnit(with: .centi))
            return WalkingStepLength.Item(distance: distanceCM, startDate: item.startDate, endDate: item.endDate)
        }

        return WalkingStepLength(items: items)
    }

    // MARK: Saving

    public func saveCardioFitness(model: CardioFitness, extra: [String: Sendable]?) async throws {
        try await saveBaseCardioFitness(model, extra: extra)
    }

    public func saveDoubleSupportTime(model: DoubleSupportTime, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .walkingDoubleSupportPercentage)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .percent(), doubleValue: $0.percentage)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveGroundContactTime(model: GroundContactTime, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .runningGroundContactTime)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.secondUnit(with: .milli)
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.duration)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveRunningStrideLength(model: RunningStrideLength, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .runningStrideLength)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .meter(), doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveSixMinuteWalk(model: SixMinuteWalk, extra: [String: Sendable]?) async throws {
        try await saveBaseSixMinuteWalk(model, extra: extra)
    }

    public func saveStairSpeedDown(model: StairSpeedDown, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .stairDescentSpeed)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: speedUnit, doubleValue: $0.velocity)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveStairSpeedUp(model: StairSpeedUp, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .stairAscentSpeed)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: speedUnit, doubleValue: $0.velocity)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveVerticalOscillation(model: VerticalOscillation, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .runningVerticalOscillation)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.meterUnit(with: .centi)
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveWalkingSpeed(model: WalkingSpeed, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .walkingSpeed)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let speedUnit = HKUnit.meterUnit(with: .kilo).unitDivided(by: HKUnit.hour())
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: speedUnit, doubleValue: $0.velocity)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveWalkingStepLength(model: WalkingStepLength, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .walkingStepLength)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.meterUnit(with: .centi)
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }
}
