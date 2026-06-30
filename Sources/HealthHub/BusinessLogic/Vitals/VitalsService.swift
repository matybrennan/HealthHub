//
//  VitalsService.swift
//  HealthHub
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
    
    public func bloodGlucose(from dateRange: DateRangeType) async throws -> BloodGlucose {
        try await baseBloodGlucose(from: dateRange)
    }
    
    public func bloodPressure(from dateRange: DateRangeType) async throws -> BloodPressure {
        try await baseBloodPressure(from: dateRange)
    }
    
    public func bloodOxygen(from dateRange: DateRangeType) async throws -> BloodOxygen {
        try await baseBloodOxygen(from: dateRange)
    }
    
    public func bodyTemperature(from dateRange: DateRangeType) async throws -> BodyTemperature {
        try await baseBodyTemperature(from: dateRange)
    }
    
    public func menstruation(from dateRange: DateRangeType) async throws -> Menstruation {
        try await baseMenstruation(from: dateRange)
    }
    
    public func respiratoryRate(from dateRange: DateRangeType) async throws -> RespiratoryRate {
        try await baseRespiratoryRate(from: dateRange)
    }

    // MARK: - Saving

    public func saveBloodGlucose(model: BloodGlucose, extra: [String: Sendable]?) async throws {
        try await saveBaseBloodGlucose(model: model, extra: extra)
    }

    public func saveBloodOxygen(model: BloodOxygen, extra: [String: Sendable]?) async throws {
        try await saveBaseBloodOxygen(model: model, extra: extra)
    }

    public func saveBloodPressure(model: BloodPressure, extra: [String: Sendable]?) async throws {
        try await baseSaveBloodPressure(model: model, extra: extra)
    }

    public func saveBodyTemperature(model: BodyTemperature, extra: [String: Sendable]?) async throws {
        try await saveBaseBodyTemperature(model: model, extra: extra)
    }

    public func saveMenstruation(model: Menstruation, extra: [String: Sendable]?) async throws {
        try await saveBaseMenstruation(model, extra: extra)
    }

    public func saveRespiratoryRate(model: RespiratoryRate, extra: [String: Sendable]?) async throws {
        try await saveBaseRespiratoryRate(model: model, extra: extra)
    }
}

