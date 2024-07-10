//
//  SymptomsServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation
import HealthKit

@MainActor
public protocol SymptomsServiceProtocol: Sendable {

    // Fetch
    func symptom(type: SymptomType) async throws -> GenericSymptomModel
    func appetiteChanges() async throws -> AppetiteChanges

    // Save
    func saveSymptom(type: SymptomType, model: GenericSymptomModel, extra: [String: Any]?) async throws 
    func saveAppetiteChanges(model: AppetiteChanges, extra: [String : Any]?) async throws
}

public enum SymptomType {
    case abdominal
    case acne
    case appetiteChanges
    case bladderIncontinence
    case bodyAndAchePain
    case chills
    case chestTightnessOrPain
    case constipation
    case coughing
    case diarrhea
    case dizziness
    case drySkin
    case fainting
    case fatigue
    case fever
    case hairLoss
    case headache
    case heartBurn
    case hotFlushes
    case lossOfSmell
    case lossOfTaste
    case lowerBackPain
    case memoryLapse
    case nausea
    case nightSweats
    case pelvicPain
    case rapidPoundingOrFlutteringHeartbeat
    case runnyNose
    case shortnessOfBreath
    case skippedHeartbeat
    case sleepChanges
    case soreThroat
    case vomiting
    case wheezing


    var categoryType: HKCategoryType {
        switch self {
        case .abdominal: return HKCategoryType(.abdominalCramps)
        case .acne: return HKCategoryType(.acne)
        case .appetiteChanges: return HKCategoryType(.appetiteChanges)
        case .bladderIncontinence: return HKCategoryType(.bladderIncontinence)
        case .bodyAndAchePain: return HKCategoryType(.generalizedBodyAche)
        case .chills: return HKCategoryType(.chills)
        case .chestTightnessOrPain: return HKCategoryType(.chestTightnessOrPain)
        case .constipation: return HKCategoryType(.constipation)
        case .coughing: return HKCategoryType(.coughing)
        case .diarrhea: return HKCategoryType(.diarrhea)
        case .dizziness: return HKCategoryType(.dizziness)
        case .drySkin: return HKCategoryType(.drySkin)
        case .fatigue: return HKCategoryType(.fatigue)
        case .fainting: return HKCategoryType(.fainting)
        case .fever: return HKCategoryType(.fever)
        case .hairLoss: return HKCategoryType(.hairLoss)
        case .headache: return HKCategoryType(.headache)
        case .heartBurn: return HKCategoryType(.heartburn)
        case .hotFlushes: return HKCategoryType(.hotFlashes)
        case .lossOfSmell: return HKCategoryType(.lossOfSmell)
        case .lossOfTaste: return HKCategoryType(.lossOfTaste)
        case .lowerBackPain: return HKCategoryType(.lowerBackPain)
        case .memoryLapse: return HKCategoryType(.memoryLapse)
        case .nausea: return HKCategoryType(.nausea)
        case .nightSweats: return HKCategoryType(.nightSweats)
        case .pelvicPain: return HKCategoryType(.pelvicPain)
        case .rapidPoundingOrFlutteringHeartbeat: return HKCategoryType(.rapidPoundingOrFlutteringHeartbeat)
        case .runnyNose: return HKCategoryType(.runnyNose)
        case .shortnessOfBreath: return HKCategoryType(.shortnessOfBreath)
        case .skippedHeartbeat: return HKCategoryType(.skippedHeartbeat)
        case .sleepChanges: return HKCategoryType(.sleepChanges)
        case .soreThroat: return HKCategoryType(.soreThroat)
        case .vomiting: return HKCategoryType(.vomiting)
        case .wheezing: return HKCategoryType(.wheezing)
        }
    }
}
