//
//  WorkoutReadServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation

public enum WorkoutType {
    
    case today
    case thisWeek
    case all

    func predicate() throws -> NSPredicate? {
        switch self {
        case .today:
            try NSPredicate.today()
        case .thisWeek:
            try NSPredicate.thisWeek()
        case .all:
            nil
        }
    }
}

public protocol WorkoutReadServiceProtocol: Sendable {
    func workouts(fromWorkoutType type: WorkoutType) async throws -> Workout
}
