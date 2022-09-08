//
//  MindfulnessService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 24/9/19.
//

import Foundation
import HealthKit

public class MindfulnessService {
    
    public init() { }
}

// MARK: - FetchQuantitySample
extension MindfulnessService: FetchCategorySample { }

// MARK: - MindfulnessServiceProtocol
extension MindfulnessService: MindfulnessServiceProtocol {
    
    public func mindfulActivity() async throws -> Mindful {
        let samples = try await fetchCategorySamples(categoryIdentifier: .mindfulSession)
        let items = samples.map { item -> Mindful.Info in
            Mindful.Info(value: item.value, startDate: item.startDate, endDate: item.endDate)
        }
        
        let vm = Mindful(items: items)
        return vm
    }
    
    public func save(mindful: Mindful.Info, extra: [String : Any]?) async throws {
        let mindfulType = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .mindfulSession)
        try MBHealthParser.checkSharingAuthorizationStatus(for: mindfulType)
        let sampleObj = HKCategorySample(type: mindfulType, value: mindful.value, start: mindful.startDate, end: mindful.endDate, metadata: extra)
        try await healthStore.save(sampleObj)
    }
}
