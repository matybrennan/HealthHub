import Foundation
@testable import HealthHub

final class MockSleepService: SleepServiceProtocol {

    var shouldThrowError: Error?
    var sleepCallCount = 0
    var sleepApneaEventCallCount = 0
    var sleepingBreathingDisturbancesCallCount = 0
    var saveCallCount = 0
    var stubbedSleep = Sleep(items: [])
    var stubbedSleepApneaEvent = SleepApneaEvent(items: [])
    var stubbedSleepingBreathingDisturbances = SleepingBreathingDisturbances(items: [])

    func sleep() async throws -> Sleep {
        sleepCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedSleep
    }

    func sleepApneaEvent() async throws -> SleepApneaEvent {
        sleepApneaEventCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedSleepApneaEvent
    }

    func sleepingBreathingDisturbances() async throws -> SleepingBreathingDisturbances {
        sleepingBreathingDisturbancesCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedSleepingBreathingDisturbances
    }

    func save(model: Sleep, extra: [String: Sendable]?) async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }
}
