import Foundation
@testable import HealthHub

final class MockMobilityService: MobilityServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0
    var saveCallCount = 0

    var stubbedCardioFitness = CardioFitness(items: [])
    var stubbedDoubleSupportTime = DoubleSupportTime(items: [])
    var stubbedGroundContactTime = GroundContactTime(items: [])
    var stubbedRunningStrideLength = RunningStrideLength(items: [])
    var stubbedSixMinuteWalk = SixMinuteWalk(items: [])
    var stubbedStairSpeedDown = StairSpeedDown(items: [])
    var stubbedStairSpeedUp = StairSpeedUp(items: [])
    var stubbedVerticalOscillation = VerticalOscillation(items: [])
    var stubbedWalkingAsymmetry = WalkingAsymmetry(items: [])
    var stubbedWalkingSpeed = WalkingSpeed(items: [])
    var stubbedWalkingSteadiness = WalkingSteadiness(items: [])
    var stubbedWalkingStepLength = WalkingStepLength(items: [])

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    private func save() async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }

    func cardioFitness(from dateRange: DateRangeType) async throws -> CardioFitness { try await fetch(stubbedCardioFitness) }
    func doubleSupportTime(from dateRange: DateRangeType) async throws -> DoubleSupportTime { try await fetch(stubbedDoubleSupportTime) }
    func groundContactTime(from dateRange: DateRangeType) async throws -> GroundContactTime { try await fetch(stubbedGroundContactTime) }
    func runningStrideLength(from dateRange: DateRangeType) async throws -> RunningStrideLength { try await fetch(stubbedRunningStrideLength) }
    func sixMinuteWalk(from dateRange: DateRangeType) async throws -> SixMinuteWalk { try await fetch(stubbedSixMinuteWalk) }
    func stairSpeedDown(from dateRange: DateRangeType) async throws -> StairSpeedDown { try await fetch(stubbedStairSpeedDown) }
    func stairSpeedUp(from dateRange: DateRangeType) async throws -> StairSpeedUp { try await fetch(stubbedStairSpeedUp) }
    func verticalOscillation(from dateRange: DateRangeType) async throws -> VerticalOscillation { try await fetch(stubbedVerticalOscillation) }
    func walkingAsymmetry(from dateRange: DateRangeType) async throws -> WalkingAsymmetry { try await fetch(stubbedWalkingAsymmetry) }
    func walkingSpeed(from dateRange: DateRangeType) async throws -> WalkingSpeed { try await fetch(stubbedWalkingSpeed) }
    func walkingSteadiness(from dateRange: DateRangeType) async throws -> WalkingSteadiness { try await fetch(stubbedWalkingSteadiness) }
    func walkingStepLength(from dateRange: DateRangeType) async throws -> WalkingStepLength { try await fetch(stubbedWalkingStepLength) }

    func saveCardioFitness(model: CardioFitness, extra: [String: Sendable]?) async throws { try await save() }
    func saveDoubleSupportTime(model: DoubleSupportTime, extra: [String: Sendable]?) async throws { try await save() }
    func saveGroundContactTime(model: GroundContactTime, extra: [String: Sendable]?) async throws { try await save() }
    func saveRunningStrideLength(model: RunningStrideLength, extra: [String: Sendable]?) async throws { try await save() }
    func saveSixMinuteWalk(model: SixMinuteWalk, extra: [String: Sendable]?) async throws { try await save() }
    func saveStairSpeedDown(model: StairSpeedDown, extra: [String: Sendable]?) async throws { try await save() }
    func saveStairSpeedUp(model: StairSpeedUp, extra: [String: Sendable]?) async throws { try await save() }
    func saveVerticalOscillation(model: VerticalOscillation, extra: [String: Sendable]?) async throws { try await save() }
    func saveWalkingSpeed(model: WalkingSpeed, extra: [String: Sendable]?) async throws { try await save() }
    func saveWalkingStepLength(model: WalkingStepLength, extra: [String: Sendable]?) async throws { try await save() }
}
