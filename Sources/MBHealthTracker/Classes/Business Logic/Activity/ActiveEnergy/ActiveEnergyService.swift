//
//  ActiveEnergyService.swift
//  MBHealthTracker
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
        let samples = try await fetchQuantitySamples(quantityIdentifier: .activeEnergyBurned, predicate: pred, sortDescriptors: [], limit: nil)
        let calories = samples.reduce(Double(), { (result, sample) -> Double in
            return result + sample.quantity.doubleValue(for: HKUnit.kilocalorie())
        })
        
        let model = ActiveEnergy(calories: calories)
        return model
    }
}
