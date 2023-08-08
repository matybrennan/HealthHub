//
//  RespiratoryService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation
import HealthKit

public class RespiratoryService {
    
    public init() { }
}

// MARK: - FetchQuantitySample
extension RespiratoryService: FetchQuantitySample, RespiratoryRateCase, BloodOxygenCase, InhalerUsageCase { }

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
}
