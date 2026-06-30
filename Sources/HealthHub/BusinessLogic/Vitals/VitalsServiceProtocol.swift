//
//  VitalsServiceProtocol.swift
//  HealthHub
//
//  Created by matybrennan on 9/12/19.
//

import Foundation
import HealthKit

public protocol VitalsServiceProtocol {

    // Fetch
    func bloodGlucose(from dateRange: DateRangeType) async throws -> BloodGlucose
    func bloodOxygen(from dateRange: DateRangeType) async throws -> BloodOxygen
    func bloodPressure(from dateRange: DateRangeType) async throws -> BloodPressure
    func bodyTemperature(from dateRange: DateRangeType) async throws -> BodyTemperature
    func menstruation(from dateRange: DateRangeType) async throws -> Menstruation
    func respiratoryRate(from dateRange: DateRangeType) async throws -> RespiratoryRate

    // Save
    func saveBloodGlucose(model: BloodGlucose, extra: [String: Sendable]?) async throws
    func saveBloodOxygen(model: BloodOxygen, extra: [String: Sendable]?) async throws
    func saveBloodPressure(model: BloodPressure, extra: [String: Sendable]?) async throws
    func saveBodyTemperature(model: BodyTemperature, extra: [String: Sendable]?) async throws
    func saveMenstruation(model: Menstruation, extra: [String: Sendable]?) async throws
    func saveRespiratoryRate(model: RespiratoryRate, extra: [String: Sendable]?) async throws
}

// MARK: - Default date range (backwards compatibility)

public extension VitalsServiceProtocol {
    func bloodGlucose() async throws -> BloodGlucose { try await bloodGlucose(from: .allTime) }
    func bloodOxygen() async throws -> BloodOxygen { try await bloodOxygen(from: .allTime) }
    func bloodPressure() async throws -> BloodPressure { try await bloodPressure(from: .allTime) }
    func bodyTemperature() async throws -> BodyTemperature { try await bodyTemperature(from: .allTime) }
    func menstruation() async throws -> Menstruation { try await menstruation(from: .allTime) }
    func respiratoryRate() async throws -> RespiratoryRate { try await respiratoryRate(from: .allTime) }
}

public enum VitalType: CaseIterable, Sendable {
    case bloodGlucose
    case bloodOxygen
    case bloodPressure
    case bodyTemperature
    case menstruation
    case respiratoryRate

    public var displayName: String {
        switch self {
        case .bloodGlucose: return "Blood Glucose"
        case .bloodOxygen: return "Blood Oxygen"
        case .bloodPressure: return "Blood Pressure"
        case .bodyTemperature: return "Body Temperature"
        case .menstruation: return "Menstruation"
        case .respiratoryRate: return "Respiratory Rate"
        }
    }

    public var unit: String {
        switch self {
        case .bloodGlucose: return "mg/dL"
        case .bloodOxygen: return "%"
        case .bloodPressure: return "mmHg"
        case .bodyTemperature: return "°C"
        case .menstruation: return ""
        case .respiratoryRate: return "breaths/min"
        }
    }
}

