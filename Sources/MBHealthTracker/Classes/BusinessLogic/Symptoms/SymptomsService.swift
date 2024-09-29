//
//  SymptomsService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation
@preconcurrency import HealthKit

public final class SymptomsService {
    
    public init() { }
}

// MARK: - FetchQuantitySample
extension SymptomsService: FetchCategorySample, AbdominalCrampsCase { }

// MARK: - Private methods
private extension SymptomsService {
    
    func fetchGenericSymptomResult(categoryType: HKCategoryType) async throws -> GenericSymptomModel {
        let identifier = HKCategoryTypeIdentifier(rawValue: categoryType.identifier)
        let samples = try await fetchCategorySamples(categoryIdentifier: identifier)
        let items = samples.map { item -> GenericSymptomModel.Item in
            let style = GenericSymptomModel.Item.Style(rawValue: item.value) ?? .notPresent
            return GenericSymptomModel.Item(style: style, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = GenericSymptomModel(items: items, type: categoryType)
        return model
    }

    func saveGenericSymptomResult(categoryType: HKCategoryType, model: GenericSymptomModel, extra: [String: Sendable]?) async throws {
        let identifier = HKCategoryTypeIdentifier(rawValue: categoryType.identifier)
        let type = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: identifier)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            return HKCategorySample(type: type, value: $0.style.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}

// MARK: - SymptomsServiceProtocol
extension SymptomsService: SymptomsServiceProtocol {
    
    public func symptom(type: SymptomType) async throws -> GenericSymptomModel {
        return try await fetchGenericSymptomResult(categoryType: type.categoryType)
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

    // MARK: - Save

    public func saveSymptom(type: SymptomType, model: GenericSymptomModel, extra: [String: Sendable]?) async throws {
        try await saveGenericSymptomResult(categoryType: type.categoryType, model: model, extra: extra)
    }

    public func saveAppetiteChanges(model: AppetiteChanges, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .appetiteChanges)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            return HKCategorySample(type: type, value: $0.type.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}

