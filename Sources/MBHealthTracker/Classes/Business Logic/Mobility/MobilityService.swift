//
//  File.swift
//  
//
//  Created by Maty Brennan on 24/2/2024.
//

import Foundation
import HealthKit

public class MobilityService {

    public init() { }
}

// MARK: - FetchQuantitySample
extension MobilityService: FetchQuantitySample { }

// MARK: - FetchCategorySample
extension MobilityService: FetchCategorySample { }

// MARK: - MobilityServiceProtocol
extension MobilityService: MobilityServiceProtocol {

    public func cardioFitness() async throws -> CardioFitness {
        let samples = try await fetchCategorySamples(categoryIdentifier: .lowCardioFitnessEvent)
        let items = samples.map { item -> CardioFitness.Item in
            let VO₂Unit = HKUnit(from: "ml/kg*min")
            let cycleStartInt = item.metadata?[HKMetadataKeyLowCardioFitnessEventThreshold] as? Int ?? 0
            //let vo2Max = item..doubleValue(for: VO₂Unit)
            return CardioFitness.Item(vo2Max: 0, date: item.endDate)
        }

        let vm = CardioFitness(items: items)
        return vm
    }

    public func doubleSupportTime() async throws -> DoubleSupportTime {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .walkingDoubleSupportPercentage)
        let items = samples.map { item -> DoubleSupportTime.Item in
            let percentage = item.quantity.doubleValue(for: .percent())
            return DoubleSupportTime.Item(percentage: percentage, date: item.endDate)
        }

        let vm = DoubleSupportTime(items: items)
        return vm
    }
    
    public func groundContactTime() async throws -> GroundContactTime {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .runningGroundContactTime)
        let items = samples.map { item -> GroundContactTime.Item in
            let durationMS = item.quantity.doubleValue(for: HKUnit.secondUnit(with: .milli))
            return GroundContactTime.Item(duration: durationMS, date: item.endDate)
        }

        let vm = GroundContactTime(items: items)
        return vm
    }
    
    public func runningStrideLength() async throws -> RunningStrideLength {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .runningStrideLength)
        let items = samples.map { item -> RunningStrideLength.Item in
            let distanceMeters = item.quantity.doubleValue(for: HKUnit.meter())
            return RunningStrideLength.Item(distance: distanceMeters, date: item.endDate)
        }

        let vm = RunningStrideLength(items: items)
        return vm
    }
}
