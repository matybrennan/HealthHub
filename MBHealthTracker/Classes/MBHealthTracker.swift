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
    
    // Handles logic for permissions, navigation to health app
    public var configuration: ConfigurationServiceProtocol {
        return ConfigurationService()
    }
    
    // handles gathering logic from healthKit regarding heartRate details
    public var heartRate: HeartRateServiceProtocol {
        return HeartRateService()
    }
    
    // handles gathering logic from healthKit regarding stepCount details
    public var steps: StepsServiceProtocol {
        return StepsService()
    }
    
    // handles gathering logic from healthKit regarding workouts
    public var workout: WorkoutManagerProtocol {
        let readService = WorkoutReadService()
        let writeService = WorkoutWriteService()
        return WorkoutManager(readService: readService, writeService: writeService)
    }
    
}
