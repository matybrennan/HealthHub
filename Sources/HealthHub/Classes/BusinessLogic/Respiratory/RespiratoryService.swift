//
//  RespiratoryService.swift
//  HealthHub
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation
@preconcurrency import HealthKit

public final class RespiratoryService {
    
    public init() { }
}

// MARK: - FetchQuantitySample
extension RespiratoryService: FetchQuantitySample, RespiratoryRateCase, BloodOxygenCase, InhalerUsageCase, SixMinuteWalkCase { }

// MARK: - RespiratoryServiceProtocol
extension RespiratoryService: RespiratoryServiceProtocol {

    public func bloodOxygen() async throws -> BloodOxygen {
        try await baseBloodOxygen()
    }
    
    public func forcedExpiratoryVolume() async throws -> ForcedExpiratoryVolume {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .forcedExpiratoryVolume1)
        let items = samples.map { item -> ForcedExpiratoryVolume.Item in
            let liters = item.quantity.doubleValue(for: HKUnit.liter())
            return ForcedExpiratoryVolume.Item(liters: liters, date: item.endDate)
        }
        
        let model = ForcedExpiratoryVolume(items: items)
        return model
    }
    
    public func forcedVitalCapacity() async throws -> ForcedVitalCapacity {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .forcedVitalCapacity)
        let items = samples.map { item -> ForcedVitalCapacity.Item in
            let liters = item.quantity.doubleValue(for: HKUnit.liter())
            return ForcedVitalCapacity.Item(liters: liters, date: item.endDate)
        }
        
        let model = ForcedVitalCapacity(items: items)
        return model
    }

    public func inhalerUsage() async throws -> InhalerUsage {
        try await baseInhalerUsage()
    }
    
    public func peakExpiratoryFlowRate() async throws -> PeakExpiratoryFlowRate {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .peakExpiratoryFlowRate)
        let items = samples.map { item -> PeakExpiratoryFlowRate.Item in
            let litersPerMin = item.quantity.doubleValue(for: HKUnit(from: "L/min"))
            return PeakExpiratoryFlowRate.Item(litersPerMinute: litersPerMin, date: item.endDate)
        }
        
        let model = PeakExpiratoryFlowRate(items: items)
        return model
    }
    
    public func respiratoryRate() async throws -> RespiratoryRate {
        try await baseRespiratoryRate()
    }

    public func sixMinuteWalk() async throws -> SixMinuteWalk {
        try await baseSixMinuteWalk()
    }

     // MARK: Saving

    public func saveBloodOxygen(model: BloodOxygen, extra: [String: Sendable]?) async throws {
        try await saveBaseBloodOxygen(model: model, extra: extra)
    }

    public func saveForcedExpiratoryVolume(model: ForcedExpiratoryVolume, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .forcedExpiratoryVolume1)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .liter(), doubleValue: $0.liters)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveForcedVitalCapacity(model: ForcedVitalCapacity, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .forcedVitalCapacity)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .liter(), doubleValue: $0.liters)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveInhalerUsage(model: InhalerUsage, extra: [String: Sendable]?) async throws {
        try await saveBaseInhalerUsage(model: model, extra: extra)
    }

    public func savePeakExpiratoryFlowRate(model: PeakExpiratoryFlowRate, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .peakExpiratoryFlowRate)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: "L/min")
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.litersPerMinute)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveRespiratoryRate(model: RespiratoryRate, extra: [String: Sendable]?) async throws {
        try await saveBaseRespiratoryRate(model: model, extra: extra)
    }

    public func saveSixMinuteWalk(model: SixMinuteWalk, extra: [String: Sendable]?) async throws {
        try await saveBaseSixMinuteWalk(model, extra: extra)
    }
}
