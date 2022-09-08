//
//  WorkoutManagerProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

public protocol WorkoutManagerWriteProtocol {
    func saveWorkout(workout: MBWorkout.Item, extra: [String: Any]?) async throws
}

public protocol WorkoutManagerReadProtocol {
    func workouts(fromWorkoutType type: WorkoutType) async throws -> MBWorkout
}

public typealias WorkoutManagerProtocol = WorkoutManagerWriteProtocol &  WorkoutManagerReadProtocol
