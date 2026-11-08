//
//  ActivityServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/6/2026.
//

import Foundation

public protocol ActivityServiceProtocol {

    // MARK: - Distance
    func crossCountrySkiingDistance() async throws -> CrossCountrySkiingDistance
    func cyclingDistance() async throws -> CyclingDistance
    func paddleSportsDistance() async throws -> PaddleSportsDistance
    func rowingDistance() async throws -> RowingDistance
    func skatingSportsDistance() async throws -> SkatingSportsDistance
    func downhillSnowSportsDistance() async throws -> DownhillSnowSportsDistance
    func swimmingDistance() async throws -> SwimmingDistance
    func walkingRunningDistance() async throws -> WalkingRunningDistance
    func wheelchairDistance() async throws -> WheelchairDistance

    // MARK: - Speed
    func crossCountrySkiingSpeed() async throws -> CrossCountrySkiingSpeed
    func cyclingSpeed() async throws -> CyclingSpeed
    func paddleSportsSpeed() async throws -> PaddleSportsSpeed
    func rowingSpeed() async throws -> RowingSpeed
    func runningSpeed() async throws -> RunningSpeed

    // MARK: - Cycling
    func cyclingCadence() async throws -> CyclingCadence
    func cyclingFunctionalThresholdPower() async throws -> CyclingFunctionalThresholdPower
    func cyclingPower() async throws -> CyclingPower

    // MARK: - Running
    func runningGroundContactTime() async throws -> RunningGroundContactTime
    func runningPower() async throws -> RunningPower
    func runningStrideLength() async throws -> RunningStrideLength
    func runningVerticalOscillation() async throws -> RunningVerticalOscillation

    // MARK: - Exercise & Energy
    func exerciseMinutes() async throws -> ExerciseMinutes
    func estimatedWorkoutEffortScore() async throws -> EstimatedWorkoutEffortScore
    func moveTime() async throws -> MoveTime
    func restingEnergy() async throws -> RestingEnergy
    func standTime() async throws -> StandTime
    func workoutEffortScore() async throws -> WorkoutEffortScore
    func appleStandHour() async throws -> StandHourEvent

    // MARK: - Swimming
    func swimmingStrokeCount() async throws -> SwimmingStrokeCount

    // MARK: - Underwater
    func underwaterDepth() async throws -> UnderwaterDepth
    func waterTemperature() async throws -> WaterTemperature

    // MARK: - Miscellaneous
    func flightsClimbed() async throws -> FlightsClimbed
    func nikeFuel() async throws -> NikeFuel
    func physicalEffort() async throws -> PhysicalEffort
    func pushCount() async throws -> PushCount

    // MARK: - Save

    func saveCrossCountrySkiingDistance(model: CrossCountrySkiingDistance, extra: [String: Sendable]?) async throws
    func saveCrossCountrySkiingSpeed(model: CrossCountrySkiingSpeed, extra: [String: Sendable]?) async throws
    func saveCyclingCadence(model: CyclingCadence, extra: [String: Sendable]?) async throws
    func saveCyclingDistance(model: CyclingDistance, extra: [String: Sendable]?) async throws
    func saveCyclingFunctionalThresholdPower(model: CyclingFunctionalThresholdPower, extra: [String: Sendable]?) async throws
    func saveCyclingPower(model: CyclingPower, extra: [String: Sendable]?) async throws
    func saveCyclingSpeed(model: CyclingSpeed, extra: [String: Sendable]?) async throws
    func saveDownhillSnowSportsDistance(model: DownhillSnowSportsDistance, extra: [String: Sendable]?) async throws
    func saveFlightsClimbed(model: FlightsClimbed, extra: [String: Sendable]?) async throws
    func saveNikeFuel(model: NikeFuel, extra: [String: Sendable]?) async throws
    func savePaddleSportsDistance(model: PaddleSportsDistance, extra: [String: Sendable]?) async throws
    func savePaddleSportsSpeed(model: PaddleSportsSpeed, extra: [String: Sendable]?) async throws
    func savePhysicalEffort(model: PhysicalEffort, extra: [String: Sendable]?) async throws
    func savePushCount(model: PushCount, extra: [String: Sendable]?) async throws
    func saveRestingEnergy(model: RestingEnergy, extra: [String: Sendable]?) async throws
    func saveRowingDistance(model: RowingDistance, extra: [String: Sendable]?) async throws
    func saveRowingSpeed(model: RowingSpeed, extra: [String: Sendable]?) async throws
    func saveRunningPower(model: RunningPower, extra: [String: Sendable]?) async throws
    func saveRunningSpeed(model: RunningSpeed, extra: [String: Sendable]?) async throws
    func saveSkatingSportsDistance(model: SkatingSportsDistance, extra: [String: Sendable]?) async throws
    func saveSwimmingDistance(model: SwimmingDistance, extra: [String: Sendable]?) async throws
    func saveSwimmingStrokeCount(model: SwimmingStrokeCount, extra: [String: Sendable]?) async throws
    func saveWalkingRunningDistance(model: WalkingRunningDistance, extra: [String: Sendable]?) async throws
    func saveWheelchairDistance(model: WheelchairDistance, extra: [String: Sendable]?) async throws
    func saveWorkoutEffortScore(model: WorkoutEffortScore, extra: [String: Sendable]?) async throws
}
