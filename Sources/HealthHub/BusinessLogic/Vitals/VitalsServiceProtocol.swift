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
    func bloodGlucose() async throws -> BloodGlucose
    func bloodOxygen() async throws -> BloodOxygen
    func bloodPressure() async throws -> BloodPressure
    func bodyTemperature() async throws -> BodyTemperature
    func menstruation() async throws -> Menstruation
    func respiratoryRate() async throws -> RespiratoryRate

    // Save
    func saveBloodGlucose(model: BloodGlucose, extra: [String: Sendable]?) async throws
    func saveBloodOxygen(model: BloodOxygen, extra: [String: Sendable]?) async throws
    func saveBloodPressure(model: BloodPressure, extra: [String: Sendable]?) async throws
    func saveBodyTemperature(model: BodyTemperature, extra: [String: Sendable]?) async throws
    func saveMenstruation(model: Menstruation, extra: [String: Sendable]?) async throws
    func saveRespiratoryRate(model: RespiratoryRate, extra: [String: Sendable]?) async throws
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

