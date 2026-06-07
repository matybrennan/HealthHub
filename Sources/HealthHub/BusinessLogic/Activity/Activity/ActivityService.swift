//
//  ActivityService.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/6/2026.
//

import Foundation
import HealthKit

public final class ActivityService {

    public init() { }
}

// MARK: - FetchQuantitySample
extension ActivityService: FetchQuantitySample { }

// MARK: - ActivityServiceProtocol
extension ActivityService: ActivityServiceProtocol {

    // MARK: - Distance

    public func cyclingDistance() async throws -> CyclingDistance {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .distanceCycling)
        let items = samples.map { item -> CyclingDistance.Item in
            let distance = item.quantity.doubleValue(for: .meter())
            return CyclingDistance.Item(distance: distance, date: item.endDate)
        }
        return CyclingDistance(items: items)
    }

    public func walkingRunningDistance() async throws -> WalkingRunningDistance {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .distanceWalkingRunning)
        let items = samples.map { item -> WalkingRunningDistance.Item in
            let distance = item.quantity.doubleValue(for: .meter())
            return WalkingRunningDistance.Item(distance: distance, date: item.endDate)
        }
        return WalkingRunningDistance(items: items)
    }

    public func swimmingDistance() async throws -> SwimmingDistance {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .distanceSwimming)
        let items = samples.map { item -> SwimmingDistance.Item in
            let distance = item.quantity.doubleValue(for: .meter())
            return SwimmingDistance.Item(distance: distance, date: item.endDate)
        }
        return SwimmingDistance(items: items)
    }

    public func wheelchairDistance() async throws -> WheelchairDistance {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .distanceWheelchair)
        let items = samples.map { item -> WheelchairDistance.Item in
            let distance = item.quantity.doubleValue(for: .meter())
            return WheelchairDistance.Item(distance: distance, date: item.endDate)
        }
        return WheelchairDistance(items: items)
    }

    public func downhillSnowSportsDistance() async throws -> DownhillSnowSportsDistance {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .distanceDownhillSnowSports)
        let items = samples.map { item -> DownhillSnowSportsDistance.Item in
            let distance = item.quantity.doubleValue(for: .meter())
            return DownhillSnowSportsDistance.Item(distance: distance, date: item.endDate)
        }
        return DownhillSnowSportsDistance(items: items)
    }

    public func crossCountrySkiingDistance() async throws -> CrossCountrySkiingDistance {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .distanceCrossCountrySkiing)
        let items = samples.map { item -> CrossCountrySkiingDistance.Item in
            let distance = item.quantity.doubleValue(for: .meter())
            return CrossCountrySkiingDistance.Item(distance: distance, date: item.endDate)
        }
        return CrossCountrySkiingDistance(items: items)
    }

    // MARK: - Speed

    public func crossCountrySkiingSpeed() async throws -> CrossCountrySkiingSpeed {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .crossCountrySkiingSpeed)
        let items = samples.map { item -> CrossCountrySkiingSpeed.Item in
            let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
            let speed = item.quantity.doubleValue(for: speedUnit)
            return CrossCountrySkiingSpeed.Item(speed: speed, date: item.endDate)
        }
        return CrossCountrySkiingSpeed(items: items)
    }

    public func cyclingSpeed() async throws -> CyclingSpeed {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .cyclingSpeed)
        let items = samples.map { item -> CyclingSpeed.Item in
            let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
            let speed = item.quantity.doubleValue(for: speedUnit)
            return CyclingSpeed.Item(speed: speed, date: item.endDate)
        }
        return CyclingSpeed(items: items)
    }

    public func runningSpeed() async throws -> RunningSpeed {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .runningSpeed)
        let items = samples.map { item -> RunningSpeed.Item in
            let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
            let speed = item.quantity.doubleValue(for: speedUnit)
            return RunningSpeed.Item(speed: speed, date: item.endDate)
        }
        return RunningSpeed(items: items)
    }

    // MARK: - Cycling Specific

    public func cyclingCadence() async throws -> CyclingCadence {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .cyclingCadence)
        let items = samples.map { item -> CyclingCadence.Item in
            let unit = HKUnit(from: "count/min")
            let rpm = item.quantity.doubleValue(for: unit)
            return CyclingCadence.Item(rpm: rpm, date: item.endDate)
        }
        return CyclingCadence(items: items)
    }

    public func cyclingFunctionalThresholdPower() async throws -> CyclingFunctionalThresholdPower {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .cyclingFunctionalThresholdPower)
        let items = samples.map { item -> CyclingFunctionalThresholdPower.Item in
            let power = item.quantity.doubleValue(for: .watt())
            return CyclingFunctionalThresholdPower.Item(power: power, date: item.endDate)
        }
        return CyclingFunctionalThresholdPower(items: items)
    }

    public func cyclingPower() async throws -> CyclingPower {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .cyclingPower)
        let items = samples.map { item -> CyclingPower.Item in
            let power = item.quantity.doubleValue(for: .watt())
            return CyclingPower.Item(power: power, date: item.endDate)
        }
        return CyclingPower(items: items)
    }

    // MARK: - Exercise & Energy

    public func exerciseMinutes() async throws -> ExerciseMinutes {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .appleExerciseTime)
        let items = samples.map { item -> ExerciseMinutes.Item in
            let duration = item.quantity.doubleValue(for: .minute())
            return ExerciseMinutes.Item(duration: duration, date: item.endDate)
        }
        return ExerciseMinutes(items: items)
    }

    public func restingEnergy() async throws -> RestingEnergy {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .basalEnergyBurned)
        let items = samples.map { item -> RestingEnergy.Item in
            let calories = item.quantity.doubleValue(for: .kilocalorie())
            return RestingEnergy.Item(calories: calories, date: item.endDate)
        }
        return RestingEnergy(items: items)
    }

    public func standTime() async throws -> StandTime {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .appleStandTime)
        let items = samples.map { item -> StandTime.Item in
            let duration = item.quantity.doubleValue(for: .minute())
            return StandTime.Item(duration: duration, date: item.endDate)
        }
        return StandTime(items: items)
    }

    public func moveTime() async throws -> MoveTime {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .appleMoveTime)
        let items = samples.map { item -> MoveTime.Item in
            let duration = item.quantity.doubleValue(for: .minute())
            return MoveTime.Item(duration: duration, date: item.endDate)
        }
        return MoveTime(items: items)
    }

    // MARK: - Running Specific

    public func runningPower() async throws -> RunningPower {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .runningPower)
        let items = samples.map { item -> RunningPower.Item in
            let power = item.quantity.doubleValue(for: .watt())
            return RunningPower.Item(power: power, date: item.endDate)
        }
        return RunningPower(items: items)
    }

    // MARK: - Swimming Specific

    public func swimmingStrokeCount() async throws -> SwimmingStrokeCount {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .swimmingStrokeCount)
        let items = samples.map { item -> SwimmingStrokeCount.Item in
            let count = item.quantity.doubleValue(for: .count())
            return SwimmingStrokeCount.Item(count: count, date: item.endDate)
        }
        return SwimmingStrokeCount(items: items)
    }

    // MARK: - Miscellaneous

    public func flightsClimbed() async throws -> FlightsClimbed {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .flightsClimbed)
        let items = samples.map { item -> FlightsClimbed.Item in
            let count = item.quantity.doubleValue(for: .count())
            return FlightsClimbed.Item(count: count, date: item.endDate)
        }
        return FlightsClimbed(items: items)
    }

    public func pushCount() async throws -> PushCount {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .pushCount)
        let items = samples.map { item -> PushCount.Item in
            let count = item.quantity.doubleValue(for: .count())
            return PushCount.Item(count: count, date: item.endDate)
        }
        return PushCount(items: items)
    }

    public func nikeFuel() async throws -> NikeFuel {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .nikeFuel)
        let items = samples.map { item -> NikeFuel.Item in
            let count = item.quantity.doubleValue(for: .count())
            return NikeFuel.Item(count: count, date: item.endDate)
        }
        return NikeFuel(items: items)
    }

    public func physicalEffort() async throws -> PhysicalEffort {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .physicalEffort)
        let items = samples.map { item -> PhysicalEffort.Item in
            let effort = item.quantity.doubleValue(for: HKUnit.appleEffortScore())
            return PhysicalEffort.Item(effort: effort, date: item.endDate)
        }
        return PhysicalEffort(items: items)
    }

    // MARK: - Save

    public func saveCyclingDistance(model: CyclingDistance, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .distanceCycling)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .meter(), doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveWalkingRunningDistance(model: WalkingRunningDistance, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .distanceWalkingRunning)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .meter(), doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveSwimmingDistance(model: SwimmingDistance, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .distanceSwimming)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .meter(), doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveWheelchairDistance(model: WheelchairDistance, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .distanceWheelchair)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .meter(), doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveDownhillSnowSportsDistance(model: DownhillSnowSportsDistance, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .distanceDownhillSnowSports)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .meter(), doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveCrossCountrySkiingDistance(model: CrossCountrySkiingDistance, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .distanceCrossCountrySkiing)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .meter(), doubleValue: $0.distance)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveCrossCountrySkiingSpeed(model: CrossCountrySkiingSpeed, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .crossCountrySkiingSpeed)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: speedUnit, doubleValue: $0.speed)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveCyclingSpeed(model: CyclingSpeed, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .cyclingSpeed)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: speedUnit, doubleValue: $0.speed)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveRunningSpeed(model: RunningSpeed, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .runningSpeed)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: speedUnit, doubleValue: $0.speed)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveCyclingCadence(model: CyclingCadence, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .cyclingCadence)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: "count/min")
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.rpm)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveCyclingFunctionalThresholdPower(model: CyclingFunctionalThresholdPower, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .cyclingFunctionalThresholdPower)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .watt(), doubleValue: $0.power)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveCyclingPower(model: CyclingPower, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .cyclingPower)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .watt(), doubleValue: $0.power)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveRestingEnergy(model: RestingEnergy, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .basalEnergyBurned)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .kilocalorie(), doubleValue: $0.calories)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveRunningPower(model: RunningPower, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .runningPower)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .watt(), doubleValue: $0.power)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveSwimmingStrokeCount(model: SwimmingStrokeCount, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .swimmingStrokeCount)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .count(), doubleValue: $0.count)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveFlightsClimbed(model: FlightsClimbed, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .flightsClimbed)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .count(), doubleValue: $0.count)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func savePushCount(model: PushCount, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .pushCount)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .count(), doubleValue: $0.count)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveNikeFuel(model: NikeFuel, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .nikeFuel)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .count(), doubleValue: $0.count)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func savePhysicalEffort(model: PhysicalEffort, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .physicalEffort)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .appleEffortScore(), doubleValue: $0.effort)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }
        try await HealthStoreProvider.shared.save(sampleObjects)
    }
}
