//
//  MockWorkoutReadService.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/6/2026.
//

import Foundation
import HealthKit
@testable import HealthHub

final class MockWorkoutReadService: WorkoutReadServiceProtocol {

    var stubbedWorkouts = Workout(items: [])
    var stubbedRoute = Workout.Route(locations: [])
    var stubbedHeartRateSamples: [Workout.HeartRateSample] = []
    var stubbedEvents: [Workout.Event] = []
    var stubbedDetail = Workout.Detail(item: Workout.Item(duration: 0, startDate: Date(), endDate: Date()))
    var stubbedActivities: [Workout.Activity] = []
    var stubbedEffortRelationships: [Workout.EffortRelationship] = []

    var workoutsCallCount = 0
    var workoutRouteCallCount = 0
    var workoutHeartRateCallCount = 0
    var workoutEventsCallCount = 0
    var workoutDetailCallCount = 0
    var workoutActivitiesCallCount = 0
    var workoutEffortRelationshipsCallCount = 0
    var shouldThrowError: Error?

    func workouts(fromWorkoutType type: WorkoutType, limit: Int?) async throws -> Workout {
        workoutsCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedWorkouts
    }

    func workoutRoute(for startDate: Date, endDate: Date) async throws -> Workout.Route {
        workoutRouteCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedRoute
    }

    func workoutHeartRate(for startDate: Date, endDate: Date) async throws -> [Workout.HeartRateSample] {
        workoutHeartRateCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedHeartRateSamples
    }

    func workoutEvents(for startDate: Date, endDate: Date) async throws -> [Workout.Event] {
        workoutEventsCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedEvents
    }

    func workoutDetail(for startDate: Date, endDate: Date) async throws -> Workout.Detail {
        workoutDetailCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedDetail
    }

    func workoutActivities(for startDate: Date, endDate: Date) async throws -> [Workout.Activity] {
        workoutActivitiesCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedActivities
    }

    func workoutEffortRelationships(for startDate: Date, endDate: Date) async throws -> [Workout.EffortRelationship] {
        workoutEffortRelationshipsCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedEffortRelationships
    }
}
