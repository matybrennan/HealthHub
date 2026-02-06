//
//  ActivityManager.swift
//  HealthHub
//
//  Created by matybrennan on 9/10/19.
//

import Foundation

public final class ActivityManager {

    public init() { }
    
    private lazy var activeEnergyService = ActiveEnergyService()
    private lazy var stepsService = StepsService()
    private lazy var workoutReadService = WorkoutReadService()
    private lazy var workoutWriteService = WorkoutWriteService()

    private lazy var workoutManager = WorkoutManager(
        readService: workoutReadService,
        writeService: workoutWriteService
    )
}

// MARK: - ActivityManagerProtocol
extension ActivityManager: ActivityManagerProtocol {

    public var activeEnergy: ActiveEnergyServiceProtocol { activeEnergyService }
    public var steps: StepsServiceProtocol { stepsService }
    public var workout: WorkoutManagerProtocol { workoutManager }
}
