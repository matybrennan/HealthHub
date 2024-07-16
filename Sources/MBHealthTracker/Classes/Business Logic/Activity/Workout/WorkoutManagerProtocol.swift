//
//  WorkoutManagerProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

@MainActor
public protocol WorkoutManagerWriteProtocol: Sendable {
    func saveWorkout(workout: MBWorkout.Item, extra: [String: Sendable]?) async throws
}

@MainActor
public protocol WorkoutManagerReadProtocol: Sendable {
    func workouts(fromWorkoutType type: WorkoutType) async throws -> MBWorkout
}

public typealias WorkoutManagerProtocol = WorkoutManagerWriteProtocol & WorkoutManagerReadProtocol
