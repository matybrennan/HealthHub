//
//  SymptomsService.swift
//  HealthHub
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation
import HealthKit

public final class SymptomsService {
    
    public init() { }
}

// MARK: - FetchCategorySample
extension SymptomsService: FetchCategorySample, AbdominalCrampsCase { }

// MARK: - Private methods
private extension SymptomsService {
    
    func fetchGenericSymptomResult(type: SymptomType) async throws -> GenericSymptomModel {
        let identifier = HKCategoryTypeIdentifier(rawValue: type.categoryType.identifier)
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: identifier, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> GenericSymptomModel.Item in
            let style = GenericSymptomModel.Item.Style(rawValue: item.value) ?? .notPresent
            return GenericSymptomModel.Item(style: style, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = GenericSymptomModel(items: items, type: type.categoryType, displayName: type.displayName, category: type.category)
        return model
    }

    func saveGenericSymptomResult(categoryType: HKCategoryType, model: GenericSymptomModel, extra: [String: Sendable]?) async throws {
        let identifier = HKCategoryTypeIdentifier(rawValue: categoryType.identifier)
        let type = try HealthParser.categoryType(for: identifier)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            return HKCategorySample(type: type, value: $0.style.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }
}

// MARK: - SymptomsServiceProtocol
extension SymptomsService: SymptomsServiceProtocol {
    
    public func symptom(type: SymptomType) async throws -> GenericSymptomModel {
        try await fetchGenericSymptomResult(type: type)
    }

    public func appetiteChanges() async throws -> AppetiteChanges {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .appetiteChanges, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> AppetiteChanges.Item in
            let type = AppetiteChanges.Item.AppetiteChangesType(rawValue: item.value) ?? .noChange
            return AppetiteChanges.Item(type: type, startDate: item.startDate, endDate: item.endDate)
        }

        let model = AppetiteChanges(items: items)
        return model
    }

    // MARK: - Save

    public func saveSymptom(type: SymptomType, model: GenericSymptomModel, extra: [String: Sendable]?) async throws {
        try await saveGenericSymptomResult(categoryType: type.categoryType, model: model, extra: extra)
    }

    public func saveAppetiteChanges(model: AppetiteChanges, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .appetiteChanges)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            return HKCategorySample(type: type, value: $0.type.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }
}

