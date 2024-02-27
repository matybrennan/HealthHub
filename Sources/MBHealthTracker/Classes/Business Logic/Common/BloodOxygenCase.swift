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

    func saveBaseBloodOxygen(model: BloodOxygen, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .oxygenSaturation)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .percent(), doubleValue: $0.oxygenSaturationPercentage)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
