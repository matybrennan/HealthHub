//
//  HeartRateService.swift
//  HealthHub
//
//  Created by Maty Brennan on 5/8/2024.
//

import Foundation
import HealthKit

@Observable
public final class HeartRateService {

    private nonisolated static let heartRateUnit = HKUnit(from: "count/min")

    public private(set) var current: HeartRate.Item?
    public private(set) var today = HeartRate(items: [])
    public private(set) var thisWeek = HeartRate(items: [])
    public private(set) var thisMonth = HeartRate(items: [])
    public private(set) var allTime = HeartRate(items: [])
    public private(set) var betweenDates = HeartRate(items: [])

    public init() { }

    /// Fetch heart rate data for the given type. Updates the corresponding published property.
    public func heartRate(fromHeartRateType type: HeartRateType) async throws {
        switch type {
        case .current:
            current = try await fetchCurrent()
        case let .today(interval):
            today = try await fetchStatistics(predicate: NSPredicate.today(), intervalMinutes: interval, anchorDate: Date().startOfDay)
        case let .thisWeek(interval):
            thisWeek = try await fetchStatistics(predicate: NSPredicate.thisWeek(), intervalDays: interval, anchorDate: Date().startOfDay)
        case let .thisMonth(interval):
            thisMonth = try await fetchStatistics(predicate: Self.thisMonthPredicate(), intervalDays: interval, anchorDate: Date().startOfDay)
        case let .allTime(interval):
            allTime = try await fetchStatistics(predicate: nil, intervalDays: interval, anchorDate: Date().startOfDay)
        case let .betweenDates(start, end, interval):
            let pred = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
            let minutes = interval ?? max(1, Calendar.current.dateComponents([.minute], from: start, to: end).minute ?? 60)
            betweenDates = try await fetchStatistics(predicate: pred, intervalMinutes: minutes, anchorDate: start)
        }
    }

    /// Reset the published data for a given type
    public func reset(type: HeartRateType) {
        switch type {
        case .current:
            current = nil
        case .today:
            today = HeartRate(items: [])
        case .thisWeek:
            thisWeek = HeartRate(items: [])
        case .thisMonth:
            thisMonth = HeartRate(items: [])
        case .allTime:
            allTime = HeartRate(items: [])
        case .betweenDates:
            betweenDates = HeartRate(items: [])
        }
    }
}

// MARK: - Private

private extension HeartRateService {

    func fetchCurrent() async throws -> HeartRate.Item {
        let heartRateType = try HealthParser.quantityType(for: .heartRate)
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.quantitySample(type: heartRateType)],
            sortDescriptors: [sortDescriptor],
            limit: 1
        )
        let samples = try await descriptor.result(for: HealthStoreProvider.shared)
        guard let sample = samples.first else {
            throw AsyncParsingError.unableToParse("No heart rate samples available")
        }
        let bpm = sample.quantity.doubleValue(for: Self.heartRateUnit)
        return HeartRate.Item(max: bpm, min: bpm, average: bpm, startDate: sample.startDate, endDate: sample.endDate)
    }

    func fetchStatistics(predicate: NSPredicate?, intervalMinutes: Int, anchorDate: Date) async throws -> HeartRate {
        var component = DateComponents()
        component.minute = intervalMinutes
        return try await executeStatisticsQuery(predicate: predicate, interval: component, anchorDate: anchorDate)
    }

    func fetchStatistics(predicate: NSPredicate?, intervalDays: Int, anchorDate: Date) async throws -> HeartRate {
        var component = DateComponents()
        component.day = intervalDays
        return try await executeStatisticsQuery(predicate: predicate, interval: component, anchorDate: anchorDate)
    }

    func executeStatisticsQuery(predicate: NSPredicate?, interval: DateComponents, anchorDate: Date) async throws -> HeartRate {
        let heartRateType = try HealthParser.quantityType(for: .heartRate)

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsCollectionQuery(
                quantityType: heartRateType,
                quantitySamplePredicate: predicate,
                options: [.discreteAverage, .discreteMax, .discreteMin],
                anchorDate: anchorDate,
                intervalComponents: interval
            )

            query.initialResultsHandler = { _, collection, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let statistics = collection?.statistics(), !statistics.isEmpty else {
                    continuation.resume(returning: HeartRate(items: []))
                    return
                }

                let items = statistics.compactMap { sample -> HeartRate.Item? in
                    guard let max = sample.maximumQuantity()?.doubleValue(for: Self.heartRateUnit),
                          let min = sample.minimumQuantity()?.doubleValue(for: Self.heartRateUnit),
                          let average = sample.averageQuantity()?.doubleValue(for: Self.heartRateUnit) else {
                        return nil
                    }
                    return HeartRate.Item(max: max, min: min, average: average, startDate: sample.startDate, endDate: sample.endDate)
                }

                continuation.resume(returning: HeartRate(items: items))
            }

            HealthStoreProvider.shared.execute(query)
        }
    }

    static func thisMonthPredicate() -> NSPredicate {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: now)
        let startOfMonth = calendar.date(from: components) ?? now
        return HKQuery.predicateForSamples(withStart: startOfMonth, end: now, options: [])
    }
}
