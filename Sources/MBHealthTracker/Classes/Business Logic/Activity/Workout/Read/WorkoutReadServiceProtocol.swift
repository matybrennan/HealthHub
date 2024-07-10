//
//  WorkoutReadServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation

public enum WorkoutType {
    
    case today
    case thisWeek
    case all
}

@MainActor
public protocol WorkoutReadServiceProtocol: Sendable {

    func workouts(fromWorkoutType type: WorkoutType) async throws -> MBWorkout
}
