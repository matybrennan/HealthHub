//
//  ActivityManager.swift
//  MBHealthTracker
//
//  Created by matybrennan on 9/10/19.
//

import Foundation

open class ActivityManager {
    
    public init() { }
    
    lazy var activeEnergyService: ActiveEnergyServiceProtocol = {
        ActiveEnergyService()
    }()
    
    lazy var privateSteps: StepsServiceProtocol = {
        StepsService()
    }()
    
    private lazy var privateWorkoutReadService: WorkoutReadServiceProtocol = {
        WorkoutReadService()
    }()
    
    private lazy var privateWorkoutWriteService: WorkoutWriteServiceProtocol = {
        WorkoutWriteService()
    }()
    
    lazy var privateWorkout: WorkoutManagerProtocol = {
        WorkoutManager(readService: self.privateWorkoutReadService, writeService: self.privateWorkoutWriteService)
    }()
}

// MARK: - ActivityManagerProtocol
extension ActivityManager: ActivityManagerProtocol {
    
    /// handles gathering logic about active energy burned from healthstore
    public var activeEnergy: ActiveEnergyServiceProtocol {
        return activeEnergyService
    }
    
    /// handles gathering logic from healthKit regarding stepCount details
    public var steps: StepsServiceProtocol {
        return privateSteps
    }
    
    /// handles gathering logic from healthKit regarding workouts
    public var workout: WorkoutManagerProtocol {
        return privateWorkout
    }
}
