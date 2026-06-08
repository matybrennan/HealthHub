//
//  ActivityManager.swift
//  HealthHub
//
//  Created by matybrennan on 9/10/19.
//

import Foundation

public final class ActivityManager {

    private let activeEnergyService: ActiveEnergyServiceProtocol
    private let stepsService: StepsServiceProtocol
    private let workoutManagerService: WorkoutManagerProtocol
    private let activityService: ActivityServiceProtocol

    public init(
        activeEnergy: ActiveEnergyServiceProtocol,
        steps: StepsServiceProtocol,
        workout: WorkoutManagerProtocol,
        activity: ActivityServiceProtocol
    ) {
        self.activeEnergyService = activeEnergy
        self.stepsService = steps
        self.workoutManagerService = workout
        self.activityService = activity
    }

    public convenience init() {
        let workoutReadService = WorkoutReadService()
        let workoutWriteService = WorkoutWriteService()
        self.init(
            activeEnergy: ActiveEnergyService(),
            steps: StepsService(),
            workout: WorkoutManager(readService: workoutReadService, writeService: workoutWriteService),
            activity: ActivityService()
        )
    }
}

// MARK: - ActivityManagerProtocol
extension ActivityManager: ActivityManagerProtocol {

    public var activeEnergy: ActiveEnergyServiceProtocol { activeEnergyService }
    public var steps: StepsServiceProtocol { stepsService }
    public var workout: WorkoutManagerProtocol { workoutManagerService }
    public var activity: ActivityServiceProtocol { activityService }
}
