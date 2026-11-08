//
//  WorkoutManagerTests.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/6/2026.
//

import Testing
import Foundation
import HealthKit
import CoreLocation
@testable import HealthHub

@Suite("WorkoutManager Suite")
struct WorkoutManagerTests {

    let mockReadService: MockWorkoutReadService
    let mockWriteService: MockWorkoutWriteService
    let sut: WorkoutManager

    init() {
        mockReadService = MockWorkoutReadService()
        mockWriteService = MockWorkoutWriteService()
        sut = WorkoutManager(readService: mockReadService, writeService: mockWriteService)
    }

    // MARK: - Read Tests

    @Test("Fetching workouts delegates to read service")
    func fetchWorkouts() async throws {
        let expectedItems = [
            Workout.Item(duration: 3600, energyBurned: 500, distance: 5000, startDate: Date(), endDate: Date(), activityType: .running)
        ]
        mockReadService.stubbedWorkouts = Workout(items: expectedItems)

        let result = try await sut.workouts(fromWorkoutType: .today)

        #expect(mockReadService.workoutsCallCount == 1)
        #expect(result.items.count == 1)
        #expect(result.items[0].duration == 3600)
        #expect(result.items[0].activityType == .running)
    }

    @Test("Fetching workouts with limit delegates correctly")
    func fetchWorkoutsWithLimit() async throws {
        mockReadService.stubbedWorkouts = Workout(items: [])

        _ = try await sut.workouts(fromWorkoutType: .all, limit: 10)

        #expect(mockReadService.workoutsCallCount == 1)
    }

    @Test("Fetching workout route delegates to read service")
    func fetchWorkoutRoute() async throws {
        let locations = [
            Workout.Route.Location(latitude: -33.8688, longitude: 151.2093, altitude: 50, timestamp: Date())
        ]
        mockReadService.stubbedRoute = Workout.Route(locations: locations)

        let start = Date()
        let end = Date().addingTimeInterval(3600)
        let result = try await sut.workoutRoute(for: start, endDate: end)

        #expect(mockReadService.workoutRouteCallCount == 1)
        #expect(result.locations.count == 1)
        #expect(result.locations[0].latitude == -33.8688)
    }

    @Test("Fetching workout heart rate delegates to read service")
    func fetchWorkoutHeartRate() async throws {
        let samples = [
            Workout.HeartRateSample(bpm: 145, timestamp: Date()),
            Workout.HeartRateSample(bpm: 155, timestamp: Date())
        ]
        mockReadService.stubbedHeartRateSamples = samples

        let start = Date()
        let end = Date().addingTimeInterval(3600)
        let result = try await sut.workoutHeartRate(for: start, endDate: end)

        #expect(mockReadService.workoutHeartRateCallCount == 1)
        #expect(result.count == 2)
        #expect(result[0].bpm == 145)
    }

    @Test("Fetching workout events delegates to read service")
    func fetchWorkoutEvents() async throws {
        let events = [
            Workout.Event(type: .lap, startDate: Date(), endDate: Date())
        ]
        mockReadService.stubbedEvents = events

        let start = Date()
        let end = Date().addingTimeInterval(3600)
        let result = try await sut.workoutEvents(for: start, endDate: end)

        #expect(mockReadService.workoutEventsCallCount == 1)
        #expect(result.count == 1)
        #expect(result[0].type == .lap)
    }

    @Test("Fetching workout detail delegates to read service")
    func fetchWorkoutDetail() async throws {
        let item = Workout.Item(duration: 1800, energyBurned: 300, startDate: Date(), endDate: Date(), activityType: .cycling)
        let detail = Workout.Detail(item: item, events: [], route: nil, heartRateSamples: [])
        mockReadService.stubbedDetail = detail

        let start = Date()
        let end = Date().addingTimeInterval(1800)
        let result = try await sut.workoutDetail(for: start, endDate: end)

        #expect(mockReadService.workoutDetailCallCount == 1)
        #expect(result.item.activityType == .cycling)
        #expect(result.item.duration == 1800)
    }

    @Test("Fetch workouts propagates errors from read service")
    func fetchWorkoutsError() async {
        mockReadService.shouldThrowError = NSError(domain: "test", code: 1)
        await #expect(throws: Error.self) {
            _ = try await sut.workouts(fromWorkoutType: .today)
        }
    }

    @Test("Fetch workout route propagates errors from read service")
    func fetchWorkoutRouteError() async {
        mockReadService.shouldThrowError = NSError(domain: "test", code: 2)
        await #expect(throws: Error.self) {
            _ = try await sut.workoutRoute(for: Date(), endDate: Date())
        }
    }

    // MARK: - Write Tests

    @Test("Saving workout delegates to write service")
    func saveWorkout() async throws {
        let workout = Workout.Item(duration: 3600, energyBurned: 500, distance: 5000, startDate: Date(), endDate: Date(), activityType: .running)

        try await sut.saveWorkout(workout: workout, extra: ["key": "value"])

        #expect(mockWriteService.saveWorkoutCallCount == 1)
        #expect(mockWriteService.lastSavedWorkout?.duration == 3600)
        #expect(mockWriteService.lastSavedWorkout?.activityType == .running)
    }

    @Test("Saving workout with events and route delegates to write service")
    func saveWorkoutEnhanced() async throws {
        let workout = Workout.Item(duration: 3600, energyBurned: 500, distance: 10000, startDate: Date(), endDate: Date(), activityType: .running)
        let events = [Workout.Event(type: .lap, startDate: Date())]
        let locations = [CLLocation(latitude: -33.8688, longitude: 151.2093)]
        let hrSamples = [Workout.HeartRateSample(bpm: 150, timestamp: Date())]

        try await sut.saveWorkout(workout: workout, events: events, routeLocations: locations, heartRateSamples: hrSamples, extra: nil)

        #expect(mockWriteService.saveWorkoutEnhancedCallCount == 1)
        #expect(mockWriteService.lastSavedEvents?.count == 1)
        #expect(mockWriteService.lastSavedRouteLocations?.count == 1)
        #expect(mockWriteService.lastSavedHeartRateSamples?.count == 1)
    }

    @Test("Save workout propagates errors from write service")
    func saveWorkoutError() async throws {
        mockWriteService.shouldThrowError = NSError(domain: "test", code: 1)
        let workout = Workout.Item(duration: 100, startDate: Date(), endDate: Date())

        await #expect(throws: Error.self) {
            try await sut.saveWorkout(workout: workout, extra: nil)
        }
    }
}
