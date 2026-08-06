import Foundation
import CoreLocation
@testable import HealthHub

final class MockActivityManager: ActivityManagerProtocol {

    let mockActiveEnergy: MockActiveEnergyService
    let mockSteps: MockStepsService
    let mockWorkout: MockWorkoutManager
    let mockActivity: MockActivityService

    init(
        activeEnergy: MockActiveEnergyService = MockActiveEnergyService(),
        steps: MockStepsService = MockStepsService(),
        workout: MockWorkoutManager = MockWorkoutManager(),
        activity: MockActivityService = MockActivityService()
    ) {
        self.mockActiveEnergy = activeEnergy
        self.mockSteps = steps
        self.mockWorkout = workout
        self.mockActivity = activity
    }

    var activeEnergy: ActiveEnergyServiceProtocol { mockActiveEnergy }
    var steps: StepsServiceProtocol { mockSteps }
    var workout: WorkoutManagerProtocol { mockWorkout }
    var activity: ActivityServiceProtocol { mockActivity }
}

final class MockWorkoutManager: WorkoutManagerProtocol {

    var shouldThrowError: Error?
    var stubbedWorkouts = Workout(items: [])

    func workouts(fromWorkoutType type: WorkoutType) async throws -> Workout {
        if let error = shouldThrowError { throw error }
        return stubbedWorkouts
    }

    func workouts(fromWorkoutType type: WorkoutType, limit: Int?) async throws -> Workout {
        if let error = shouldThrowError { throw error }
        return stubbedWorkouts
    }

    func workoutRoute(for startDate: Date, endDate: Date) async throws -> Workout.Route {
        if let error = shouldThrowError { throw error }
        return Workout.Route(locations: [])
    }

    func workoutHeartRate(for startDate: Date, endDate: Date) async throws -> [Workout.HeartRateSample] {
        if let error = shouldThrowError { throw error }
        return []
    }

    func workoutEvents(for startDate: Date, endDate: Date) async throws -> [Workout.Event] {
        if let error = shouldThrowError { throw error }
        return []
    }

    func workoutDetail(for startDate: Date, endDate: Date) async throws -> Workout.Detail {
        if let error = shouldThrowError { throw error }
        return Workout.Detail(item: Workout.Item(duration: 0, startDate: Date(), endDate: Date()))
    }

    func workoutActivities(for startDate: Date, endDate: Date) async throws -> [Workout.Activity] {
        if let error = shouldThrowError { throw error }
        return []
    }

    func workoutEffortRelationships(for startDate: Date, endDate: Date) async throws -> [Workout.EffortRelationship] {
        if let error = shouldThrowError { throw error }
        return []
    }

    func saveWorkout(workout: Workout.Item, extra: [String: Sendable]?) async throws {
        if let error = shouldThrowError { throw error }
    }

    func saveWorkout(workout: Workout.Item, events: [Workout.Event]?, routeLocations: [CLLocation]?, heartRateSamples: [Workout.HeartRateSample]?, extra: [String: Sendable]?) async throws {
        if let error = shouldThrowError { throw error }
    }
}
