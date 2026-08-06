//
//  WorkoutManager.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit
import CoreLocation

public final class WorkoutManager {

    private let workoutReadService: WorkoutReadServiceProtocol
    private let workoutWriteService: WorkoutWriteServiceProtocol
    
    public init(readService: WorkoutReadServiceProtocol, writeService: WorkoutWriteServiceProtocol) {
        workoutReadService = readService
        workoutWriteService = writeService
    }
}

extension WorkoutManager: WorkoutManagerProtocol {
    
    // MARK: Read Service
    
    public func workouts(fromWorkoutType type: WorkoutType) async throws -> Workout {
        try await workoutReadService.workouts(fromWorkoutType: type, limit: nil)
    }

    public func workouts(fromWorkoutType type: WorkoutType, limit: Int?) async throws -> Workout {
        try await workoutReadService.workouts(fromWorkoutType: type, limit: limit)
    }

    public func workoutRoute(for startDate: Date, endDate: Date) async throws -> Workout.Route {
        try await workoutReadService.workoutRoute(for: startDate, endDate: endDate)
    }

    public func workoutHeartRate(for startDate: Date, endDate: Date) async throws -> [Workout.HeartRateSample] {
        try await workoutReadService.workoutHeartRate(for: startDate, endDate: endDate)
    }

    public func workoutEvents(for startDate: Date, endDate: Date) async throws -> [Workout.Event] {
        try await workoutReadService.workoutEvents(for: startDate, endDate: endDate)
    }

    public func workoutDetail(for startDate: Date, endDate: Date) async throws -> Workout.Detail {
        try await workoutReadService.workoutDetail(for: startDate, endDate: endDate)
    }

    public func workoutActivities(for startDate: Date, endDate: Date) async throws -> [Workout.Activity] {
        try await workoutReadService.workoutActivities(for: startDate, endDate: endDate)
    }

    public func workoutEffortRelationships(for startDate: Date, endDate: Date) async throws -> [Workout.EffortRelationship] {
        try await workoutReadService.workoutEffortRelationships(for: startDate, endDate: endDate)
    }
    
    // MARK: Write Service
    
    public func saveWorkout(workout: Workout.Item, extra: [String: Sendable]?) async throws {
        try await workoutWriteService.saveWorkout(workout: workout, extra: extra)
    }

    public func saveWorkout(workout: Workout.Item, events: [Workout.Event]?, routeLocations: [CLLocation]?, heartRateSamples: [Workout.HeartRateSample]?, extra: [String: Sendable]?) async throws {
        try await workoutWriteService.saveWorkout(workout: workout, events: events, routeLocations: routeLocations, heartRateSamples: heartRateSamples, extra: extra)
    }
}
