//
//  VitalsServiceProtocol.swift
//  HealthHub
//
//  Created by matybrennan on 9/12/19.
//

import Foundation

public protocol VitalsServiceProtocol: Sendable {

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

