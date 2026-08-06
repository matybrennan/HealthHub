//
//  SleepService.swift
//  HealthHub
//
//  Created by matybrennan on 1/12/18.
//

import Foundation
import HealthKit

public final class SleepService {
    
    public init() { }
}

// MARK: - SleepCase
extension SleepService: FetchQuantitySample, FetchCategorySample, SleepCase { }

// MARK: - SleepServiceProtocol
extension SleepService: SleepServiceProtocol {
    
    public func sleep() async throws -> Sleep {
        try await baseSleep()
    }

    public func sleepApneaEvent() async throws -> SleepApneaEvent {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .sleepApneaEvent, sortDescriptors: [sortDescriptor])
        let items = samples.map { item in
            SleepApneaEvent.Item(startDate: item.startDate, endDate: item.endDate)
        }

        return SleepApneaEvent(items: items)
    }

    public func sleepingBreathingDisturbances() async throws -> SleepingBreathingDisturbances {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .appleSleepingBreathingDisturbances, sortDescriptors: [sortDescriptor])
        let items = samples.map { item in
            let count = item.quantity.doubleValue(for: HKUnit.count())
            return SleepingBreathingDisturbances.Item(count: count, startDate: item.startDate, endDate: item.endDate)
        }

        return SleepingBreathingDisturbances(items: items)
    }
    
    public func save(model: Sleep, extra: [String: Sendable]?) async throws {
        try await baseSaveSleep(model: model, extra: extra)
    }
}
