//
//  BodyMeasurementsServiceProtocol.swift
//  HealthHub
//
//  Created by matybrennan on 20/9/19.
//

import Foundation

public protocol BodyMeasurementsServiceProtocol: Sendable {

    // Fetch
    func basalBodyTemperature() async throws -> BasalBodyTemperature
    func bodyFatPercentage() async throws -> BodyFatPercentage
    func bodyMassIndex() async throws -> BodyMassIndex
    func bodyTemperature() async throws -> BodyTemperature
    func electrodermalActivity() async throws -> ElectrodermalActivity
    func height() async throws -> BodyHeight
    func leanBodyMass() async throws -> LeanBodyMass
    func waistCircumference() async throws -> WaistCircumference
    func weight() async throws -> BodyWeight
    func wristTemperature() async throws -> WristTemperature // Cant save prohibited in healthkit

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
