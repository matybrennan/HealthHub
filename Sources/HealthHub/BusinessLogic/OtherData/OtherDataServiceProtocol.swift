//
//  OtherDataServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation
import HealthKit

public enum OtherDataType: String, CaseIterable, Sendable {

    // Alcohol
    case alcoholConsumption
    case bloodAlcoholContent

    // Hygiene
    case handWashing
    case toothBrushing

    // Diabetes
    case bloodGlucose
    case insulinDelivery

    // Safety
    case numberOfTimesFallen

    // Reproductive
    case sexualActivity

    // Respiratory
    case inhalerUsage

    // Environment
    case timeInDaylight
    case uvExposure
    case waterTemperature

    // Hearing
    case environmentalAudioExposure
    case headphoneAudioExposure

    public enum Category: String, CaseIterable, Sendable {
        case alcohol
        case hygiene
        case diabetes
        case safety
        case reproductive
        case respiratory
        case environment
        case hearing
    }

    public var displayName: String {
        switch self {
        case .alcoholConsumption: "Alcohol Consumption"
        case .bloodAlcoholContent: "Blood Alcohol Content"
        case .handWashing: "Handwashing"
        case .toothBrushing: "Toothbrushing"
        case .bloodGlucose: "Blood Glucose"
        case .insulinDelivery: "Insulin Delivery"
        case .numberOfTimesFallen: "Number of Times Fallen"
        case .sexualActivity: "Sexual Activity"
        case .inhalerUsage: "Inhaler Usage"
        case .timeInDaylight: "Time in Daylight"
        case .uvExposure: "UV Index"
        case .waterTemperature: "Water Temperature"
        case .environmentalAudioExposure: "Environmental Sound Levels"
        case .headphoneAudioExposure: "Headphone Audio Levels"
        }
    }

    public var unit: String {
        switch self {
        case .alcoholConsumption: "drinks"
        case .bloodAlcoholContent: "%"
        case .handWashing: "events"
        case .toothBrushing: "events"
        case .bloodGlucose: "mg/dL"
        case .insulinDelivery: "IU"
        case .numberOfTimesFallen: "times"
        case .sexualActivity: "events"
        case .inhalerUsage: "uses"
        case .timeInDaylight: "min"
        case .uvExposure: "UV Index"
        case .waterTemperature: "°C"
        case .environmentalAudioExposure: "dBASPL"
        case .headphoneAudioExposure: "dBASPL"
        }
    }

    public var category: Category {
        switch self {
        case .alcoholConsumption, .bloodAlcoholContent: .alcohol
        case .handWashing, .toothBrushing: .hygiene
        case .bloodGlucose, .insulinDelivery: .diabetes
        case .numberOfTimesFallen: .safety
        case .sexualActivity: .reproductive
        case .inhalerUsage: .respiratory
        case .timeInDaylight, .uvExposure, .waterTemperature: .environment
        case .environmentalAudioExposure, .headphoneAudioExposure: .hearing
        }
    }
}

public protocol OtherDataServiceProtocol {

    // Fetch
    func alcoholConsumption() async throws -> AlcoholConsumption
    func bloodAlcoholContent() async throws -> AlcoholContent
    func bloodGlucose() async throws -> BloodGlucose
    func environmentalAudioExposure() async throws -> EnvironmentalAudioExposure
    func handWashing() async throws -> HandWashing
    func headphoneAudioExposure() async throws -> HeadphoneAudioExposure
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
