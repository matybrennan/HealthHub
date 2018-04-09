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
    
    private(set) lazy var privateConfiguration: ConfigurationServiceProtocol = {
        return ConfigurationService()
    }()
    
    private(set) lazy var privateHeartRate: HeartRateServiceProtocol = {
        return HeartRateService()
    }()
    
    private(set) lazy var privateSteps: StepsServiceProtocol = {
        return StepsService()
    }()
    
    private(set) lazy var privateWorkoutReadService: WorkoutReadServiceProtocol = {
        return WorkoutReadService()
    }()
    
    private(set) lazy var privateWorkoutWriteService: WorkoutWriteServiceProtocol = {
        return WorkoutWriteService()
    }()
    
    private(set) lazy var privateWorkout: WorkoutManagerProtocol = {
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
