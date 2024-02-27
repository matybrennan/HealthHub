//
//  BodyMeasurementsServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 20/9/19.
//

import Foundation

public protocol BodyMeasurementsServiceProtocol: AnyObject {
    
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
    func saveBasalBodyTemperature(model: BasalBodyTemperature) async throws
    func saveBodyFatPercentage(model: BodyFatPercentage) async throws
    func saveBodyMassIndex(model: BodyMassIndex) async throws
    func saveBodyTemperature(model: BodyTemperature) async throws
    func saveElectrodermalActivity(model: ElectrodermalActivity) async throws
    func saveHeight(model: BodyHeight) async throws
    func saveLeanBodyMass(model: LeanBodyMass) async throws
    func saveWaistCircumference(model: WaistCircumference) async throws
    func saveWeight(model: BodyWeight) async throws
}
