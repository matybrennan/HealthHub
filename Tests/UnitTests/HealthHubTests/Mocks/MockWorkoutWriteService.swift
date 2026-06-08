//
//  MockWorkoutWriteService.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/6/2026.
//

import Foundation
import HealthKit
import CoreLocation
@testable import HealthHub

final class MockWorkoutWriteService: WorkoutWriteServiceProtocol {

    var saveWorkoutCallCount = 0
    var saveWorkoutEnhancedCallCount = 0
    var lastSavedWorkout: Workout.Item?
    var lastSavedEvents: [Workout.Event]?
    var lastSavedRouteLocations: [CLLocation]?
    var lastSavedHeartRateSamples: [Workout.HeartRateSample]?
    var lastSavedExtra: [String: Sendable]?
    var shouldThrowError: Error?

    func saveWorkout(workout: Workout.Item, extra: [String: Sendable]?) async throws {
        if let error = shouldThrowError { throw error }
        saveWorkoutCallCount += 1
        lastSavedWorkout = workout
        lastSavedExtra = extra
    }

    func saveWorkout(workout: Workout.Item, events: [Workout.Event]?, routeLocations: [CLLocation]?, heartRateSamples: [Workout.HeartRateSample]?, extra: [String: Sendable]?) async throws {
        if let error = shouldThrowError { throw error }
        saveWorkoutEnhancedCallCount += 1
        lastSavedWorkout = workout
        lastSavedEvents = events
        lastSavedRouteLocations = routeLocations
        lastSavedHeartRateSamples = heartRateSamples
        lastSavedExtra = extra
    }
}
