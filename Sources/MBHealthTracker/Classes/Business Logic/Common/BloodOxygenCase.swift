//
//  BloodOxygenCase.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 8/8/2023.
//

import Foundation
import HealthKit

protocol BloodOxygenCase: FetchQuantitySample { }

extension BloodOxygenCase {

    func baseBloodOxygen() async throws -> BloodOxygen {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .oxygenSaturation)
        let items = samples.map { item -> BloodOxygen.Item in
            let percentage = item.quantity.doubleValue(for: .percent())
            return BloodOxygen.Item(date: item.startDate, oxygenSaturationPercentage: percentage)
        }

        let model = BloodOxygen(items: items)
        return model
    }
}
