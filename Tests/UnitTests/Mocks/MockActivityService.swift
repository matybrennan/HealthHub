import Foundation
@testable import HealthHub

final class MockActivityService: ActivityServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0
    var saveCallCount = 0

    // MARK: - Stubbed return values

    var stubbedCrossCountrySkiingDistance = CrossCountrySkiingDistance(items: [])
    var stubbedCyclingDistance = CyclingDistance(items: [])
    var stubbedPaddleSportsDistance = PaddleSportsDistance(items: [])
    var stubbedRowingDistance = RowingDistance(items: [])
    var stubbedSkatingSportsDistance = SkatingSportsDistance(items: [])
    var stubbedDownhillSnowSportsDistance = DownhillSnowSportsDistance(items: [])
    var stubbedSwimmingDistance = SwimmingDistance(items: [])
    var stubbedWalkingRunningDistance = WalkingRunningDistance(items: [])
    var stubbedWheelchairDistance = WheelchairDistance(items: [])
    var stubbedCrossCountrySkiingSpeed = CrossCountrySkiingSpeed(items: [])
    var stubbedCyclingSpeed = CyclingSpeed(items: [])
    var stubbedPaddleSportsSpeed = PaddleSportsSpeed(items: [])
    var stubbedRowingSpeed = RowingSpeed(items: [])
    var stubbedRunningSpeed = RunningSpeed(items: [])
    var stubbedCyclingCadence = CyclingCadence(items: [])
    var stubbedCyclingFunctionalThresholdPower = CyclingFunctionalThresholdPower(items: [])
    var stubbedCyclingPower = CyclingPower(items: [])
    var stubbedRunningGroundContactTime = RunningGroundContactTime(items: [])
    var stubbedRunningPower = RunningPower(items: [])
    var stubbedRunningStrideLength = RunningStrideLength(items: [])
    var stubbedRunningVerticalOscillation = RunningVerticalOscillation(items: [])
    var stubbedExerciseMinutes = ExerciseMinutes(items: [])
    var stubbedEstimatedWorkoutEffortScore = EstimatedWorkoutEffortScore(items: [])
    var stubbedMoveTime = MoveTime(items: [])
    var stubbedRestingEnergy = RestingEnergy(items: [])
    var stubbedStandTime = StandTime(items: [])
    var stubbedWorkoutEffortScore = WorkoutEffortScore(items: [])
    var stubbedAppleStandHour = StandHourEvent(items: [])
    var stubbedSwimmingStrokeCount = SwimmingStrokeCount(items: [])
    var stubbedUnderwaterDepth = UnderwaterDepth(items: [])
    var stubbedWaterTemperature = WaterTemperature(items: [])
    var stubbedFlightsClimbed = FlightsClimbed(items: [])
    var stubbedNikeFuel = NikeFuel(items: [])
    var stubbedPhysicalEffort = PhysicalEffort(items: [])
    var stubbedPushCount = PushCount(items: [])

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    private func save() async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }

    // MARK: - Distance

    func crossCountrySkiingDistance() async throws -> CrossCountrySkiingDistance { try await fetch(stubbedCrossCountrySkiingDistance) }
    func cyclingDistance() async throws -> CyclingDistance { try await fetch(stubbedCyclingDistance) }
    func paddleSportsDistance() async throws -> PaddleSportsDistance { try await fetch(stubbedPaddleSportsDistance) }
    func rowingDistance() async throws -> RowingDistance { try await fetch(stubbedRowingDistance) }
    func skatingSportsDistance() async throws -> SkatingSportsDistance { try await fetch(stubbedSkatingSportsDistance) }
    func downhillSnowSportsDistance() async throws -> DownhillSnowSportsDistance { try await fetch(stubbedDownhillSnowSportsDistance) }
    func swimmingDistance() async throws -> SwimmingDistance { try await fetch(stubbedSwimmingDistance) }
    func walkingRunningDistance() async throws -> WalkingRunningDistance { try await fetch(stubbedWalkingRunningDistance) }
    func wheelchairDistance() async throws -> WheelchairDistance { try await fetch(stubbedWheelchairDistance) }

    // MARK: - Speed

    func crossCountrySkiingSpeed() async throws -> CrossCountrySkiingSpeed { try await fetch(stubbedCrossCountrySkiingSpeed) }
    func cyclingSpeed() async throws -> CyclingSpeed { try await fetch(stubbedCyclingSpeed) }
    func paddleSportsSpeed() async throws -> PaddleSportsSpeed { try await fetch(stubbedPaddleSportsSpeed) }
    func rowingSpeed() async throws -> RowingSpeed { try await fetch(stubbedRowingSpeed) }
    func runningSpeed() async throws -> RunningSpeed { try await fetch(stubbedRunningSpeed) }

    // MARK: - Cycling

    func cyclingCadence() async throws -> CyclingCadence { try await fetch(stubbedCyclingCadence) }
    func cyclingFunctionalThresholdPower() async throws -> CyclingFunctionalThresholdPower { try await fetch(stubbedCyclingFunctionalThresholdPower) }
    func cyclingPower() async throws -> CyclingPower { try await fetch(stubbedCyclingPower) }

    // MARK: - Running

    func runningGroundContactTime() async throws -> RunningGroundContactTime { try await fetch(stubbedRunningGroundContactTime) }
    func runningPower() async throws -> RunningPower { try await fetch(stubbedRunningPower) }
    func runningStrideLength() async throws -> RunningStrideLength { try await fetch(stubbedRunningStrideLength) }
    func runningVerticalOscillation() async throws -> RunningVerticalOscillation { try await fetch(stubbedRunningVerticalOscillation) }

    // MARK: - Exercise & Energy

    func exerciseMinutes() async throws -> ExerciseMinutes { try await fetch(stubbedExerciseMinutes) }
    func estimatedWorkoutEffortScore() async throws -> EstimatedWorkoutEffortScore { try await fetch(stubbedEstimatedWorkoutEffortScore) }
    func moveTime() async throws -> MoveTime { try await fetch(stubbedMoveTime) }
    func restingEnergy() async throws -> RestingEnergy { try await fetch(stubbedRestingEnergy) }
    func standTime() async throws -> StandTime { try await fetch(stubbedStandTime) }
    func workoutEffortScore() async throws -> WorkoutEffortScore { try await fetch(stubbedWorkoutEffortScore) }
    func appleStandHour() async throws -> StandHourEvent { try await fetch(stubbedAppleStandHour) }

    // MARK: - Swimming

    func swimmingStrokeCount() async throws -> SwimmingStrokeCount { try await fetch(stubbedSwimmingStrokeCount) }

    // MARK: - Underwater

    func underwaterDepth() async throws -> UnderwaterDepth { try await fetch(stubbedUnderwaterDepth) }
    func waterTemperature() async throws -> WaterTemperature { try await fetch(stubbedWaterTemperature) }

    // MARK: - Miscellaneous

    func flightsClimbed() async throws -> FlightsClimbed { try await fetch(stubbedFlightsClimbed) }
    func nikeFuel() async throws -> NikeFuel { try await fetch(stubbedNikeFuel) }
    func physicalEffort() async throws -> PhysicalEffort { try await fetch(stubbedPhysicalEffort) }
    func pushCount() async throws -> PushCount { try await fetch(stubbedPushCount) }

    // MARK: - Save

    func saveCrossCountrySkiingDistance(model: CrossCountrySkiingDistance, extra: [String: Sendable]?) async throws { try await save() }
    func saveCrossCountrySkiingSpeed(model: CrossCountrySkiingSpeed, extra: [String: Sendable]?) async throws { try await save() }
    func saveCyclingCadence(model: CyclingCadence, extra: [String: Sendable]?) async throws { try await save() }
    func saveCyclingDistance(model: CyclingDistance, extra: [String: Sendable]?) async throws { try await save() }
    func saveCyclingFunctionalThresholdPower(model: CyclingFunctionalThresholdPower, extra: [String: Sendable]?) async throws { try await save() }
    func saveCyclingPower(model: CyclingPower, extra: [String: Sendable]?) async throws { try await save() }
    func saveCyclingSpeed(model: CyclingSpeed, extra: [String: Sendable]?) async throws { try await save() }
    func saveDownhillSnowSportsDistance(model: DownhillSnowSportsDistance, extra: [String: Sendable]?) async throws { try await save() }
    func saveFlightsClimbed(model: FlightsClimbed, extra: [String: Sendable]?) async throws { try await save() }
    func saveNikeFuel(model: NikeFuel, extra: [String: Sendable]?) async throws { try await save() }
    func savePaddleSportsDistance(model: PaddleSportsDistance, extra: [String: Sendable]?) async throws { try await save() }
    func savePaddleSportsSpeed(model: PaddleSportsSpeed, extra: [String: Sendable]?) async throws { try await save() }
    func savePhysicalEffort(model: PhysicalEffort, extra: [String: Sendable]?) async throws { try await save() }
    func savePushCount(model: PushCount, extra: [String: Sendable]?) async throws { try await save() }
    func saveRestingEnergy(model: RestingEnergy, extra: [String: Sendable]?) async throws { try await save() }
    func saveRowingDistance(model: RowingDistance, extra: [String: Sendable]?) async throws { try await save() }
    func saveRowingSpeed(model: RowingSpeed, extra: [String: Sendable]?) async throws { try await save() }
    func saveRunningPower(model: RunningPower, extra: [String: Sendable]?) async throws { try await save() }
    func saveRunningSpeed(model: RunningSpeed, extra: [String: Sendable]?) async throws { try await save() }
    func saveSkatingSportsDistance(model: SkatingSportsDistance, extra: [String: Sendable]?) async throws { try await save() }
    func saveSwimmingDistance(model: SwimmingDistance, extra: [String: Sendable]?) async throws { try await save() }
    func saveSwimmingStrokeCount(model: SwimmingStrokeCount, extra: [String: Sendable]?) async throws { try await save() }
    func saveWalkingRunningDistance(model: WalkingRunningDistance, extra: [String: Sendable]?) async throws { try await save() }
    func saveWheelchairDistance(model: WheelchairDistance, extra: [String: Sendable]?) async throws { try await save() }
    func saveWorkoutEffortScore(model: WorkoutEffortScore, extra: [String: Sendable]?) async throws { try await save() }
}
