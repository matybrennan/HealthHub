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
extension VitalsService: FetchQuantitySample, FetchCorrelationSample, RespiratoryRateCase, BodyTemperatureCase, MenstruationCase, BloodGlucoseCase, BloodOxygenCase { }

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
        try await baseBloodOxygen()
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

    // MARK: - Saving

    public func saveBloodGlucose(model: BloodGlucose, extra: [String : Any]?) async throws {
        try await saveBaseBloodGlucose(model: model, extra: extra)
    }

    public func saveBloodOxygen(model: BloodOxygen, extra: [String : Any]?) async throws {
        try await saveBaseBloodOxygen(model: model, extra: extra)
    }

    public func saveBloodPressure(model: BloodPressure, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(correlationIdentifier: .bloodPressure)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.millimeterOfMercury()
        let sampleObjects = model.items.map {
            let systolicQuantity = HKQuantity(unit: unit, doubleValue: $0.systolic)
            let diastolicQuantity = HKQuantity(unit: unit, doubleValue: $0.diastolic)

            let systolicType = HKQuantityType(.bloodPressureSystolic)
            let diastolicType = HKQuantityType(.bloodPressureDiastolic)

            let systolicSample = HKQuantitySample(type: systolicType, quantity: systolicQuantity, start: $0.startDate, end: $0.endDate)
            let diastolicSample = HKQuantitySample(type: diastolicType, quantity: diastolicQuantity, start: $0.startDate, end: $0.endDate)
            let objects: Set<HKSample> = [systolicSample, diastolicSample]

            return HKCorrelation(type: type, start: $0.startDate, end: $0.endDate, objects: objects, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveBodyTemperature(model: BodyTemperature, extra: [String : Any]?) async throws {
        try await saveBaseBodyTemperature(model: model, extra: extra)
    }

    public func saveMenstruation(model: Menstruation, extra: [String : Any]?) async throws {
        try await saveBaseMenstruation(model, extra: extra)
    }

    public func saveRespiratoryRate(model: RespiratoryRate, extra: [String : Any]?) async throws {
        try await saveBaseRespiratoryRate(model: model, extra: extra)
    }
}

