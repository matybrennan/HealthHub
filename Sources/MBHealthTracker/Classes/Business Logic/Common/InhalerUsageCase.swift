//
//  InhalerUsageCase.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 8/8/2023.
//

import Foundation
import HealthKit

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
}
