//
//  AbdominalCrampsCase.swift
//  HealthHub
//
//  Created by Maty Brennan on 9/2/2023.
//

import Foundation
@preconcurrency import HealthKit

protocol AbdominalCrampsCase: FetchCategorySample { }

extension AbdominalCrampsCase {
    
    func baseAbdominalCramps() async throws -> GenericSymptomModel {
        let samples = try await fetchCategorySamples(categoryIdentifier: .abdominalCramps)
        let items = samples.map { item -> GenericSymptomModel.Item in
            let style = GenericSymptomModel.Item.Style(rawValue: item.value) ?? .notPresent
            return GenericSymptomModel.Item(style: style, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = GenericSymptomModel(items: items, type: SymptomType.abdominal.categoryType)
        return model
    }

    func saveBaseAbdominalCramps(model: GenericSymptomModel, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .abdominalCramps)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.style.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
