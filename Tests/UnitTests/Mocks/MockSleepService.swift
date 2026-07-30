import Foundation
@testable import HealthHub

final class MockSleepService: SleepServiceProtocol {

    var shouldThrowError: Error?
    var sleepCallCount = 0
    var saveCallCount = 0
    var stubbedSleep = Sleep(items: [])

    func sleep() async throws -> Sleep {
        sleepCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedSleep
    }

    func save(model: Sleep, extra: [String: Sendable]?) async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }
}
