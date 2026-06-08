//
//  WorkoutWriteService.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation
import HealthKit
import CoreLocation

public final class WorkoutWriteService {
    
    public init() { }
}

extension WorkoutWriteService: WorkoutWriteServiceProtocol {
    
    public func saveWorkout(workout: Workout.Item, extra: [String: Sendable]?) async throws {
        try await saveWorkout(workout: workout, events: nil, routeLocations: nil, heartRateSamples: nil, extra: extra)
    }

    public func saveWorkout(workout: Workout.Item, events: [Workout.Event]?, routeLocations: [CLLocation]?, heartRateSamples: [Workout.HeartRateSample]?, extra: [String: Sendable]?) async throws {
        
        let workoutType = try HealthParser.workoutTypeAndCheckIfAvailable()
        try HealthParser.checkSharingAuthorizationStatus(for: workoutType)
        
        let healthStore = HealthStoreProvider.shared
        let config = HKWorkoutConfiguration()
        config.activityType = workout.activityType

        let builder = HKWorkoutBuilder(healthStore: healthStore, configuration: config, device: .local())
        
        try await builder.beginCollection(at: workout.startDate)

        // Add workout events (laps, pauses, etc.)
        if let events {
            for event in events {
                let dateInterval = DateInterval(start: event.startDate, end: event.endDate ?? event.startDate)
                let hkEvent = HKWorkoutEvent(type: event.type, dateInterval: dateInterval, metadata: event.metadata as? [String: Any])
                try await builder.addWorkoutEvents([hkEvent])
            }
        }

        // Add associated heart rate samples
        if let heartRateSamples, !heartRateSamples.isEmpty {
            let hrType = HKQuantityType(.heartRate)
            let hrUnit = HKUnit.count().unitDivided(by: .minute())
            let hkSamples: [HKQuantitySample] = heartRateSamples.map {
                HKQuantitySample(
                    type: hrType,
                    quantity: HKQuantity(unit: hrUnit, doubleValue: $0.bpm),
                    start: $0.timestamp,
                    end: $0.timestamp
                )
            }
            try await builder.addSamples(hkSamples)
        }

        // Add energy and distance as samples for the builder
        var metadata: [String: Any] = (extra as? [String: Any]) ?? [:]

        if let energy = workout.energyBurned {
            let energySample = HKQuantitySample(
                type: HKQuantityType(.activeEnergyBurned),
                quantity: HKQuantity(unit: .smallCalorie(), doubleValue: energy),
                start: workout.startDate,
                end: workout.endDate
            )
            try await builder.addSamples([energySample])
        }

        if let distance = workout.distance {
            let distanceSample = HKQuantitySample(
                type: HKQuantityType(.distanceWalkingRunning),
                quantity: HKQuantity(unit: .meter(), doubleValue: distance),
                start: workout.startDate,
                end: workout.endDate
            )
            try await builder.addSamples([distanceSample])
        }

        if let elevationAscended = workout.elevationAscended {
            metadata[HKMetadataKeyElevationAscended] = HKQuantity(unit: .meter(), doubleValue: elevationAscended)
        }
        if let elevationDescended = workout.elevationDescended {
            metadata[HKMetadataKeyElevationDescended] = HKQuantity(unit: .meter(), doubleValue: elevationDescended)
        }

        if !metadata.isEmpty {
            try await builder.addMetadata(metadata)
        }

        try await builder.endCollection(at: workout.endDate)
        let finishedWorkout = try await builder.finishWorkout()

        // Save route data if provided
        if let routeLocations, !routeLocations.isEmpty, let finishedWorkout {
            let routeBuilder = HKWorkoutRouteBuilder(healthStore: healthStore, device: .local())
            try await routeBuilder.insertRouteData(routeLocations)
            try await routeBuilder.finishRoute(with: finishedWorkout, metadata: nil)
        }
    }
}
