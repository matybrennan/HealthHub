import Foundation
@testable import HealthHub

final class MockHeartRateService: HeartRateServiceProtocol {

    var current: HeartRate.Item? = nil
    var today = HeartRate(items: [])
    var thisWeek = HeartRate(items: [])
    var thisMonth = HeartRate(items: [])
    var allTime = HeartRate(items: [])
    var betweenDates = HeartRate(items: [])

    var heartRateCallCount = 0
    var resetCallCount = 0
    var lastReceivedType: HeartRateType?
    var shouldThrowError: Error?

    func heartRate(fromHeartRateType type: HeartRateType) async throws {
        heartRateCallCount += 1
        lastReceivedType = type
        if let error = shouldThrowError { throw error }
    }

    func reset(type: HeartRateType) {
        resetCallCount += 1
    }
}
