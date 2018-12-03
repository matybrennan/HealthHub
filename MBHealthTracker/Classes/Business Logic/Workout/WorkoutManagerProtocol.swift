//
//  WorkoutManagerProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

public protocol WorkoutManagerWriteProtocol {
    
    func saveWorkout(workout: Workout.Item, extra: [String: Any]?, completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws
}

public protocol WorkoutManagerReadProtocol {
    
    func getWorkouts(fromWorkoutType type: WorkoutType, completionHandler: @escaping (MBAsyncCallResult<Workout>) -> Void) throws
}

public typealias WorkoutManagerProtocol = WorkoutManagerWriteProtocol &  WorkoutManagerReadProtocol
