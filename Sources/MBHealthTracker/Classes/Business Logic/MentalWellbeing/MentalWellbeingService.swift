//
//  MentalWellbeingService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 24/9/19.
//

import Foundation
import HealthKit

public class MentalWellbeingService {
    
    public init() { }
}

// MARK: - FetchQuantitySample
extension MentalWellbeingService: FetchCategorySample { }

// MARK: - MindfulnessServiceProtocol
extension MentalWellbeingService: MentalWellbeingServiceProtocol {
    
    public func mindfulActivity() async throws -> Mindful {
        let samples = try await fetchCategorySamples(categoryIdentifier: .mindfulSession)
        let items = samples.map { item -> Mindful.Info in
            Mindful.Info(value: item.value, startDate: item.startDate, endDate: item.endDate)
        }
        
        let vm = Mindful(items: items)
        return vm
    }
    
    public func save(mindful: Mindful, extra: [String : Any]?) async throws {
        let mindfulType = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .mindfulSession)
        try MBHealthParser.checkSharingAuthorizationStatus(for: mindfulType)
        let sampleObjects = mindful.items.map {
            HKCategorySample(type: mindfulType, value: $0.value, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
