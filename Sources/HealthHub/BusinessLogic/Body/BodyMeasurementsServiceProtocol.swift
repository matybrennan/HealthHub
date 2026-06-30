//
//  BodyMeasurementsServiceProtocol.swift
//  HealthHub
//
//  Created by matybrennan on 20/9/19.
//

import Foundation

public enum BodyMeasurementType: String, CaseIterable, Sendable {
    case basalBodyTemperature
    case bodyFatPercentage
    case bodyMassIndex
    case bodyTemperature
    case electrodermalActivity
    case height
    case leanBodyMass
    case waistCircumference
    case weight
    case wristTemperature

    public var displayName: String {
        switch self {
        case .basalBodyTemperature: "Basal Body Temperature"
        case .bodyFatPercentage: "Body Fat Percentage"
        case .bodyMassIndex: "Body Mass Index (BMI)"
        case .bodyTemperature: "Body Temperature"
        case .electrodermalActivity: "Electrodermal Activity"
        case .height: "Height"
        case .leanBodyMass: "Lean Body Mass"
        case .waistCircumference: "Waist Circumference"
        case .weight: "Weight"
        case .wristTemperature: "Wrist Temperature"
        }
    }

    public var unit: String {
        switch self {
        case .basalBodyTemperature: "°C"
        case .bodyFatPercentage: "%"
        case .bodyMassIndex: "kg/m²"
        case .bodyTemperature: "°C"
        case .electrodermalActivity: "μS"
        case .height: "cm"
        case .leanBodyMass: "kg"
        case .waistCircumference: "cm"
        case .weight: "kg"
        case .wristTemperature: "°C"
        }
    }

    /// Whether this type can be saved by third-party apps
    public var isSaveable: Bool {
        switch self {
        case .wristTemperature: false
        default: true
        }
    }
}

public protocol BodyMeasurementsServiceProtocol {

    // Fetch
    func basalBodyTemperature(from dateRange: DateRangeType) async throws -> BasalBodyTemperature
    func bodyFatPercentage(from dateRange: DateRangeType) async throws -> BodyFatPercentage
    func bodyMassIndex(from dateRange: DateRangeType) async throws -> BodyMassIndex
    func bodyTemperature(from dateRange: DateRangeType) async throws -> BodyTemperature
    func electrodermalActivity(from dateRange: DateRangeType) async throws -> ElectrodermalActivity
    func height(from dateRange: DateRangeType) async throws -> BodyHeight
    func leanBodyMass(from dateRange: DateRangeType) async throws -> LeanBodyMass
    func waistCircumference(from dateRange: DateRangeType) async throws -> WaistCircumference
    func weight(from dateRange: DateRangeType) async throws -> BodyWeight
    func wristTemperature(from dateRange: DateRangeType) async throws -> WristTemperature // Cant save prohibited in healthkit

    // Save
    func saveBasalBodyTemperature(model: BasalBodyTemperature, extra: [String: Sendable]?) async throws
    func saveBodyFatPercentage(model: BodyFatPercentage, extra: [String: Sendable]?) async throws
    func saveBodyMassIndex(model: BodyMassIndex, extra: [String: Sendable]?) async throws
    func saveBodyTemperature(model: BodyTemperature, extra: [String: Sendable]?) async throws
    func saveElectrodermalActivity(model: ElectrodermalActivity, extra: [String: Sendable]?) async throws
    func saveHeight(model: BodyHeight, extra: [String: Sendable]?) async throws
    func saveLeanBodyMass(model: LeanBodyMass, extra: [String: Sendable]?) async throws
    func saveWaistCircumference(model: WaistCircumference, extra: [String: Sendable]?) async throws
    func saveWeight(model: BodyWeight, extra: [String: Sendable]?) async throws
}

// MARK: - Default date range (backwards compatibility)

public extension BodyMeasurementsServiceProtocol {
    func basalBodyTemperature() async throws -> BasalBodyTemperature { try await basalBodyTemperature(from: .allTime) }
    func bodyFatPercentage() async throws -> BodyFatPercentage { try await bodyFatPercentage(from: .allTime) }
    func bodyMassIndex() async throws -> BodyMassIndex { try await bodyMassIndex(from: .allTime) }
    func bodyTemperature() async throws -> BodyTemperature { try await bodyTemperature(from: .allTime) }
    func electrodermalActivity() async throws -> ElectrodermalActivity { try await electrodermalActivity(from: .allTime) }
    func height() async throws -> BodyHeight { try await height(from: .allTime) }
    func leanBodyMass() async throws -> LeanBodyMass { try await leanBodyMass(from: .allTime) }
    func waistCircumference() async throws -> WaistCircumference { try await waistCircumference(from: .allTime) }
    func weight() async throws -> BodyWeight { try await weight(from: .allTime) }
    func wristTemperature() async throws -> WristTemperature { try await wristTemperature(from: .allTime) }
}
