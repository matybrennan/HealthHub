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
extension CycleTracking: FetchCategorySample { }

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
        try await fetchGenericCycleResult(categoryIdentifier: .abdominalCramps)
    }
    
    public func bloating() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .bloating)
    }
    
    public func breastPain() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .breastPain)
    }
    
    public func cervicalMucusQuality() async throws -> CervicalMucusQuality {
        let samples = try await fetchCategorySamples(categoryIdentifier: .cervicalMucusQuality)
        let items = samples.map { item -> CervicalMucusQuality.Info in
            let type: CervicalMucusQuality.Info.MucusType = CervicalMucusQuality.Info.MucusType(rawValue: item.value) ?? .dry
            return CervicalMucusQuality.Info(type: type, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = CervicalMucusQuality(items: items)
        return model
    }
    
    public func menstrualFlow() async throws -> MenstrualFlow {
        let samples = try await fetchCategorySamples(categoryIdentifier: .menstrualFlow)
        let items = samples.map { item -> MenstrualFlow.Info in
            let type: MenstrualFlow.Info.FlowType = MenstrualFlow.Info.FlowType(rawValue: item.value) ?? .unspecified
            let cycleStartInt = item.metadata?[HKMetadataKeyMenstrualCycleStart] as? Int ?? 0
            let isStartOfCylce = (cycleStartInt == 0) ? false : true
            return MenstrualFlow.Info(type: type, isStartOfCycle: isStartOfCylce, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = MenstrualFlow(items: items)
        return model
    }
    
    public func moodChanges() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .moodChanges)
    }
    
    public func ovulation() async throws -> Ovulation {
        let samples = try await fetchCategorySamples(categoryIdentifier: .ovulationTestResult)
        let items = samples.map { item -> Ovulation.Info in
            let type: Ovulation.Info.ResultType = Ovulation.Info.ResultType(rawValue: item.value) ?? .indetermined
            return Ovulation.Info(type: type, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = Ovulation(items: items)
        return model
    }
    
    public func sexualActivity() async throws -> SexualActivity {
        let samples = try await fetchCategorySamples(categoryIdentifier: .sexualActivity)
        let items = samples.map { item -> SexualActivity.Info in
            let styleInt = item.metadata?[HKMetadataKeySexualActivityProtectionUsed] as? Int ?? -1
            let type: SexualActivity.Info.StyleType = SexualActivity.Info.StyleType(rawValue: styleInt) ?? .unspecified
            return SexualActivity.Info(type: type, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = SexualActivity(items: items)
        return model
    }
    
    public func spotting() async throws -> Spotting {
        let samples = try await fetchCategorySamples(categoryIdentifier: .intermenstrualBleeding)
        let items = samples.map { item -> Spotting.Info in
            return Spotting.Info(startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = Spotting(items: items)
        return model
    }
    
    public func vaginalDryness() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .vaginalDryness)
    }
}
