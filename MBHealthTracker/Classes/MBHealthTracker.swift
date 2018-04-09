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
    
    lazy var privateConfiguration: ConfigurationServiceProtocol = {
        return ConfigurationService()
    }()
    
    lazy var privateHeartRate: HeartRateServiceProtocol = {
        return HeartRateService()
    }()
    
    lazy var privateSteps: StepsServiceProtocol = {
        return StepsService()
    }()
    
    lazy var privateWorkoutReadService: WorkoutReadServiceProtocol = {
        return WorkoutReadService()
    }()
    
    lazy var privateWorkoutWriteService: WorkoutWriteServiceProtocol = {
        return WorkoutWriteService()
    }()
    
    lazy var privateWorkout: WorkoutManagerProtocol = {
        return WorkoutManager(readService: self.privateWorkoutReadService, writeService: self.privateWorkoutWriteService)
    }()
}

extension MBHealthTracker: MBHealthTrackerProtocol {
    
    // Handles logic for permissions, navigation to health app
    public var configuration: ConfigurationServiceProtocol {
        return privateConfiguration
    }
    
    // handles gathering logic from healthKit regarding heartRate details
    public var heartRate: HeartRateServiceProtocol {
        return privateHeartRate
    }
    
    // handles gathering logic from healthKit regarding stepCount details
    public var steps: StepsServiceProtocol {
        return privateSteps
    }
    
    // handles gathering logic from healthKit regarding workouts
    public var workout: WorkoutManagerProtocol {
        return privateWorkout
    }
    
}
