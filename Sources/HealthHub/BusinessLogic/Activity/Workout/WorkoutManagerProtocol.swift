//
//  WorkoutManagerProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit
import CoreLocation

public protocol WorkoutManagerWriteProtocol {
    func saveWorkout(workout: Workout.Item, extra: [String: Sendable]?) async throws
    func saveWorkout(workout: Workout.Item, events: [Workout.Event]?, routeLocations: [CLLocation]?, heartRateSamples: [Workout.HeartRateSample]?, extra: [String: Sendable]?) async throws
}

public protocol WorkoutManagerReadProtocol {
    func workouts(fromWorkoutType type: WorkoutType) async throws -> Workout
    func workouts(fromWorkoutType type: WorkoutType, limit: Int?) async throws -> Workout
    func workoutRoute(for startDate: Date, endDate: Date) async throws -> Workout.Route
    func workoutHeartRate(for startDate: Date, endDate: Date) async throws -> [Workout.HeartRateSample]
    func workoutEvents(for startDate: Date, endDate: Date) async throws -> [Workout.Event]
    func workoutDetail(for startDate: Date, endDate: Date) async throws -> Workout.Detail
}

public typealias WorkoutManagerProtocol = WorkoutManagerWriteProtocol & WorkoutManagerReadProtocol
