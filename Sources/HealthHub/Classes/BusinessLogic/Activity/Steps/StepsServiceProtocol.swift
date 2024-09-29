//
//  StepsServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

public enum StepsType: Sendable {
    
    // count of steps
    case lastHour

    // timeinterval is in hours
    case today(timeInterval: Int)

    // timeinterval is in days
    case thisWeek(timeInterval: Int)
    
    case betweenTimePreference(start: Date, end: Date)
}

public protocol StepsServiceProtocol: Sendable {
    func steps(fromStepsType type: StepsType) throws
    func reset(type: StepsType)
}
