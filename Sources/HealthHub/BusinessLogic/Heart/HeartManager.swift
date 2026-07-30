//
//  HeartManager.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/7/18.
//

import Foundation
import HealthKit

public final class HeartManager {

    private let heartRateService: HeartRateServiceProtocol

    public init(heartRateService: HeartRateServiceProtocol) {
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

    public var heartRate: HeartRateServiceProtocol {
        heartRateService
    }

    public func atrialFibrillation() async throws -> AtrialFibrillationHistory {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .atrialFibrillationBurden)
        let items = samples.map { item -> AtrialFibrillationHistory.Item in
            let percentage = item.quantity.doubleValue(for: .percent()) * 100
            return AtrialFibrillationHistory.Item(percentage: percentage, startDate: item.startDate, endDate: item.endDate)
        }

        return AtrialFibrillationHistory(items: items)
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

        return CardioRecovery(items: items)
    }

    public func heartRateVariability() async throws -> HeartRateVariability {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .heartRateVariabilitySDNN)
        let items = samples.map { item -> HeartRateVariability.Item in
            let sdnn = item.quantity.doubleValue(for: HKUnit.secondUnit(with: .milli))
            return HeartRateVariability.Item(sdnn: sdnn, date: item.endDate)
        }

        return HeartRateVariability(items: items)
    }

    public func highHeartRateEvents() async throws -> HighHeartRateEvent {
        let samples = try await fetchCategorySamples(categoryIdentifier: .highHeartRateEvent)
        let items = samples.map { item -> HighHeartRateEvent.Item in
            HighHeartRateEvent.Item(startDate: item.startDate, endDate: item.endDate)
        }

        return HighHeartRateEvent(items: items)
    }

    public func irregularHeartRhythmEvents() async throws -> IrregularHeartRhythmEvent {
        let samples = try await fetchCategorySamples(categoryIdentifier: .irregularHeartRhythmEvent)
        let items = samples.map { item -> IrregularHeartRhythmEvent.Item in
            IrregularHeartRhythmEvent.Item(startDate: item.startDate, endDate: item.endDate)
        }

        return IrregularHeartRhythmEvent(items: items)
    }

    public func lowHeartRateEvents() async throws -> LowHeartRateEvent {
        let samples = try await fetchCategorySamples(categoryIdentifier: .lowHeartRateEvent)
        let items = samples.map { item -> LowHeartRateEvent.Item in
            LowHeartRateEvent.Item(startDate: item.startDate, endDate: item.endDate)
        }

        return LowHeartRateEvent(items: items)
    }

    public func peripheralPerfusionIndex() async throws -> PeripheralPerfusionIndex {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .peripheralPerfusionIndex)
        let items = samples.map { item -> PeripheralPerfusionIndex.Item in
            let percentage = item.quantity.doubleValue(for: HKUnit.percent()) * 100
            return PeripheralPerfusionIndex.Item(percentage: percentage, date: item.endDate)
        }

        return PeripheralPerfusionIndex(items: items)
    }

    public func restingHeartRate() async throws -> RestingHeartRate {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .restingHeartRate)
        let items = samples.map { item -> RestingHeartRate.Item in
            let bpm = item.quantity.doubleValue(for: HKUnit(from: "count/min"))
            return RestingHeartRate.Item(bpm: bpm, date: item.endDate)
        }

        return RestingHeartRate(items: items)
    }

    public func walkingHeartRateAverage() async throws -> WalkingHeartRateAverage {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .walkingHeartRateAverage)
        let items = samples.map { item -> WalkingHeartRateAverage.Item in
            let bpm = item.quantity.doubleValue(for: HKUnit(from: "count/min"))
            return WalkingHeartRateAverage.Item(bpm: bpm, date: item.endDate)
        }

        return WalkingHeartRateAverage(items: items)
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
            let quantity = HKQuantity(unit: .percent(), doubleValue: $0.percentage / 100)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }
}
