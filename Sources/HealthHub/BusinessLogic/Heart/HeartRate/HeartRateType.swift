//
//  HeartRateType.swift
//  HealthHub
//
//  Created by Maty Brennan on 5/8/2024.
//

import Foundation

public enum HeartRateType: Sendable {

    /// Fetch the most recent single heart rate reading
    case current

    /// Heart rate data for today, batched in intervals (minutes)
    case today(timeInterval: Int = 60)

    /// Heart rate data for this week, batched in intervals (days)
    case thisWeek(timeInterval: Int = 1)

    /// Heart rate data for this month, batched in intervals (days)
    case thisMonth(timeInterval: Int = 1)

    /// All heart rate data, batched in intervals (days)
    case allTime(timeInterval: Int = 1)

    /// Heart rate data between specific dates
    case betweenDates(start: Date, end: Date, timeInterval: Int? = nil)
}
