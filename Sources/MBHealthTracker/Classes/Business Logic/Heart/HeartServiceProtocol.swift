//
//  HeartServiceProtocol.swift
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
    
    case betweenTimePref(start: Date, end: Date)
}

public protocol HeartServiceProtocol {
    
    func heartRate(fromHeartRateType type: HeartRateType, completionHandler: @escaping (MBAsyncCallResult<HeartRate>) -> Void) throws
}
