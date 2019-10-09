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
        return ActiveEnergyService()
    }()
    
    lazy var privateSteps: StepsServiceProtocol = {
        return StepsService()
    }()
    
    private lazy var privateWorkoutReadService: WorkoutReadServiceProtocol = {
        return WorkoutReadService()
    }()
    
    private lazy var privateWorkoutWriteService: WorkoutWriteServiceProtocol = {
        return WorkoutWriteService()
    }()
    
    lazy var privateWorkout: WorkoutManagerProtocol = {
        return WorkoutManager(readService: self.privateWorkoutReadService, writeService: self.privateWorkoutWriteService)
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
