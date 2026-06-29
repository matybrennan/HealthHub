//
//  StepsServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

public enum StepsType: Sendable {

    /// Total steps in the last hour
    case lastHour

    /// Steps today, batched in intervals (hours)
    case today(timeInterval: Int = 1)

    /// Steps this week, batched in intervals (hours)
    case thisWeek(timeInterval: Int = 24)

    /// Steps this month, batched in intervals (days)
    case thisMonth(timeInterval: Int = 1)

    /// Steps between specific dates
    case betweenDates(start: Date, end: Date)
}

public protocol StepsServiceProtocol {
    var lastHour: Steps { get }
    var today: Steps { get }
    var thisWeek: Steps { get }
    var thisMonth: Steps { get }
    var betweenDates: Steps { get }

    func steps(fromStepsType type: StepsType) async throws
    func reset(type: StepsType)
}
