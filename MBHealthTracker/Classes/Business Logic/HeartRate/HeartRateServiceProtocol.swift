//
//  HeartRateServiceProtocol.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/7/18.
//

import Foundation

public enum HeartRateType {
    
    case current
    
    // made in mins to get heartRate items for time interval periods
    case today(timeInterval: Int?)
    
    case thisWeek(TimeInterval: Int?)
    
    case all(TimeInterval: Int?)
    
    // TODO: Add custom think more into it
    //case between(start: TimeInterval, end: TimeInterval)
}

public protocol HeartRateServiceProtocol {
    
    func getHeartRate(fromHeartRateType type: HeartRateType, completionHandler: @escaping (MBAsyncCallResult<HeartRate>) -> Void) throws
}
