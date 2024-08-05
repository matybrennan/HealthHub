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
    func saveSymptom(type: SymptomType, model: GenericSymptomModel, extra: [String: Sendable]?) async throws
    func saveAppetiteChanges(model: AppetiteChanges, extra: [String: Sendable]?) async throws
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
        case .abdominal: HKCategoryType(.abdominalCramps)
        case .acne: HKCategoryType(.acne)
        case .appetiteChanges: HKCategoryType(.appetiteChanges)
        case .bladderIncontinence: HKCategoryType(.bladderIncontinence)
        case .bodyAndAchePain: HKCategoryType(.generalizedBodyAche)
        case .chills: HKCategoryType(.chills)
        case .chestTightnessOrPain: HKCategoryType(.chestTightnessOrPain)
        case .constipation: HKCategoryType(.constipation)
        case .coughing: HKCategoryType(.coughing)
        case .diarrhea: HKCategoryType(.diarrhea)
        case .dizziness: HKCategoryType(.dizziness)
        case .drySkin: HKCategoryType(.drySkin)
        case .fatigue: HKCategoryType(.fatigue)
        case .fainting: HKCategoryType(.fainting)
        case .fever: HKCategoryType(.fever)
        case .hairLoss: HKCategoryType(.hairLoss)
        case .headache: HKCategoryType(.headache)
        case .heartBurn: HKCategoryType(.heartburn)
        case .hotFlushes: HKCategoryType(.hotFlashes)
        case .lossOfSmell: HKCategoryType(.lossOfSmell)
        case .lossOfTaste: HKCategoryType(.lossOfTaste)
        case .lowerBackPain: HKCategoryType(.lowerBackPain)
        case .memoryLapse: HKCategoryType(.memoryLapse)
        case .nausea: HKCategoryType(.nausea)
        case .nightSweats: HKCategoryType(.nightSweats)
        case .pelvicPain: HKCategoryType(.pelvicPain)
        case .rapidPoundingOrFlutteringHeartbeat: HKCategoryType(.rapidPoundingOrFlutteringHeartbeat)
        case .runnyNose: HKCategoryType(.runnyNose)
        case .shortnessOfBreath: HKCategoryType(.shortnessOfBreath)
        case .skippedHeartbeat: HKCategoryType(.skippedHeartbeat)
        case .sleepChanges: HKCategoryType(.sleepChanges)
        case .soreThroat: HKCategoryType(.soreThroat)
        case .vomiting: HKCategoryType(.vomiting)
        case .wheezing: HKCategoryType(.wheezing)
        }
    }
}
