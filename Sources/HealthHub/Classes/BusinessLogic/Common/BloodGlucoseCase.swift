//
//  BloodGlucoseCase.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/8/2023.
//

import Foundation
@preconcurrency import HealthKit

protocol BloodGlucoseCase: FetchQuantitySample { }

extension BloodGlucoseCase {

    func baseBloodGlucose() async throws -> BloodGlucose {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .bloodGlucose)
        let items = samples.map { item -> BloodGlucose.Item in
            let glucoseLevel = item.quantity.doubleValue(for: HKUnit(from: "mg/dL"))
            let mealtimeInt = item.metadata?[HKMetadataKeyBloodGlucoseMealTime] as? Int ?? 0
            let mealTime = BloodGlucose.Item.MealTime(rawValue: mealtimeInt) ?? .unspecified
            return BloodGlucose.Item(date: item.startDate, bloodGlucose: glucoseLevel, mealTime: mealTime)
        }

        let model = BloodGlucose(items: items)
        return model
    }

    func saveBaseBloodGlucose(model: BloodGlucose, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bloodGlucose)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: "mg/dL")
        let sampleObjects = model.items.map {
            var metadata = extra ?? [:]
            metadata[HKMetadataKeyBloodGlucoseMealTime] = $0.mealTime.rawValue
            let quantity = HKQuantity(unit: unit, doubleValue: $0.bloodGlucose)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: metadata)
        }

        try await healthStore.save(sampleObjects)
    }
}
