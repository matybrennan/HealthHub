//
//  MBHealthTrackerProtocol.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit

public protocol MBHealthTrackerProtocol {
    
    var configuration: ConfigurationServiceProtocol { get }
    
    var heartRate: HeartRateServiceProtocol { get }
    
    var steps: StepsServiceProtocol { get }
}
