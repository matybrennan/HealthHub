//
//  File.swift
//  
//
//  Created by Maty Brennan on 25/2/2024.
//

import Foundation
import HealthKit

protocol SixMinuteWalkCase: FetchQuantitySample { }

extension SixMinuteWalkCase {

    func baseSixMinuteWalk() async throws -> SixMinuteWalk {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .sixMinuteWalkTestDistance)
        let items = samples.map { item -> SixMinuteWalk.Item in
            let distanceMeters = item.quantity.doubleValue(for: HKUnit.meter())
            return SixMinuteWalk.Item(distance: distanceMeters, startDate: item.startDate, endDate: item.endDate)
        }

        let model = SixMinuteWalk(items: items)
        return model
    }

    func saveBaseSixMinuteWalk(_ model: SixMinuteWalk, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .sixMinuteWalkTestDistance)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .meter(), doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
