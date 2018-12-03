//
//  WorkoutManager.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

public class WorkoutManager {
    
    private let workoutReadService: WorkoutReadServiceProtocol
    private let workoutWriteService: WorkoutWriteServiceProtocol
    
    init(readService: WorkoutReadServiceProtocol, writeService: WorkoutWriteServiceProtocol) {
        workoutReadService = readService
        workoutWriteService = writeService
    }
}

extension WorkoutManager: WorkoutManagerProtocol {
    
    // MARK: Read Service
    
    public func getWorkouts(fromWorkoutType type: WorkoutType, completionHandler: @escaping (MBAsyncCallResult<Workout>) -> Void) throws {
        try workoutReadService.getWorkouts(fromWorkoutType: type, completionHandler: completionHandler)
    }
    
    
    
    // MARK: Write Service
    
    public func saveWorkout(workout: Workout.Item, extra: [String : Any]?, completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws {
        try workoutWriteService.saveWorkout(workout: workout, extra: extra, completionHandler: completionHandler)
    }
}
