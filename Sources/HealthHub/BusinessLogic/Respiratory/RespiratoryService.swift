//
//  RespiratoryService.swift
//  HealthHub
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation
import HealthKit

public final class RespiratoryService {
    
    public init() { }
}

// MARK: - FetchQuantitySample
extension RespiratoryService: FetchQuantitySample, RespiratoryRateCase, BloodOxygenCase, InhalerUsageCase, SixMinuteWalkCase { }

// MARK: - RespiratoryServiceProtocol
extension RespiratoryService: RespiratoryServiceProtocol {

    public func bloodOxygen(from dateRange: DateRangeType) async throws -> BloodOxygen {
        try await baseBloodOxygen(from: dateRange)
    }
    
    public func forcedExpiratoryVolume(from dateRange: DateRangeType) async throws -> ForcedExpiratoryVolume {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .forcedExpiratoryVolume1, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> ForcedExpiratoryVolume.Item in
            let liters = item.quantity.doubleValue(for: HKUnit.liter())
            return ForcedExpiratoryVolume.Item(liters: liters, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = ForcedExpiratoryVolume(items: items)
        return model
    }
    
    public func forcedVitalCapacity(from dateRange: DateRangeType) async throws -> ForcedVitalCapacity {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .forcedVitalCapacity, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> ForcedVitalCapacity.Item in
            let liters = item.quantity.doubleValue(for: HKUnit.liter())
            return ForcedVitalCapacity.Item(liters: liters, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = ForcedVitalCapacity(items: items)
        return model
    }

    public func inhalerUsage(from dateRange: DateRangeType) async throws -> InhalerUsage {
        try await baseInhalerUsage(from: dateRange)
    }
    
    public func peakExpiratoryFlowRate(from dateRange: DateRangeType) async throws -> PeakExpiratoryFlowRate {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .peakExpiratoryFlowRate, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> PeakExpiratoryFlowRate.Item in
            let litersPerMin = item.quantity.doubleValue(for: HKUnit(from: "L/min"))
            return PeakExpiratoryFlowRate.Item(litersPerMinute: litersPerMin, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = PeakExpiratoryFlowRate(items: items)
        return model
    }
    
    public func respiratoryRate(from dateRange: DateRangeType) async throws -> RespiratoryRate {
        try await baseRespiratoryRate(from: dateRange)
    }

    public func sixMinuteWalk(from dateRange: DateRangeType) async throws -> SixMinuteWalk {
        try await baseSixMinuteWalk(from: dateRange)
    }

     // MARK: Saving

    public func saveBloodOxygen(model: BloodOxygen, extra: [String: Sendable]?) async throws {
        try await saveBaseBloodOxygen(model: model, extra: extra)
    }

    public func saveForcedExpiratoryVolume(model: ForcedExpiratoryVolume, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .forcedExpiratoryVolume1)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .liter(), doubleValue: $0.liters)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveForcedVitalCapacity(model: ForcedVitalCapacity, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .forcedVitalCapacity)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .liter(), doubleValue: $0.liters)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveInhalerUsage(model: InhalerUsage, extra: [String: Sendable]?) async throws {
        try await saveBaseInhalerUsage(model: model, extra: extra)
    }

    public func savePeakExpiratoryFlowRate(model: PeakExpiratoryFlowRate, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .peakExpiratoryFlowRate)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: "L/min")
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.litersPerMinute)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveRespiratoryRate(model: RespiratoryRate, extra: [String: Sendable]?) async throws {
        try await saveBaseRespiratoryRate(model: model, extra: extra)
    }

    public func saveSixMinuteWalk(model: SixMinuteWalk, extra: [String: Sendable]?) async throws {
        try await saveBaseSixMinuteWalk(model, extra: extra)
    }
}
