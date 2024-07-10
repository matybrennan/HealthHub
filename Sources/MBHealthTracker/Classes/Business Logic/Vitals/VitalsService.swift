//
//  VitalsService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 9/12/19.
//

import Foundation
import HealthKit

public final class VitalsService {
    
    public init() { }
}

// MARK: - FetchQuantitySample & FetchCorrelationSample
extension VitalsService: FetchQuantitySample, FetchCorrelationSample, RespiratoryRateCase, BodyTemperatureCase, MenstruationCase, BloodGlucoseCase, BloodOxygenCase, BloodPressureCase { }

// MARK: - VitalsServiceProtocol
extension VitalsService: VitalsServiceProtocol {
    
    public func bloodGlucose() async throws -> BloodGlucose {
        try await baseBloodGlucose()
    }
    
    public func bloodPressure() async throws -> BloodPressure {
        try await baseBloodPressure()
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
        try await baseSaveBloodPressure(model: model, extra: extra)
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

