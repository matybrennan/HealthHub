import Foundation
@testable import HealthHub

final class MockStepsService: StepsServiceProtocol {

    var lastHour = Steps(items: [])
    var today = Steps(items: [])
    var thisWeek = Steps(items: [])
    var thisMonth = Steps(items: [])
    var betweenDates = Steps(items: [])

    var stepsCallCount = 0
    var resetCallCount = 0
    var lastReceivedType: StepsType?
    var shouldThrowError: Error?

    func steps(fromStepsType type: StepsType) async throws {
        stepsCallCount += 1
        lastReceivedType = type
        if let error = shouldThrowError { throw error }
    }

    func reset(type: StepsType) {
        resetCallCount += 1
    }
}
