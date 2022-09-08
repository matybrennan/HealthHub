//
//  WorkoutReadServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation
import HealthKit

public enum WorkoutType {
    
    case today
    case thisWeek
    case all
}

public protocol WorkoutReadServiceProtocol {
    
    func workouts(fromWorkoutType type: WorkoutType) async throws -> MBWorkout
}
