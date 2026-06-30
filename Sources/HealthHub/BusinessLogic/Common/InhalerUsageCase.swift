//
//  InhalerUsageCase.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/8/2023.
//

import Foundation
import HealthKit

protocol InhalerUsageCase: FetchQuantitySample { }

extension InhalerUsageCase {

    func baseInhalerUsage(from dateRange: DateRangeType = .allTime) async throws -> InhalerUsage {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .inhalerUsage, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> InhalerUsage.Item in
            let value = Int(item.quantity.doubleValue(for: HKUnit.count()))
            return InhalerUsage.Item(value: value, startDate: item.startDate, endDate: item.endDate)
        }

        let model = InhalerUsage(items: items)
        return model
    }

    func saveBaseInhalerUsage(model: InhalerUsage, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .inhalerUsage)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.count()
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: Double($0.value))
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }
}
