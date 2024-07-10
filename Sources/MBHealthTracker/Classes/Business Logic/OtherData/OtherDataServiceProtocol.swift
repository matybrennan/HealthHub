//
//  OtherDataServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation

@MainActor
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
    func saveAlcoholConsumption(model: AlcoholConsumption, extra: [String: Any]?) async throws
    func saveBloodAlcoholContent(model: AlcoholContent, extra: [String: Any]?) async throws
    func saveBloodGlucose(model: BloodGlucose, extra: [String: Any]?) async throws
    func saveHandWashing(model: HandWashing, extra: [String: Any]?) async throws
    func saveInhalerUsage(model: InhalerUsage, extra: [String: Any]?) async throws
    func saveInsulinDelivery(model: InsulinDelivery, extra: [String: Any]?) async throws
    func saveNumberOfTimesFallen(model: NumberOfTimesFallen, extra: [String: Any]?) async throws
    func saveSexualActivity(model: SexualActivity, extra: [String: Any]?) async throws
    func saveToothBrushing(model: ToothBrushing, extra: [String: Any]?) async throws
    func saveTimeInDaylight(model: TimeInDaylight, extra: [String: Any]?) async throws
    func saveUvExposure(model: UVExposure, extra: [String: Any]?) async throws
    func saveWaterTemperature(model: WaterTemperature, extra: [String: Any]?) async throws
}
