//
//  File.swift
//  
//
//  Created by Maty Brennan on 2/3/2024.
//

import Foundation
@preconcurrency import HealthKit

@MainActor
protocol TimeInDaylightCase: FetchQuantitySample { }

extension TimeInDaylightCase {

    func baseTimeInDaylight() async throws -> TimeInDaylight {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .timeInDaylight)
        let items = samples.map { item -> TimeInDaylight.Item in
            TimeInDaylight.Item(startDate: item.startDate, endDate: item.endDate)
        }

        let model = TimeInDaylight(items: items)
        return model
    }

    func baseSaveTimeInDaylight(model: TimeInDaylight, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .timeInDaylight)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let duration = Int($0.endDate.timeIntervalSince($0.startDate))
            let quantity = HKQuantity(unit: .count(), doubleValue: Double(duration))
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
