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
extension MentalWellbeingService: FetchCategorySample, SleepCase, TimeInDaylightCase { }

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

    public func sleep() async throws -> Sleep {
        try await baseSleep()
    }

    public func timeInDaylight() async throws -> TimeInDaylight {
        try await baseTimeInDaylight()
    }

    // MARK: - Saving

    public func save(mindful: Mindful, extra: [String : Any]?) async throws {
        let mindfulType = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .mindfulSession)
        try MBHealthParser.checkSharingAuthorizationStatus(for: mindfulType)
        let sampleObjects = mindful.items.map {
            HKCategorySample(type: mindfulType, value: $0.value, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func save(model: Sleep, extra: [String : Any]?) async throws {
        try await baseSaveSleep(model: model, extra: extra)
    }

    public func saveTimeInDaylight(model: TimeInDaylight, extra: [String : Any]?) async throws {
        try await baseSaveTimeInDaylight(model: model, extra: extra)
    }
}
