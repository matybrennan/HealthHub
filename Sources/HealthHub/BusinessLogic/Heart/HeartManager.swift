//
//  HeartManager.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/7/18.
//

import Foundation
import HealthKit

public final class HeartManager {

    private let heartRateService: HeartRateService

    public init(heartRateService: HeartRateService) {
        self.heartRateService = heartRateService
    }

    public convenience init() {
        self.init(heartRateService: HeartRateService())
    }
}

// MARK: - BloodPressureCase
extension HeartManager: BloodPressureCase, CardioFitnessCase, FetchCategorySample { }

extension HeartManager: HeartManagerProtocol {
    
    // MARK: - Services

    public var heartRate: HeartRateService {
        heartRateService
    }

    public func atrialFibrillation() async throws -> AtrialFibrillationHistory {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .atrialFibrillationBurden)
        let items = samples.map { item -> AtrialFibrillationHistory.Item in
            let percentage = item.quantity.doubleValue(for: .percent())
            return AtrialFibrillationHistory.Item(percentage: percentage, startDate: item.startDate, endDate: item.endDate)
        }

        let vm = AtrialFibrillationHistory(items: items)
        return vm
    }

    public func bloodPressure() async throws -> BloodPressure {
        try await baseBloodPressure()
    }

    public func cardioFitness() async throws -> CardioFitness {
        try await baseCardioFitness()
    }

    public func cardioRecovery() async throws -> CardioRecovery {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .heartRateRecoveryOneMinute)
        let items = samples.map { item -> CardioRecovery.Item in
            let value = item.quantity.doubleValue(for: HKUnit(from: "count/min"))
            return CardioRecovery.Item(bpm: Int(value), date: item.endDate)
        }

        let model = CardioRecovery(items: items)
        return model
    }

    public func heartRateVariability() async throws -> HeartRateVariability {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .heartRateVariabilitySDNN)
        let items = samples.map { item -> HeartRateVariability.Item in
            let sdnn = item.quantity.doubleValue(for: HKUnit.secondUnit(with: .milli))
            return HeartRateVariability.Item(sdnn: sdnn, date: item.endDate)
        }

        let model = HeartRateVariability(items: items)
        return model
    }

    public func highHeartRateEvents() async throws -> HighHeartRateEvent {
        let samples = try await fetchCategorySamples(categoryIdentifier: .highHeartRateEvent)
        let items = samples.map { item -> HighHeartRateEvent.Item in
            HighHeartRateEvent.Item(startDate: item.startDate, endDate: item.endDate)
        }

        let model = HighHeartRateEvent(items: items)
        return model
    }

    public func irregularHeartRhythmEvents() async throws -> IrregularHeartRhythmEvent {
        let samples = try await fetchCategorySamples(categoryIdentifier: .irregularHeartRhythmEvent)
        let items = samples.map { item -> IrregularHeartRhythmEvent.Item in
            IrregularHeartRhythmEvent.Item(startDate: item.startDate, endDate: item.endDate)
        }

        let model = IrregularHeartRhythmEvent(items: items)
        return model
    }

    public func lowHeartRateEvents() async throws -> LowHeartRateEvent {
        let samples = try await fetchCategorySamples(categoryIdentifier: .lowHeartRateEvent)
        let items = samples.map { item -> LowHeartRateEvent.Item in
            LowHeartRateEvent.Item(startDate: item.startDate, endDate: item.endDate)
        }

        let model = LowHeartRateEvent(items: items)
        return model
    }

    public func peripheralPerfusionIndex() async throws -> PeripheralPerfusionIndex {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .peripheralPerfusionIndex)
        let items = samples.map { item -> PeripheralPerfusionIndex.Item in
            let percentage = item.quantity.doubleValue(for: HKUnit.percent()) * 100
            return PeripheralPerfusionIndex.Item(percentage: percentage, date: item.endDate)
        }

        let model = PeripheralPerfusionIndex(items: items)
        return model
    }

    public func restingHeartRate() async throws -> RestingHeartRate {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .restingHeartRate)
        let items = samples.map { item -> RestingHeartRate.Item in
            let bpm = item.quantity.doubleValue(for: HKUnit(from: "count/min"))
            return RestingHeartRate.Item(bpm: bpm, date: item.endDate)
        }

        let model = RestingHeartRate(items: items)
        return model
    }

    public func walkingHeartRateAverage() async throws -> WalkingHeartRateAverage {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .walkingHeartRateAverage)
        let items = samples.map { item -> WalkingHeartRateAverage.Item in
            let bpm = item.quantity.doubleValue(for: HKUnit(from: "count/min"))
            return WalkingHeartRateAverage.Item(bpm: bpm, date: item.endDate)
        }

        let model = WalkingHeartRateAverage(items: items)
        return model
    }

    // MARK: - Save

    public func saveBloodPressure(model: BloodPressure, extra: [String: Sendable]?) async throws {
        try await baseSaveBloodPressure(model: model, extra: extra)
    }
    
    public func saveCardioFitness(model: CardioFitness, extra: [String: Sendable]?) async throws {
        try await saveBaseCardioFitness(model, extra: extra)
    }

    public func saveCardioRecovery(model: CardioRecovery, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .heartRateRecoveryOneMinute)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: "count/min")
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: Double($0.bpm))
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func savePeripheralPerfusionIndex(model: PeripheralPerfusionIndex, extra: [String : any Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .peripheralPerfusionIndex)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .percent(), doubleValue: $0.percentage)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }
}
