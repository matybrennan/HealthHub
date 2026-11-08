import Foundation
import HealthKit
@testable import HealthHub

final class MockHeartbeatSeriesService: HeartbeatSeriesServiceProtocol {

    var shouldThrowError: Error?
    var heartbeatSeriesCallCount = 0
    var heartbeatsCallCount = 0
    var saveCallCount = 0

    var stubbedHeartbeatSeries = HeartbeatSeries(items: [])
    var stubbedHeartbeats: [HeartbeatSeries.Heartbeat] = []
    var lastSavedModel: HeartbeatSeries.Record?
    var lastSavedMetadata: [String: Sendable]?

    func heartbeatSeries() async throws -> HeartbeatSeries {
        heartbeatSeriesCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedHeartbeatSeries
    }

    func heartbeats(for sample: HKHeartbeatSeriesSample) async throws -> [HeartbeatSeries.Heartbeat] {
        heartbeatsCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedHeartbeats
    }

    func saveHeartbeatSeries(model: HeartbeatSeries.Record, extra: [String: Sendable]?) async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
        lastSavedModel = model
        lastSavedMetadata = extra
    }
}
