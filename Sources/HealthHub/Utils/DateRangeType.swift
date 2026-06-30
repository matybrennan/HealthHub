//
//  DateRangeType.swift
//  HealthHub
//
//  Created by Maty Brennan on 30/6/2026.
//

import Foundation
import HealthKit

/// A flexible date range type for filtering HealthKit queries across all services.
/// Use this to limit data fetching to specific time periods for better performance.
public enum DateRangeType: Sendable {
    case today
    case thisWeek
    case thisMonth
    case lastNDays(Int)
    case betweenDates(start: Date, end: Date)
    case allTime

    func predicate() throws -> NSPredicate? {
        switch self {
        case .today:
            return try NSPredicate.today()
        case .thisWeek:
            return try NSPredicate.thisWeek()
        case .thisMonth:
            return Self.thisMonthPredicate()
        case let .lastNDays(days):
            let now = Date()
            let start = Calendar.current.date(byAdding: .day, value: -days, to: now) ?? now
            return HKQuery.predicateForSamples(withStart: start, end: now, options: [])
        case let .betweenDates(start, end):
            return HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        case .allTime:
            return nil
        }
    }

    private static func thisMonthPredicate() -> NSPredicate {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: now)
        let startOfMonth = calendar.date(from: components) ?? now
        return HKQuery.predicateForSamples(withStart: startOfMonth, end: now, options: [])
    }
}
