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
        
        let model = GenericSymptomModel(items: items)
        return model
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
            return Spotting.Item(startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = Spotting(items: items)
        return model
    }
    
    public func vaginalDryness() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .vaginalDryness)
    }
}
