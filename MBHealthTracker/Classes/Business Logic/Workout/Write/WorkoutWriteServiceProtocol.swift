//
//  WorkoutWriteServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation
import HealthKit

public protocol WorkoutWriteServiceProtocol {
    
    func saveWorkout(workout: Workout.Item, extra: [String: Any]?, completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws
}
