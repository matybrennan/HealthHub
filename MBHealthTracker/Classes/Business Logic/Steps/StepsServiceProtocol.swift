//
//  StepsServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

public enum StepsParsingError: LocalizedError {
    case unableToParse(String)
    
    public var errorDescription: String? {
        switch self {
        case let .unableToParse(value): return "Unable to parse: \(value)"
        }
    }
}

public enum StepsType {
    
    // count of steps
    case lastHour
    
    // timeInterval for collections of data throughout the day
    /// mainly for graphing purposes
    // timeinterval is in hours
    case today(timeInterval: Int)
    
    
    case thisWeek
    case betweenTimePref(start: Double, end: Double)
    
}


public protocol StepsServiceProtocol {
    
    func getSteps(fromStepsType type: StepsType, completionHandler: @escaping (AsyncCallResult<StepsVM>) -> Void) throws
    
}
