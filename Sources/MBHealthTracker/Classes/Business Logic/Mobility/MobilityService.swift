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
extension MobilityService: FetchQuantitySample, FetchCategorySample, SixMinuteWalkCase { }

// MARK: - MobilityServiceProtocol
extension MobilityService: MobilityServiceProtocol {

    public func cardioFitness() async throws -> CardioFitness {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .vo2Max)
        let items = samples.map { item -> CardioFitness.Item in
            let VO₂Unit = HKUnit(from: "ml/kg*min")
            let VO₂Max = item.quantity.doubleValue(for: VO₂Unit)
            return CardioFitness.Item(vo2Max: VO₂Max, date: item.endDate)
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

    public func sixMinuteWalk() async throws -> SixMinuteWalk {
        try await baseSixMinuteWalk()
    }

    public func stairSpeedDown() async throws -> StairSpeedDown {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .stairDescentSpeed)
        let items = samples.map { item -> StairSpeedDown.Item in
            let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
            let velocity = item.quantity.doubleValue(for: speedUnit)
            return StairSpeedDown.Item(velocity: velocity, date: item.endDate)
        }

        let vm = StairSpeedDown(items: items)
        return vm
    }

    public func stairSpeedUp() async throws -> StairSpeedUp {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .stairAscentSpeed)
        let items = samples.map { item -> StairSpeedUp.Item in
            let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
            let velocity = item.quantity.doubleValue(for: speedUnit)
            return StairSpeedUp.Item(velocity: velocity, date: item.endDate)
        }

        let vm = StairSpeedUp(items: items)
        return vm
    }

    public func verticalOscillation() async throws -> VerticalOscillation {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .stairAscentSpeed)
        let items = samples.map { item -> VerticalOscillation.Item in
            let distanceCM = item.quantity.doubleValue(for: HKUnit.meterUnit(with: .centi))
            return VerticalOscillation.Item(distance: distanceCM, date: item.endDate)
        }

        let vm = VerticalOscillation(items: items)
        return vm
    }

    public func walkingAsymmetry() async throws -> WalkingAsymmetry {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .walkingDoubleSupportPercentage)
        let items = samples.map { item -> WalkingAsymmetry.Item in
            let percentage = item.quantity.doubleValue(for: .percent())
            return WalkingAsymmetry.Item(percentage: percentage, date: item.endDate)
        }

        let vm = WalkingAsymmetry(items: items)
        return vm
    }

    public func walkingSpeed() async throws -> WalkingSpeed {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .stairDescentSpeed)
        let items = samples.map { item -> WalkingSpeed.Item in
            let speedUnit = HKUnit.meterUnit(with: .kilo).unitDivided(by: HKUnit.hour())
            let velocity = item.quantity.doubleValue(for: speedUnit)
            return WalkingSpeed.Item(velocity: velocity, date: item.endDate)
        }

        let vm = WalkingSpeed(items: items)
        return vm
    }

    public func walkingSteadiness() async throws -> WalkingSteadiness {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .walkingDoubleSupportPercentage)
        let items = samples.map { item -> WalkingSteadiness.Item in
            let percentage = item.quantity.doubleValue(for: .percent())
            return WalkingSteadiness.Item(percentage: percentage, date: item.endDate)
        }

        let vm = WalkingSteadiness(items: items)
        return vm
    }

    public func walkingStepLength() async throws -> WalkingStepLength {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .stairAscentSpeed)
        let items = samples.map { item -> WalkingStepLength.Item in
            let distanceCM = item.quantity.doubleValue(for: HKUnit.meterUnit(with: .centi))
            return WalkingStepLength.Item(distance: distanceCM, date: item.endDate)
        }

        let vm = WalkingStepLength(items: items)
        return vm
    }

    // MARK: Saving

    public func saveSixMinuteWalk(model: SixMinuteWalk) async throws {
        try await saveBaseSixMinuteWalk(model)
    }
}
