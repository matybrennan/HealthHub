//
//  TimeInDaylightCase.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/3/2024.
//

import Foundation
import HealthKit

protocol TimeInDaylightCase: FetchQuantitySample { }

extension TimeInDaylightCase {

    func baseTimeInDaylight(from dateRange: DateRangeType = .allTime) async throws -> TimeInDaylight {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .timeInDaylight, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> TimeInDaylight.Item in
            let minutes = item.quantity.doubleValue(for: .minute())
            let duration = minutes * 60
            return TimeInDaylight.Item(duration: duration, startDate: item.startDate, endDate: item.endDate)
        }

        let model = TimeInDaylight(items: items)
        return model
    }

    func baseSaveTimeInDaylight(model: TimeInDaylight, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .timeInDaylight)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let minutes = $0.duration / 60.0
            let quantity = HKQuantity(unit: .minute(), doubleValue: minutes)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }
}
