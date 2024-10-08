//
//  ActivityManager.swift
//  HealthHub
//
//  Created by matybrennan on 9/10/19.
//

import Foundation

public final class ActivityManager: @unchecked Sendable {

    public init() { }
    
    private lazy var activeEnergyService = ActiveEnergyService()

    private lazy var privateSteps = StepsService()

    private lazy var privateWorkoutReadService = WorkoutReadService()

    private lazy var privateWorkoutWriteService = WorkoutWriteService()

    private lazy var privateWorkout = WorkoutManager(readService: self.privateWorkoutReadService, writeService: self.privateWorkoutWriteService)
}

// MARK: - ActivityManagerProtocol
extension ActivityManager: ActivityManagerProtocol {

    public var activeEnergy: ActiveEnergyServiceProtocol {
        activeEnergyService
    }

    public var steps: StepsServiceProtocol {
        privateSteps
    }
    
    public var workout: WorkoutManagerProtocol {
        privateWorkout
    }
}
