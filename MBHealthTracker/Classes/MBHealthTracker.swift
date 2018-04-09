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
    
    private lazy var privateConfiguration: ConfigurationServiceProtocol = {
        return ConfigurationService()
    }()
    
    private lazy var privateHeartRate: HeartRateServiceProtocol = {
        return HeartRateService()
    }()
    
    private lazy var privateSteps: StepsServiceProtocol = {
        return StepsService()
    }()
    
    private lazy var privateWorkoutReadService: WorkoutReadServiceProtocol = {
        return WorkoutReadService()
    }()
    
    private lazy var privateWorkoutWriteService: WorkoutWriteServiceProtocol = {
        return WorkoutWriteService()
    }()
    
    private lazy var privateWorkout: WorkoutManagerProtocol = {
        return WorkoutManager(readService: privateWorkoutReadService, writeService: privateWorkoutWriteService)
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
