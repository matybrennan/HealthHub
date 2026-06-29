//
//  WorkoutReadServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation
import HealthKit

public enum WorkoutType {

    case today
    case thisWeek
    case thisMonth
    case all
    case betweenDates(start: Date, end: Date)
    case byActivityType(HKWorkoutActivityType)

    func predicate() throws -> NSPredicate? {
        switch self {
        case .today:
            try NSPredicate.today()
        case .thisWeek:
            try NSPredicate.thisWeek()
        case .thisMonth:
            Self.thisMonthPredicate()
        case .all:
            nil
        case let .betweenDates(start, end):
            HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        case let .byActivityType(activityType):
            HKQuery.predicateForWorkouts(with: activityType)
        }
    }

    private static func thisMonthPredicate() -> NSPredicate {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: now)
        let startOfMonth = calendar.date(from: components) ?? now
        return HKQuery.predicateForSamples(withStart: startOfMonth, end: now, options: [])
    }
}

public protocol WorkoutReadServiceProtocol {
    func workouts(fromWorkoutType type: WorkoutType, limit: Int?) async throws -> Workout
    func workoutRoute(for startDate: Date, endDate: Date) async throws -> Workout.Route
    func workoutHeartRate(for startDate: Date, endDate: Date) async throws -> [Workout.HeartRateSample]
    func workoutEvents(for startDate: Date, endDate: Date) async throws -> [Workout.Event]
    func workoutDetail(for startDate: Date, endDate: Date) async throws -> Workout.Detail
}

extension WorkoutReadServiceProtocol {
    public func workouts(fromWorkoutType type: WorkoutType) async throws -> Workout {
        try await workouts(fromWorkoutType: type, limit: nil)
    }
}
