//
//  MBHealthTracker.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit

open class MBHealthTracker {
    
    public init() { }
    
}

extension MBHealthTracker: MBHealthTrackerProtocol {
    
    public var configuration: ConfigurationServiceProtocol {
        return ConfigurationService()
    }
    
    public var heartRate: HeartRateServiceProtocol {
        return HeartRateService()
    }
    
}
