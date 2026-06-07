//
//  ActivityServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/6/2026.
//

import Foundation

public protocol ActivityServiceProtocol {

    func crossCountrySkiingDistance() async throws -> CrossCountrySkiingDistance
    func crossCountrySkiingSpeed() async throws -> CrossCountrySkiingSpeed
    func cyclingCadence() async throws -> CyclingCadence
    func cyclingDistance() async throws -> CyclingDistance
    func cyclingFunctionalThresholdPower() async throws -> CyclingFunctionalThresholdPower
    func cyclingPower() async throws -> CyclingPower
    func cyclingSpeed() async throws -> CyclingSpeed
    func downhillSnowSportsDistance() async throws -> DownhillSnowSportsDistance
    func exerciseMinutes() async throws -> ExerciseMinutes
    func flightsClimbed() async throws -> FlightsClimbed
    func moveTime() async throws -> MoveTime
    func nikeFuel() async throws -> NikeFuel
    func physicalEffort() async throws -> PhysicalEffort
    func pushCount() async throws -> PushCount
    func restingEnergy() async throws -> RestingEnergy
    func runningPower() async throws -> RunningPower
    func runningSpeed() async throws -> RunningSpeed
    func standTime() async throws -> StandTime
    func swimmingDistance() async throws -> SwimmingDistance
    func swimmingStrokeCount() async throws -> SwimmingStrokeCount
    func walkingRunningDistance() async throws -> WalkingRunningDistance
    func wheelchairDistance() async throws -> WheelchairDistance

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
    func savePhysicalEffort(model: PhysicalEffort, extra: [String: Sendable]?) async throws
    func savePushCount(model: PushCount, extra: [String: Sendable]?) async throws
    func saveRestingEnergy(model: RestingEnergy, extra: [String: Sendable]?) async throws
    func saveRunningPower(model: RunningPower, extra: [String: Sendable]?) async throws
    func saveRunningSpeed(model: RunningSpeed, extra: [String: Sendable]?) async throws
    func saveSwimmingDistance(model: SwimmingDistance, extra: [String: Sendable]?) async throws
    func saveSwimmingStrokeCount(model: SwimmingStrokeCount, extra: [String: Sendable]?) async throws
    func saveWalkingRunningDistance(model: WalkingRunningDistance, extra: [String: Sendable]?) async throws
    func saveWheelchairDistance(model: WheelchairDistance, extra: [String: Sendable]?) async throws
}
