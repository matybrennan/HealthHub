//
//  BloodOxygenCase.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/8/2023.
//

import Foundation
import HealthKit

protocol BloodOxygenCase: FetchQuantitySample { }

extension BloodOxygenCase {

    func baseBloodOxygen(from dateRange: DateRangeType = .allTime) async throws -> BloodOxygen {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .oxygenSaturation, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> BloodOxygen.Item in
            let percentage = item.quantity.doubleValue(for: .percent())
            return BloodOxygen.Item(oxygenSaturationPercentage: percentage, startDate: item.startDate, endDate: item.endDate)
        }

        let model = BloodOxygen(items: items)
        return model
    }

    func saveBaseBloodOxygen(model: BloodOxygen, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .oxygenSaturation)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .percent(), doubleValue: $0.oxygenSaturationPercentage)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }
}
