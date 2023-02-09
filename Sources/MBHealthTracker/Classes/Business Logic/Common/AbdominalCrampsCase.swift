//
//  AbdominalCrampsCase.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/2/2023.
//

import Foundation
import HealthKit

protocol AbdominalCrampsCase: FetchCategorySample { }

extension AbdominalCrampsCase {
    
    func baseAbdominalCramps() async throws -> GenericSymptomModel {
        let samples = try await fetchCategorySamples(categoryIdentifier: .abdominalCramps)
        let items = samples.map { item -> GenericSymptomModel.Item in
            let style = GenericSymptomModel.Item.Style(rawValue: item.value) ?? .notPresent
            return GenericSymptomModel.Item(style: style, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = GenericSymptomModel(items: items)
        return model
    }
}
