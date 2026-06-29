//
//  ActiveEnergyServiceProtocol.swift
//  HealthHub
//
//  Created by matybrennan on 27/11/18.
//

import Foundation
import HealthKit

public enum ActiveEnergyType: Sendable {
    case today
    case thisWeek
    case thisMonth
    case betweenDates(start: Date, end: Date)

    func predicate() throws -> NSPredicate {
        switch self {
        case .today:
            try NSPredicate.today()
        case .thisWeek:
            try NSPredicate.thisWeek()
        case .thisMonth:
            Self.thisMonthPredicate()
        case let .betweenDates(startDate, endDate):
            HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
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

public protocol ActiveEnergyServiceProtocol {
    func activeEnergy(from type: ActiveEnergyType) async throws -> ActiveEnergy
}
