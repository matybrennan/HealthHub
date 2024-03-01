//
//  CycleTracking.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation
import HealthKit

public class CycleTracking {
    
    public init() { }
}

// MARK: - FetchCategorySample
extension CycleTracking: FetchCategorySample, SexualActivityCase, MenstruationCase, AbdominalCrampsCase { }

// MARK: - Private methods
private extension CycleTracking {
    
    func fetchGenericCycleResult(categoryIdentifier: HKCategoryTypeIdentifier) async throws -> GenericSymptomModel {
        let samples = try await fetchCategorySamples(categoryIdentifier: categoryIdentifier)
        let items = samples.map { item -> GenericSymptomModel.Item in
            let style = GenericSymptomModel.Item.Style(rawValue: item.value) ?? .notPresent
            return GenericSymptomModel.Item(style: style, startDate: item.startDate, endDate: item.endDate)
        }
        
        let type = HKCategoryType(categoryIdentifier)
        let model = GenericSymptomModel(items: items, type: type)
        return model
    }

    func saveGenericCycleResult(model: GenericSymptomModel, categoryIdentifier: HKCategoryTypeIdentifier, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: categoryIdentifier)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.style.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}

// MARK: - CycleTrackingProtocol
extension CycleTracking: CycleTrackingProtocol {
    
    public func abdominalCramps() async throws -> GenericSymptomModel {
        try await baseAbdominalCramps()
    }
    
    public func bloating() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .bloating)
    }
    
    public func breastPain() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .breastPain)
    }
    
    public func cervicalMucusQuality() async throws -> CervicalMucusQuality {
        let samples = try await fetchCategorySamples(categoryIdentifier: .cervicalMucusQuality)
        let items = samples.map { item -> CervicalMucusQuality.Item in
            let type: CervicalMucusQuality.Item.MucusType = CervicalMucusQuality.Item.MucusType(rawValue: item.value) ?? .dry
            return CervicalMucusQuality.Item(type: type, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = CervicalMucusQuality(items: items)
        return model
    }
    
    public func menstruation() async throws -> Menstruation {
        try await baseMenstruation()
    }
    
    public func moodChanges() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .moodChanges)
    }
    
    public func ovulation() async throws -> Ovulation {
        let samples = try await fetchCategorySamples(categoryIdentifier: .ovulationTestResult)
        let items = samples.map { item -> Ovulation.Item in
            let type: CycleResultType = CycleResultType(rawValue: item.value) ?? .indetermined
            return Ovulation.Item(type: type, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = Ovulation(items: items)
        return model
    }
    
    public func pregnancyTestResult() async throws -> PregnancyTestResult {
        let samples = try await fetchCategorySamples(categoryIdentifier: .pregnancyTestResult)
        let items = samples.map { item -> PregnancyTestResult.Item in
            let type: CycleResultType = CycleResultType(rawValue: item.value) ?? .indetermined
            return PregnancyTestResult.Item(type: type, date: item.endDate)
        }
        
        let model = PregnancyTestResult(items: items)
        return model
    }
    
    public func progesteroneTestResult() async throws -> ProgesteroneTestResult {
        let samples = try await fetchCategorySamples(categoryIdentifier: .progesteroneTestResult)
        let items = samples.map { item -> ProgesteroneTestResult.Item in
            let type: CycleResultType = CycleResultType(rawValue: item.value) ?? .indetermined
            return ProgesteroneTestResult.Item(type: type, date: item.endDate)
        }
        
        let model = ProgesteroneTestResult(items: items)
        return model
    }
    
    public func sexualActivity() async throws -> SexualActivity {
        try await baseSexualActivity()
    }
    
    public func spotting() async throws -> Spotting {
        let samples = try await fetchCategorySamples(categoryIdentifier: .intermenstrualBleeding)
        let items = samples.map { item -> Spotting.Item in
            return Spotting.Item(date: item.endDate)
        }
        
        let model = Spotting(items: items)
        return model
    }
    
    public func vaginalDryness() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .vaginalDryness)
    }

    // MARK: - Saving

    public func saveAbdominalCramps(model: GenericSymptomModel, extra: [String : Any]?) async throws {
        try await saveBaseAbdominalCramps(model: model, extra: extra)
    }

    public func saveBloating(model: GenericSymptomModel, extra: [String : Any]?) async throws {
        try await saveGenericCycleResult(model: model, categoryIdentifier: .bloating, extra: extra)
    }

    public func saveBreastPain(model: GenericSymptomModel, extra: [String : Any]?) async throws {
        try await saveGenericCycleResult(model: model, categoryIdentifier: .breastPain, extra: extra)
    }

    public func saveCervicalMucusQuality(model: CervicalMucusQuality, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .cervicalMucusQuality)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.type.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveMenstruation(model: Menstruation, extra: [String : Any]?) async throws {
        try await saveBaseMenstruation(model, extra: extra)
    }

    public func saveMoodChanges(model: GenericSymptomModel, extra: [String : Any]?) async throws {
        try await saveGenericCycleResult(model: model, categoryIdentifier: .moodChanges, extra: extra)
    }

    public func saveOvulation(model: Ovulation, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .ovulationTestResult)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.type.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func savePregnancyTestResult(model: PregnancyTestResult, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .pregnancyTestResult)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.type.rawValue, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveProgesteroneTestResult(model: ProgesteroneTestResult, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .progesteroneTestResult)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.type.rawValue, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveSexualActivity(model: SexualActivity, extra: [String : Any]?) async throws {
        try await saveBaseSexualActivity(model, extra: extra)
    }

    public func saveSpotting(model: Spotting, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .intermenstrualBleeding)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: 0, start: $0.date, end: $0.date)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveVaginalDryness(model: GenericSymptomModel, extra: [String : Any]?) async throws {
        try await saveGenericCycleResult(model: model, categoryIdentifier: .vaginalDryness, extra: extra)
    }
}
