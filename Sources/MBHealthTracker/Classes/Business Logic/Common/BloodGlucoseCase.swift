//
//  BloodGlucoseCase.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 8/8/2023.
//

import Foundation
import HealthKit

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
}
