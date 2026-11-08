//
//  HealthDashboard.swift
//  HealthHub
//

import Foundation
import HealthKit

/// A high-level health summary for a selected date range.
public struct HealthDashboard: Sendable, Equatable {
    public let stepCount: Int?
    public let activeEnergyKilocalories: Double?
    public let averageHeartRate: Double?
    public let workoutCount: Int
    public let sleepDuration: TimeInterval

    public init(
        stepCount: Int?,
        activeEnergyKilocalories: Double?,
        averageHeartRate: Double?,
        workoutCount: Int,
        sleepDuration: TimeInterval
    ) {
        self.stepCount = stepCount
        self.activeEnergyKilocalories = activeEnergyKilocalories
        self.averageHeartRate = averageHeartRate
        self.workoutCount = workoutCount
        self.sleepDuration = sleepDuration
    }
}

/// Builds common dashboard summaries without requiring callers to coordinate multiple services.
public struct HealthDashboardService: Sendable {
    private let store: any HealthStoreClientProtocol

    public init(store: any HealthStoreClientProtocol) {
        self.store = store
    }

    public func summary(for dateRange: DateRangeType = .today) async throws -> HealthDashboard {
        let query = HealthQuery(dateRange: dateRange)
        let stepStatistics = try await store.statistics(for: .stepCount, unit: .count(), query: query)
        let energyStatistics = try await store.statistics(for: .activeEnergy, unit: .kilocalorie(), query: query)
        let heartStatistics = try await store.statistics(for: .heartRate, unit: HKUnit(from: "count/min"), query: query)
        let workouts = try await store.sampleSummaries(for: [.workout], query: query, unit: nil)
        let sleep = try await store.sampleSummaries(for: [.sleepAnalysis], query: query, unit: nil)

        return HealthDashboard(
            stepCount: stepStatistics.sum.map(Int.init),
            activeEnergyKilocalories: energyStatistics.sum,
            averageHeartRate: heartStatistics.average,
            workoutCount: workouts.count,
            sleepDuration: sleep.reduce(0) { $0 + $1.endDate.timeIntervalSince($1.startDate) }
        )
    }
}
