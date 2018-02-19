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
    
}

public protocol WorkoutReadServiceProtocol {
    
    func getWorkouts(fromWorkoutType type: WorkoutType, completionHandler: (AsyncCallResult<WorkoutVM>) -> Void) throws
    
}
