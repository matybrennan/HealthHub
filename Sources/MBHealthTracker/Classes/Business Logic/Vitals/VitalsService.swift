//
//  VitalsService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 9/12/19.
//

import Foundation
import HealthKit

public class VitalsService {
    
    public init() { }
}

// MARK: - FetchQuantitySample & FetchCorrelationSample
extension VitalsService: FetchQuantitySample, FetchCorrelationSample, RespiratoryRateCase, BodyTemperatureCase, MenstruationCase, BloodGlucoseCase { }

// MARK: - VitalsServiceProtocol
extension VitalsService: VitalsServiceProtocol {
    
    public func bloodGlucose() async throws -> BloodGlucose {
        try await baseBloodGlucose()
    }
    
    public func bloodPressure() async throws -> BloodPressure {
        let bloodPressureSystolicType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bloodPressureSystolic)
        let bloodPressureDiastolicType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bloodPressureDiastolic)
        let samples = try await fetchCorrelationSamples(correlationIdentifier: .bloodPressure)
        let items = samples.compactMap { item -> BloodPressure.Info? in
            guard let systolic = item.objects(for: bloodPressureSystolicType).first as? HKQuantitySample else { return nil }
            guard let diastolic = item.objects(for: bloodPressureDiastolicType).first as? HKQuantitySample else { return nil }
            
            let value1 = systolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
            let value2 = diastolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
            
            return BloodPressure.Info(systolic: value1, diastolic: value2, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = BloodPressure(items: items)
        return model
    }
    
    public func bloodOxygen() async throws -> BloodOxygen {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .oxygenSaturation)
        let items = samples.map { item -> BloodOxygen.Item in
            let percentage = item.quantity.doubleValue(for: .percent())
            return BloodOxygen.Item(date: item.startDate, oxygenSaturationPercentage: percentage)
        }
        
        let model = BloodOxygen(items: items)
        return model
    }
    
    public func bodyTemperature() async throws -> BodyTemperature {
        try await baseBodyTemperature()
    }
    
    public func menstruation() async throws -> Menstruation {
        try await baseMenstruation()
    }
    
    public func respiratoryRate() async throws -> RespiratoryRate {
        try await baseRespiratoryRate()
    }
}

