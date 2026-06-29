//
//  StepsService.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

@Observable
public final class StepsService {

    private nonisolated static let stepsUnit = HKUnit.count()

    public private(set) var lastHour = Steps(items: [])
    public private(set) var today = Steps(items: [])
    public private(set) var thisWeek = Steps(items: [])
    public private(set) var thisMonth = Steps(items: [])
    public private(set) var betweenDates = Steps(items: [])

    public init() { }
}

extension StepsService: StepsServiceProtocol {

    public func steps(fromStepsType type: StepsType) async throws {
        switch type {
        case .lastHour:
            let now = Date()
            let oneHourAgo = now.addingTimeInterval(-3600)
            let predicate = HKQuery.predicateForSamples(withStart: oneHourAgo, end: now, options: [])
            var component = DateComponents()
            component.hour = 1
            lastHour = try await executeStatisticsQuery(predicate: predicate, interval: component, anchorDate: now)

        case let .today(interval):
            let predicate = try NSPredicate.today()
            var component = DateComponents()
            component.hour = interval
            today = try await executeStatisticsQuery(predicate: predicate, interval: component, anchorDate: Date().startOfDay)

        case let .thisWeek(interval):
            let predicate = try NSPredicate.thisWeek()
            var component = DateComponents()
            component.hour = interval
            let anchor = Date().startOfWeek ?? Date().startOfDay
            thisWeek = try await executeStatisticsQuery(predicate: predicate, interval: component, anchorDate: anchor)

        case let .thisMonth(interval):
            let predicate = Self.thisMonthPredicate()
            var component = DateComponents()
            component.day = interval
            thisMonth = try await executeStatisticsQuery(predicate: predicate, interval: component, anchorDate: Date().startOfDay)

        case let .betweenDates(start, end):
            let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
            let minutes = max(1, Calendar.current.dateComponents([.minute], from: start, to: end).minute ?? 60)
            var component = DateComponents()
            component.minute = minutes
            betweenDates = try await executeStatisticsQuery(predicate: predicate, interval: component, anchorDate: start)
        }
    }

    public func reset(type: StepsType) {
        switch type {
        case .lastHour:
            lastHour = Steps(items: [])
        case .today:
            today = Steps(items: [])
        case .thisWeek:
            thisWeek = Steps(items: [])
        case .thisMonth:
            thisMonth = Steps(items: [])
        case .betweenDates:
            betweenDates = Steps(items: [])
        }
    }
}

// MARK: - Private

private extension StepsService {

    func executeStatisticsQuery(predicate: NSPredicate?, interval: DateComponents, anchorDate: Date) async throws -> Steps {
        let stepCountType = try HealthParser.quantityType(for: .stepCount)

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsCollectionQuery(
                quantityType: stepCountType,
                quantitySamplePredicate: predicate,
                options: [.cumulativeSum],
                anchorDate: anchorDate,
                intervalComponents: interval
            )

            query.initialResultsHandler = { _, collection, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let statistics = collection?.statistics(), !statistics.isEmpty else {
                    continuation.resume(returning: Steps(items: []))
                    return
                }

                let items = statistics.compactMap { sample -> Steps.Item? in
                    guard let count = sample.sumQuantity()?.doubleValue(for: Self.stepsUnit) else {
                        return nil
                    }
                    return Steps.Item(count: count, startDate: sample.startDate, endDate: sample.endDate)
                }

                continuation.resume(returning: Steps(items: items))
            }

            HealthStoreProvider.shared.execute(query)
        }
    }

    nonisolated static func thisMonthPredicate() -> NSPredicate {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: now)
        let startOfMonth = calendar.date(from: components) ?? now
        return HKQuery.predicateForSamples(withStart: startOfMonth, end: now, options: [])
    }
}
