//
//  SymptomsService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation
import HealthKit

public class SymptomsService {
    
    public init() { }
}

// MARK: - FetchQuantitySample
extension SymptomsService: FetchCategorySample { }

// MARK: - Private methods
private extension SymptomsService {
    
    func fetchGenericSymptomResult(categoryIdentifier: HKCategoryTypeIdentifier) async throws -> GenericSymptomModel {
        let samples = try await fetchCategorySamples(categoryIdentifier: categoryIdentifier)
        let items = samples.map { item -> GenericSymptomModel.Item in
            let style = GenericSymptomModel.Item.Style(rawValue: item.value) ?? .notPresent
            return GenericSymptomModel.Item(style: style, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = GenericSymptomModel(items: items)
        return model
    }
}

// MARK: - SymptomsServiceProtocol
extension SymptomsService: SymptomsServiceProtocol {
    
    public func acne() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .acne)
    }
    
    public func appetiteChanges() async throws -> AppetiteChanges {
        let samples = try await fetchCategorySamples(categoryIdentifier: .appetiteChanges)
        let items = samples.map { item -> AppetiteChanges.Item in
            let type = AppetiteChanges.Item.AppetiteChangesType(rawValue: item.value) ?? .noChange
            return AppetiteChanges.Item(type: type, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = AppetiteChanges(items: items)
        return model
    }
    
    public func bladderIncontinence() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .bladderIncontinence)
    }
    
    public func bodyAndMuscleAche() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .generalizedBodyAche)
    }
    
    public func chestTightnessOrPain() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .chestTightnessOrPain)
    }
    
    public func chills() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .chills)
    }
    
    public func congestion() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .sinusCongestion)
    }
    
    public func constipation() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .constipation)
    }
    
    public func coughing() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .coughing)
    }
    
    public func diarrhea() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .diarrhea)
    }
    
    public func drySkin() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .drySkin)
    }
    
    public func fainting() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .fainting)
    }
    
    public func fatigue() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .fatigue)
    }
    
    public func fever() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .fever)
    }
    
    public func hairLoss() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .hairLoss)
    }
    
    public func headache() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .headache)
    }
    
    public func heartBurn() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .heartburn)
    }
    
    public func hotFlushes() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .hotFlashes)
    }
    
    public func lossOfSmell() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .lossOfSmell)
    }
    
    public func lossOfTaste() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .lossOfTaste)
    }
    
    public func lowerBackPain() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .lowerBackPain)
    }
    
    public func memoryLapse() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .memoryLapse)
    }
    
    public func nausea() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .nausea)
    }
    
    public func nightSweats() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .nightSweats)
    }
    
    public func pelvicPain() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .pelvicPain)
    }
    
    public func rapidPoundingOrFlutteringHeartbeat() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .rapidPoundingOrFlutteringHeartbeat)
    }
    
    public func runnyNose() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .runnyNose)
    }
    
    public func shortnessOfBreath() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .shortnessOfBreath)
    }
    
    public func skippedHeartbeat() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .skippedHeartbeat)
    }
    
    public func sleepChanges() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .sleepChanges)
    }
    
    public func soreThroat() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .soreThroat)
    }
    
    public func vomiting() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .vomiting)
    }
    
    public func wheezing() async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(categoryIdentifier: .wheezing)
    }
}

