//
//  WorkoutWriteServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation
import HealthKit
import CoreLocation

public protocol WorkoutWriteServiceProtocol {
    func saveWorkout(workout: Workout.Item, extra: [String: Sendable]?) async throws
    func saveWorkout(workout: Workout.Item, events: [Workout.Event]?, routeLocations: [CLLocation]?, heartRateSamples: [Workout.HeartRateSample]?, extra: [String: Sendable]?) async throws
}
