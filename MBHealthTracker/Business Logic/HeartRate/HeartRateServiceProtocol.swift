//
//  HeartRateServiceProtocol.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/7/18.
//

import Foundation

public enum HeartRateParsingError: LocalizedError {
    case unableToParse(String)
    
    public var errorDescription: String? {
        switch self {
        case let .unableToParse(value): return "Unable to parse: \(value)"
        }
    }
    
}

public enum HeartRateType {
    
    case current
    
    // time intervals between heartRate
    
    // made in mins to get heartRate items for time interval periods
    case today(timeInterval: Int?)
    
    case thisWeek
    
    case thisYear
    case all
    
    // TODO: Add custom think more into it
    //case between(start: TimeInterval, end: TimeInterval)
}

public protocol HeartRateServiceProtocol {
    
    func getHeartRate(fromHeartRateType type: HeartRateType, completionHandler: @escaping (AsyncCallResult<HeartRateVM>) -> Void) throws
    
}
