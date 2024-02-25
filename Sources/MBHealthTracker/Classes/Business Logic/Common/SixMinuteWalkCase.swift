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
}
