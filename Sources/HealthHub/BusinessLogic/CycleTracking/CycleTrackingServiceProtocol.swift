//
//  CycleTrackingProtocol.swift
//  HealthHub
//
//  Created by matybrennan on 27/9/19.
//

import Foundation

public enum CycleTrackingType: String, CaseIterable, Sendable {

    // Symptoms
    case abdominalCramps
    case bloating
    case breastPain
    case moodChanges
    case vaginalDryness

    // Tracking
    case cervicalMucusQuality
    case contraceptive
    case bleedingAfterPregnancy
    case bleedingDuringPregnancy
    case lactation
    case menstruation
    case ovulation
    case pregnancy
    case pregnancyTestResult
    case progesteroneTestResult
    case sexualActivity
    case spotting

    // Notifications (read-only)
    case infrequentMenstrualCycles
    case irregularMenstrualCycles
    case persistentIntermenstrualBleeding
    case prolongedMenstrualPeriods

    public enum Category: String, CaseIterable, Sendable {
        case symptoms = "Symptoms"
        case tracking = "Tracking"
        case notifications = "Notifications"
    }

    public var category: Category {
        switch self {
        case .abdominalCramps, .bloating, .breastPain, .moodChanges, .vaginalDryness:
            return .symptoms
        case .cervicalMucusQuality, .contraceptive, .bleedingAfterPregnancy, .bleedingDuringPregnancy,
             .lactation, .menstruation, .ovulation,
             .pregnancy, .pregnancyTestResult, .progesteroneTestResult, .sexualActivity, .spotting:
            return .tracking
        case .infrequentMenstrualCycles, .irregularMenstrualCycles,
             .persistentIntermenstrualBleeding, .prolongedMenstrualPeriods:
            return .notifications
        }
    }

    public var displayName: String {
        switch self {
        case .abdominalCramps: "Abdominal Cramps"
        case .bloating: "Bloating"
        case .breastPain: "Breast Pain"
        case .bleedingAfterPregnancy: "Bleeding After Pregnancy"
        case .bleedingDuringPregnancy: "Bleeding During Pregnancy"
        case .cervicalMucusQuality: "Cervical Mucus Quality"
        case .contraceptive: "Contraceptive"
        case .lactation: "Lactation"
        case .menstruation: "Menstruation"
        case .moodChanges: "Mood Changes"
        case .ovulation: "Ovulation Test Result"
        case .pregnancy: "Pregnancy"
        case .pregnancyTestResult: "Pregnancy Test Result"
        case .progesteroneTestResult: "Progesterone Test Result"
        case .sexualActivity: "Sexual Activity"
        case .spotting: "Spotting"
        case .vaginalDryness: "Vaginal Dryness"
        case .infrequentMenstrualCycles: "Infrequent Menstrual Cycles"
        case .irregularMenstrualCycles: "Irregular Menstrual Cycles"
        case .persistentIntermenstrualBleeding: "Persistent Intermenstrual Bleeding"
        case .prolongedMenstrualPeriods: "Prolonged Menstrual Periods"
        }
    }

    /// Whether this type can be saved by third-party apps
    public var isSaveable: Bool {
        switch self {
        case .infrequentMenstrualCycles, .irregularMenstrualCycles,
             .persistentIntermenstrualBleeding, .prolongedMenstrualPeriods:
            false
        default:
            true
        }
    }
}

public protocol CycleTrackingProtocol {

    // Fetch
    func abdominalCramps() async throws -> GenericSymptomModel
    func bloating() async throws -> GenericSymptomModel
    func breastPain() async throws -> GenericSymptomModel
    func bleedingAfterPregnancy() async throws -> BleedingAfterPregnancy
    func bleedingDuringPregnancy() async throws -> BleedingDuringPregnancy
    func cervicalMucusQuality() async throws -> CervicalMucusQuality
    func contraceptive() async throws -> Contraceptive
    func lactation() async throws -> Lactation
    func menstruation() async throws -> Menstruation
    func moodChanges() async throws -> GenericSymptomModel
    func ovulation() async throws -> Ovulation
    func pregnancy() async throws -> Pregnancy
    func pregnancyTestResult() async throws -> PregnancyTestResult
    func progesteroneTestResult() async throws -> ProgesteroneTestResult
    func sexualActivity() async throws -> SexualActivity
    func spotting() async throws -> Spotting
    func vaginalDryness() async throws -> GenericSymptomModel

    // Cycle Notifications (read-only)
    func infrequentMenstrualCycles() async throws -> CycleNotification
    func irregularMenstrualCycles() async throws -> CycleNotification
    func persistentIntermenstrualBleeding() async throws -> CycleNotification
    func prolongedMenstrualPeriods() async throws -> CycleNotification

    // Save
    func saveAbdominalCramps(model: GenericSymptomModel, extra: [String: Sendable]?) async throws
    func saveBloating(model: GenericSymptomModel, extra: [String: Sendable]?) async throws
    func saveBreastPain(model: GenericSymptomModel, extra: [String: Sendable]?) async throws
    func saveBleedingAfterPregnancy(model: BleedingAfterPregnancy, extra: [String: Sendable]?) async throws
    func saveBleedingDuringPregnancy(model: BleedingDuringPregnancy, extra: [String: Sendable]?) async throws
    func saveCervicalMucusQuality(model: CervicalMucusQuality, extra: [String: Sendable]?) async throws
    func saveContraceptive(model: Contraceptive, extra: [String: Sendable]?) async throws
    func saveLactation(model: Lactation, extra: [String: Sendable]?) async throws
    func saveMenstruation(model: Menstruation, extra: [String: Sendable]?) async throws
    func saveMoodChanges(model: GenericSymptomModel, extra: [String: Sendable]?) async throws
    func saveOvulation(model: Ovulation, extra: [String: Sendable]?) async throws
    func savePregnancy(model: Pregnancy, extra: [String: Sendable]?) async throws
    func savePregnancyTestResult(model: PregnancyTestResult, extra: [String: Sendable]?) async throws
    func saveProgesteroneTestResult(model: ProgesteroneTestResult, extra: [String: Sendable]?) async throws
    func saveSexualActivity(model: SexualActivity, extra: [String: Sendable]?) async throws
    func saveSpotting(model: Spotting, extra: [String: Sendable]?) async throws
    func saveVaginalDryness(model: GenericSymptomModel, extra: [String: Sendable]?) async throws
}
