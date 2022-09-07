//
//  SleepService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 1/12/18.
//

import Foundation
import HealthKit

public class SleepService {
    
    public init() { }
}

// MARK: - SleepServiceProtocol
extension SleepService: SleepServiceProtocol {
    
    public func sleep() async throws -> Sleep {
        
        // Confirm that the type and device works
        let sleepType = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .sleepAnalysis)
        let descriptorQuery = HKSampleQueryDescriptor(predicates: [.categorySample(type: sleepType)], sortDescriptors: [])
        let samples = try await descriptorQuery.result(for: healthStore)
        let items = samples.map { item -> Sleep.Info in
            let style = MBSleepStyle(rawValue: item.value) ?? MBSleepStyle.awake
            return Sleep.Info(style: style, startDate: item.startDate, endDate: item.endDate)
        }
        
        let vm = Sleep(items: items)
        return vm
    }
    
    public func save(sleep: Sleep.Info, extra: [String : Any]?) async throws {
        let sleepType = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .sleepAnalysis)
        try MBHealthParser.checkSharingAuthorizationStatus(for: sleepType)
        let sampleObj = HKCategorySample(type: sleepType, value: sleep.style.rawValue, start: sleep.startDate, end: sleep.endDate, metadata: extra)
        try await healthStore.save(sampleObj)
    }
}
