//
//  OtherDataServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation

public protocol OtherDataServiceProtocol: Sendable {

    // Fetch
    func alcoholConsumption() async throws -> AlcoholConsumption
    func bloodAlcoholContent() async throws -> AlcoholContent
    func bloodGlucose() async throws -> BloodGlucose
    func handWashing() async throws -> HandWashing
    func inhalerUsage() async throws -> InhalerUsage
    func insulinDelivery() async throws -> InsulinDelivery
    func numberOfTimesFallen() async throws -> NumberOfTimesFallen
    func sexualActivity() async throws -> SexualActivity
    func toothBrushing() async throws -> ToothBrushing
    func timeInDaylight() async throws -> TimeInDaylight
    func uvExposure() async throws -> UVExposure
    func waterTemperature() async throws -> WaterTemperature

    // Save
    func saveAlcoholConsumption(model: AlcoholConsumption, extra: [String: Sendable]?) async throws
    func saveBloodAlcoholContent(model: AlcoholContent, extra: [String: Sendable]?) async throws
    func saveBloodGlucose(model: BloodGlucose, extra: [String: Sendable]?) async throws
    func saveHandWashing(model: HandWashing, extra: [String: Sendable]?) async throws
    func saveInhalerUsage(model: InhalerUsage, extra: [String: Sendable]?) async throws
    func saveInsulinDelivery(model: InsulinDelivery, extra: [String: Sendable]?) async throws
    func saveNumberOfTimesFallen(model: NumberOfTimesFallen, extra: [String: Sendable]?) async throws
    func saveSexualActivity(model: SexualActivity, extra: [String: Sendable]?) async throws
    func saveToothBrushing(model: ToothBrushing, extra: [String: Sendable]?) async throws
    func saveTimeInDaylight(model: TimeInDaylight, extra: [String: Sendable]?) async throws
    func saveUvExposure(model: UVExposure, extra: [String: Sendable]?) async throws
    func saveWaterTemperature(model: WaterTemperature, extra: [String: Sendable]?) async throws
}
