//
//  ActiveEnergyService.swift
//  HealthHub
//
//  Created by matybrennan on 27/11/18.
//

import Foundation
import HealthKit

public final class ActiveEnergyService {

    public init() { }
}

// MARK: - FetchQuantitySample
extension ActiveEnergyService: FetchQuantitySample { }

// MARK: - ActiveEnergyServiceProtocol
extension ActiveEnergyService: ActiveEnergyServiceProtocol {

    public func activeEnergy(from type: ActiveEnergyType) async throws -> ActiveEnergy {
        let pred = try type.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .activeEnergyBurned, predicate: pred, sortDescriptors: [SortDescriptor(\HKQuantitySample.endDate, order: .reverse)], limit: nil)
        let items = samples.map { sample -> ActiveEnergy.Item in
            let calories = sample.quantity.doubleValue(for: .kilocalorie())
            return ActiveEnergy.Item(calories: calories, startDate: sample.startDate, endDate: sample.endDate)
        }
        return ActiveEnergy(items: items)
    }
}
