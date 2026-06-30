//
//  BloodGlucoseCase.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/8/2023.
//

import Foundation
import HealthKit

protocol BloodGlucoseCase: FetchQuantitySample { }

extension BloodGlucoseCase {

    func baseBloodGlucose(from dateRange: DateRangeType = .allTime) async throws -> BloodGlucose {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .bloodGlucose, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> BloodGlucose.Item in
            let glucoseLevel = item.quantity.doubleValue(for: HKUnit(from: "mg/dL"))
            let mealtimeInt = item.metadata?[HKMetadataKeyBloodGlucoseMealTime] as? Int ?? 0
            let mealTime = BloodGlucose.Item.MealTime(rawValue: mealtimeInt) ?? .unspecified
            return BloodGlucose.Item(bloodGlucose: glucoseLevel, mealTime: mealTime, startDate: item.startDate, endDate: item.endDate)
        }

        let model = BloodGlucose(items: items)
        return model
    }

    func saveBaseBloodGlucose(model: BloodGlucose, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .bloodGlucose)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: "mg/dL")
        let sampleObjects = model.items.map {
            var metadata = extra ?? [:]
            metadata[HKMetadataKeyBloodGlucoseMealTime] = $0.mealTime.rawValue
            let quantity = HKQuantity(unit: unit, doubleValue: $0.bloodGlucose)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: metadata)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }
}
