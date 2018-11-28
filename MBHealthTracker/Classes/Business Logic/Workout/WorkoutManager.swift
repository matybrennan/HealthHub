//
//  WorkoutManager.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

public class WorkoutManager {
    
    var workoutReadService: WorkoutReadServiceProtocol
    var workoutWriteService: WorkoutWriteServiceProtocol
    
    init(readService: WorkoutReadServiceProtocol, writeService: WorkoutWriteServiceProtocol) {
        workoutReadService = readService
        workoutWriteService = writeService
    }
}

extension WorkoutManager: WorkoutManagerProtocol {
    
    // MARK: Read Service
    
    public func getWorkouts(fromWorkoutType type: WorkoutType, completionHandler: @escaping (AsyncCallResult<Workout>) -> Void) throws {
        try workoutReadService.getWorkouts(fromWorkoutType: type, completionHandler: completionHandler)
    }
    
    
    
    // MARK: Write Service
    
    public func saveWorkout(workout: Workout.Item, extra: [String : Any]?, completionHandler: @escaping (AsyncCallResult<Bool>) -> Void) throws {
        try workoutWriteService.saveWorkout(workout: workout, extra: extra, completionHandler: completionHandler)
    }
}
