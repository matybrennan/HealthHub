//
//  WorkoutManagerProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

public protocol WorkoutManagerWriteProtocol: Sendable {
    func saveWorkout(workout: Workout.Item, extra: [String: Sendable]?) async throws
}

public protocol WorkoutManagerReadProtocol: Sendable {
    func workouts(fromWorkoutType type: WorkoutType) async throws -> Workout
}

public typealias WorkoutManagerProtocol = WorkoutManagerWriteProtocol & WorkoutManagerReadProtocol
