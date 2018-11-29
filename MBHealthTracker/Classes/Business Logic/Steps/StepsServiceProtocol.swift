//
//  StepsServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

public enum StepsType {
    
    // count of steps
    case lastHour
    
    // timeInterval for collections of data throughout the day
    /// mainly for graphing purposes
    // timeinterval is in hours
    case today(timeInterval: Int?)
    
    // timeInterval for collections of data throughout the week
    /// mainly for graphing purposes
    // timeinterval is in days
    case thisWeek(timeInterval: Int?)
    case betweenTimePref(start: Date, end: Date, timeInterval: Int)
}


public protocol StepsServiceProtocol {
    
    func getSteps(fromStepsType type: StepsType, completionHandler: @escaping (AsyncCallResult<Steps>) -> Void) throws
}
