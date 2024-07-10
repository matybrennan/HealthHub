//
//  InhalerUsageCase.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 8/8/2023.
//

import Foundation
@preconcurrency import HealthKit

@MainActor
protocol InhalerUsageCase: FetchQuantitySample { }

extension InhalerUsageCase {

    func baseInhalerUsage() async throws -> InhalerUsage {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .inhalerUsage)
        let items = samples.map { item -> InhalerUsage.Item in
            let value = Int(item.quantity.doubleValue(for: HKUnit.count()))
            return InhalerUsage.Item(value: value, date: item.startDate)
        }

        let model = InhalerUsage(items: items)
        return model
    }

    func saveBaseInhalerUsage(model: InhalerUsage, extra: [String: Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .inhalerUsage)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.count()
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: Double($0.value))
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
