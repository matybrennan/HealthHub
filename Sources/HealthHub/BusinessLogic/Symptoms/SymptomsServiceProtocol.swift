//
//  SymptomsServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation
import HealthKit

public protocol SymptomsServiceProtocol {

    // Fetch
    func symptom(type: SymptomType) async throws -> GenericSymptomModel
    func appetiteChanges() async throws -> AppetiteChanges

    // Save
    func saveSymptom(type: SymptomType, model: GenericSymptomModel, extra: [String: Sendable]?) async throws
    func saveAppetiteChanges(model: AppetiteChanges, extra: [String: Sendable]?) async throws
}

public enum SymptomType: CaseIterable, Sendable {

    // Gastrointestinal
    case abdominalCramps
    case bloating
    case constipation
    case diarrhea
    case heartBurn
    case nausea
    case vomiting

    // Pain
    case bodyAndMuscleAche
    case breastPain
    case chestTightnessOrPain
    case headache
    case lowerBackPain
    case pelvicPain

    // Skin & Hair
    case acne
    case drySkin
    case hairLoss

    // Cardiovascular
    case rapidPoundingOrFlutteringHeartbeat
    case skippedHeartbeat

    // Respiratory
    case congestion
    case coughing
    case runnyNose
    case shortnessOfBreath
    case soreThroat
    case wheezing

    // Neurological & Mental
    case dizziness
    case fainting
    case fatigue
    case memoryLapse
    case moodChanges
    case sleepChanges

    // Constitutional
    case chills
    case fever
    case hotFlushes
    case nightSweats

    // Urogenital
    case bladderIncontinence
    case vaginalDryness

    // Sensory
    case lossOfSmell
    case lossOfTaste

    // MARK: - Category

    public enum Category: String, CaseIterable, Sendable {
        case gastrointestinal = "Gastrointestinal"
        case pain = "Pain"
        case skinAndHair = "Skin & Hair"
        case cardiovascular = "Cardiovascular"
        case respiratory = "Respiratory"
        case neurologicalAndMental = "Neurological & Mental"
        case constitutional = "Constitutional"
        case urogenital = "Urogenital"
        case sensory = "Sensory"
    }

    public var category: Category {
        switch self {
        case .abdominalCramps, .bloating, .constipation, .diarrhea, .heartBurn, .nausea, .vomiting:
            return .gastrointestinal
        case .bodyAndMuscleAche, .breastPain, .chestTightnessOrPain, .headache, .lowerBackPain, .pelvicPain:
            return .pain
        case .acne, .drySkin, .hairLoss:
            return .skinAndHair
        case .rapidPoundingOrFlutteringHeartbeat, .skippedHeartbeat:
            return .cardiovascular
        case .congestion, .coughing, .runnyNose, .shortnessOfBreath, .soreThroat, .wheezing:
            return .respiratory
        case .dizziness, .fainting, .fatigue, .memoryLapse, .moodChanges, .sleepChanges:
            return .neurologicalAndMental
        case .chills, .fever, .hotFlushes, .nightSweats:
            return .constitutional
        case .bladderIncontinence, .vaginalDryness:
            return .urogenital
        case .lossOfSmell, .lossOfTaste:
            return .sensory
        }
    }

    // MARK: - Display Name

    public var displayName: String {
        switch self {
        case .abdominalCramps: return "Abdominal Cramps"
        case .acne: return "Acne"
        case .bladderIncontinence: return "Bladder Incontinence"
        case .bloating: return "Bloating"
        case .bodyAndMuscleAche: return "Body & Muscle Ache"
        case .breastPain: return "Breast Pain"
        case .chestTightnessOrPain: return "Chest Tightness or Pain"
        case .chills: return "Chills"
        case .congestion: return "Congestion"
        case .constipation: return "Constipation"
        case .coughing: return "Coughing"
        case .diarrhea: return "Diarrhea"
        case .dizziness: return "Dizziness"
        case .drySkin: return "Dry Skin"
        case .fainting: return "Fainting"
        case .fatigue: return "Fatigue"
        case .fever: return "Fever"
        case .hairLoss: return "Hair Loss"
        case .headache: return "Headache"
        case .heartBurn: return "Heartburn"
        case .hotFlushes: return "Hot Flashes"
        case .lossOfSmell: return "Loss of Smell"
        case .lossOfTaste: return "Loss of Taste"
        case .lowerBackPain: return "Lower Back Pain"
        case .memoryLapse: return "Memory Lapse"
        case .moodChanges: return "Mood Changes"
        case .nausea: return "Nausea"
        case .nightSweats: return "Night Sweats"
        case .pelvicPain: return "Pelvic Pain"
        case .rapidPoundingOrFlutteringHeartbeat: return "Rapid, Pounding, or Fluttering Heartbeat"
        case .runnyNose: return "Runny Nose"
        case .shortnessOfBreath: return "Shortness of Breath"
        case .skippedHeartbeat: return "Skipped Heartbeat"
        case .sleepChanges: return "Sleep Changes"
        case .soreThroat: return "Sore Throat"
        case .vaginalDryness: return "Vaginal Dryness"
        case .vomiting: return "Vomiting"
        case .wheezing: return "Wheezing"
        }
    }

    // MARK: - Category Type

    public var categoryType: HKCategoryType {
        switch self {
        case .abdominalCramps: HKCategoryType(.abdominalCramps)
        case .acne: HKCategoryType(.acne)
        case .bladderIncontinence: HKCategoryType(.bladderIncontinence)
        case .bloating: HKCategoryType(.bloating)
        case .bodyAndMuscleAche: HKCategoryType(.generalizedBodyAche)
        case .breastPain: HKCategoryType(.breastPain)
        case .chestTightnessOrPain: HKCategoryType(.chestTightnessOrPain)
        case .chills: HKCategoryType(.chills)
        case .congestion: HKCategoryType(.sinusCongestion)
        case .constipation: HKCategoryType(.constipation)
        case .coughing: HKCategoryType(.coughing)
        case .diarrhea: HKCategoryType(.diarrhea)
        case .dizziness: HKCategoryType(.dizziness)
        case .drySkin: HKCategoryType(.drySkin)
        case .fainting: HKCategoryType(.fainting)
        case .fatigue: HKCategoryType(.fatigue)
        case .fever: HKCategoryType(.fever)
        case .hairLoss: HKCategoryType(.hairLoss)
        case .headache: HKCategoryType(.headache)
        case .heartBurn: HKCategoryType(.heartburn)
        case .hotFlushes: HKCategoryType(.hotFlashes)
        case .lossOfSmell: HKCategoryType(.lossOfSmell)
        case .lossOfTaste: HKCategoryType(.lossOfTaste)
        case .lowerBackPain: HKCategoryType(.lowerBackPain)
        case .memoryLapse: HKCategoryType(.memoryLapse)
        case .moodChanges: HKCategoryType(.moodChanges)
        case .nausea: HKCategoryType(.nausea)
        case .nightSweats: HKCategoryType(.nightSweats)
        case .pelvicPain: HKCategoryType(.pelvicPain)
        case .rapidPoundingOrFlutteringHeartbeat: HKCategoryType(.rapidPoundingOrFlutteringHeartbeat)
        case .runnyNose: HKCategoryType(.runnyNose)
        case .shortnessOfBreath: HKCategoryType(.shortnessOfBreath)
        case .skippedHeartbeat: HKCategoryType(.skippedHeartbeat)
        case .sleepChanges: HKCategoryType(.sleepChanges)
        case .soreThroat: HKCategoryType(.soreThroat)
        case .vaginalDryness: HKCategoryType(.vaginalDryness)
        case .vomiting: HKCategoryType(.vomiting)
        case .wheezing: HKCategoryType(.wheezing)
        }
    }
}
