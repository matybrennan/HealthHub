//
//  File.swift
//  
//
//  Created by Maty Brennan on 24/2/2024.
//

import Foundation
@preconcurrency import HealthKit

public final class MobilityService {

    public init() { }
}

// MARK: - FetchQuantitySample
extension MobilityService: FetchQuantitySample, FetchCategorySample, SixMinuteWalkCase, CardioFitnessCase { }

// MARK: - MobilityServiceProtocol
extension MobilityService: MobilityServiceProtocol {

    public func cardioFitness() async throws -> CardioFitness {
        try await baseCardioFitness()
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

    public func saveCardioFitness(model: CardioFitness, extra: [String: Sendable]?) async throws {
        try await saveBaseCardioFitness(model, extra: extra)
    }

    public func saveDoubleSupportTime(model: DoubleSupportTime, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .walkingDoubleSupportPercentage)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .percent(), doubleValue: $0.percentage)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveGroundContactTime(model: GroundContactTime, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .runningGroundContactTime)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.secondUnit(with: .milli)
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.duration)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveRunningStrideLength(model: RunningStrideLength, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .runningStrideLength)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .meter(), doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveSixMinuteWalk(model: SixMinuteWalk, extra: [String: Sendable]?) async throws {
        try await saveBaseSixMinuteWalk(model, extra: extra)
    }

    public func saveStairSpeedDown(model: StairSpeedDown, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .stairDescentSpeed)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: speedUnit, doubleValue: $0.velocity)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveStairSpeedUp(model: StairSpeedUp, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .stairAscentSpeed)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: speedUnit, doubleValue: $0.velocity)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveVerticalOscillation(model: VerticalOscillation, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .runningVerticalOscillation)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.meterUnit(with: .centi)
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveWalkingSpeed(model: WalkingSpeed, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .walkingSpeed)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let speedUnit = HKUnit.meterUnit(with: .kilo).unitDivided(by: HKUnit.hour())
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: speedUnit, doubleValue: $0.velocity)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveWalkingStepLength(model: WalkingStepLength, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .walkingStepLength)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.meterUnit(with: .centi)
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
