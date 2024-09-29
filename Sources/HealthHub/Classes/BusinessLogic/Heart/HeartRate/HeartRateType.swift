//
//  HeartRateType.swift
//  
//
//  Created by Maty Brennan on 5/8/2024.
//

import Foundation

public enum HeartRateType {

    case current

    // made in mins to get heartRate items for time interval periods
    case today(timeInterval: Int)

    // made in days to get heartRate items for time interval periods
    case thisWeek(timeInterval: Int)

    // made in days to get heartRate items for time interval periods
    case allTime(timeInterval: Int)

    case betweenTimePreference(start: Date, end: Date)
}
