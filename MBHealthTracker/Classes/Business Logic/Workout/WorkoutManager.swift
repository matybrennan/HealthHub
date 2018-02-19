//
//  WorkoutManager.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

public class WorkoutManager {
    
    private var workoutReadService: WorkoutReadServiceProtocol
    private var workoutWriteService: WorkoutWriteServiceProtocol
    
    init(readService: WorkoutReadServiceProtocol, writeService: WorkoutWriteServiceProtocol) {
        workoutReadService = readService
        workoutWriteService = writeService
    }
    
}

extension WorkoutManager: WorkoutManagerProtocol {
    
    public func getWorkouts(fromWorkoutType type: WorkoutType, completionHandler: (AsyncCallResult<WorkoutVM>) -> Void) throws {
        try workoutReadService.getWorkouts(fromWorkoutType: type, completionHandler: completionHandler)
    }
    
}
