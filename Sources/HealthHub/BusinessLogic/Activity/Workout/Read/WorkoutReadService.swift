//
//  WorkoutReadService.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation
import HealthKit
import CoreLocation

public final class WorkoutReadService {

    struct Unit {
        static let workoutEnergy = HKUnit.smallCalorie()
        static let workoutDistance = HKUnit.meter()
        static let heartRate = HKUnit.count().unitDivided(by: .minute())
        static let elevation = HKUnit.meter()
        static let strokeCount = HKUnit.count()
    }
    
    public init() { }
}

// MARK: - FetchWorkoutSample
extension WorkoutReadService: FetchWorkoutSample { }

// MARK: - FetchQuantitySample
extension WorkoutReadService: FetchQuantitySample { }

// MARK: - WorkoutReadServiceProtocol
extension WorkoutReadService: WorkoutReadServiceProtocol {
    
    public func workouts(fromWorkoutType type: WorkoutType, limit: Int?) async throws -> Workout {
        
        let pred = try type.predicate()
        let samples = try await fetchWorkoutSamples(
            workoutIdentifier: .workoutType(),
            predicate: pred,
            sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)],
            limit: limit
        )
        let workoutItems = samples.map { sample in
            Workout.Item(
                duration: sample.duration,
                energyBurned: sample.totalEnergyBurned?.doubleValue(for: Unit.workoutEnergy),
                distance: sample.totalDistance?.doubleValue(for: Unit.workoutDistance),
                startDate: sample.startDate,
                endDate: sample.endDate,
                activityType: sample.workoutActivityType,
                source: sample.sourceRevision.source.name,
                elevationAscended: sample.metadata?[HKMetadataKeyElevationAscended] as? Double,
                elevationDescended: sample.metadata?[HKMetadataKeyElevationDescended] as? Double,
                swimmingStrokeCount: sample.totalSwimmingStrokeCount?.doubleValue(for: Unit.strokeCount),
                metadata: sample.metadata as? [String: Sendable]
            )
        }
        
        return Workout(items: workoutItems)
    }

    public func workoutRoute(for startDate: Date, endDate: Date) async throws -> Workout.Route {
        let workout = try await findWorkout(startDate: startDate, endDate: endDate)
        let locations = try await fetchRouteLocations(for: workout)
        let routeLocations = locations.map {
            Workout.Route.Location(
                latitude: $0.coordinate.latitude,
                longitude: $0.coordinate.longitude,
                altitude: $0.altitude,
                timestamp: $0.timestamp,
                speed: $0.speed >= 0 ? $0.speed : nil,
                horizontalAccuracy: $0.horizontalAccuracy >= 0 ? $0.horizontalAccuracy : nil
            )
        }
        return Workout.Route(locations: routeLocations)
    }

    public func workoutHeartRate(for startDate: Date, endDate: Date) async throws -> [Workout.HeartRateSample] {
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let samples = try await fetchQuantitySamples(
            quantityIdentifier: .heartRate,
            predicate: predicate,
            sortDescriptors: [SortDescriptor(\.startDate, order: .forward)],
            limit: nil
        )
        return samples.map {
            Workout.HeartRateSample(
                bpm: $0.quantity.doubleValue(for: Unit.heartRate),
                timestamp: $0.startDate
            )
        }
    }

    public func workoutEvents(for startDate: Date, endDate: Date) async throws -> [Workout.Event] {
        let workout = try await findWorkout(startDate: startDate, endDate: endDate)
        guard let hkEvents = workout.workoutEvents else { return [] }
        return hkEvents.map {
            Workout.Event(
                type: $0.type,
                startDate: $0.dateInterval.start,
                endDate: $0.dateInterval.end,
                metadata: $0.metadata as? [String: Sendable]
            )
        }
    }

    public func workoutDetail(for startDate: Date, endDate: Date) async throws -> Workout.Detail {
        let workout = try await findWorkout(startDate: startDate, endDate: endDate)

        let item = Workout.Item(
            duration: workout.duration,
            energyBurned: workout.totalEnergyBurned?.doubleValue(for: Unit.workoutEnergy),
            distance: workout.totalDistance?.doubleValue(for: Unit.workoutDistance),
            startDate: workout.startDate,
            endDate: workout.endDate,
            activityType: workout.workoutActivityType,
            source: workout.sourceRevision.source.name,
            elevationAscended: workout.metadata?[HKMetadataKeyElevationAscended] as? Double,
            elevationDescended: workout.metadata?[HKMetadataKeyElevationDescended] as? Double,
            swimmingStrokeCount: workout.totalSwimmingStrokeCount?.doubleValue(for: Unit.strokeCount),
            metadata: workout.metadata as? [String: Sendable]
        )

        let events: [Workout.Event] = (workout.workoutEvents ?? []).map {
            Workout.Event(
                type: $0.type,
                startDate: $0.dateInterval.start,
                endDate: $0.dateInterval.end,
                metadata: $0.metadata as? [String: Sendable]
            )
        }

        let route: Workout.Route?
        let locations = try? await fetchRouteLocations(for: workout)
        if let locations, !locations.isEmpty {
            route = Workout.Route(locations: locations.map {
                Workout.Route.Location(
                    latitude: $0.coordinate.latitude,
                    longitude: $0.coordinate.longitude,
                    altitude: $0.altitude,
                    timestamp: $0.timestamp,
                    speed: $0.speed >= 0 ? $0.speed : nil,
                    horizontalAccuracy: $0.horizontalAccuracy >= 0 ? $0.horizontalAccuracy : nil
                )
            })
        } else {
            route = nil
        }

        let heartRateSamples = try await workoutHeartRate(for: startDate, endDate: endDate)

        // Calculate average heart rate
        var enrichedItem = item
        if !heartRateSamples.isEmpty {
            let avgBPM = heartRateSamples.reduce(0.0) { $0 + $1.bpm } / Double(heartRateSamples.count)
            enrichedItem.averageHeartRate = avgBPM
        }

        return Workout.Detail(
            item: enrichedItem,
            events: events,
            route: route,
            heartRateSamples: heartRateSamples
        )
    }

    public func workoutActivities(for startDate: Date, endDate: Date) async throws -> [Workout.Activity] {
        let workout = try await findWorkout(startDate: startDate, endDate: endDate)
        return workout.workoutActivities.map {
            Workout.Activity(
                activityType: $0.workoutConfiguration.activityType,
                startDate: $0.startDate,
                endDate: $0.endDate,
                duration: $0.duration,
                metadata: $0.metadata as? [String: Sendable]
            )
        }
    }

    public func workoutEffortRelationships(for startDate: Date, endDate: Date) async throws -> [Workout.EffortRelationship] {
        let workout = try await findWorkout(startDate: startDate, endDate: endDate)
        let predicate = HKQuery.predicateForObjects(from: workout)
        let resumeLock = NSLock()
        var hasResumed = false

        let relationships = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[HKWorkoutEffortRelationship], Error>) in
            let query = HKWorkoutEffortRelationshipQuery(predicate: predicate, anchor: nil, options: .mostRelevant) { query, relationships, _, error in
                HealthStoreProvider.shared.stop(query)

                resumeLock.lock()
                defer { resumeLock.unlock() }
                guard !hasResumed else { return }
                hasResumed = true

                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: relationships ?? [])
            }
            HealthStoreProvider.shared.execute(query)
        }

        return relationships.map {
            Workout.EffortRelationship(
                workoutStartDate: $0.workout.startDate,
                workoutEndDate: $0.workout.endDate,
                activityStartDate: $0.activity?.startDate,
                activityEndDate: $0.activity?.endDate,
                relatedSampleCount: $0.samples?.count ?? 0
            )
        }
    }
}

// MARK: - Private Helpers
private extension WorkoutReadService {

    func findWorkout(startDate: Date, endDate: Date) async throws -> HKWorkout {
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let samples = try await fetchWorkoutSamples(
            workoutIdentifier: .workoutType(),
            predicate: predicate,
            sortDescriptors: [SortDescriptor(\.startDate, order: .reverse)],
            limit: 1
        )
        guard let workout = samples.first else {
            throw AsyncParsingError.unableToParse("Workout not found for given date range")
        }
        return workout
    }

    func fetchRouteLocations(for workout: HKWorkout) async throws -> [CLLocation] {
        let routeType = HKSeriesType.workoutRoute()
        let routeDescriptor = HKSampleQueryDescriptor(
            predicates: [.sample(type: routeType, predicate: HKQuery.predicateForObjects(from: workout))],
            sortDescriptors: [SortDescriptor(\.startDate, order: .forward)]
        )
        let routes = try await routeDescriptor.result(for: HealthStoreProvider.shared)
        
        guard let workoutRoute = routes.first as? HKWorkoutRoute else {
            return []
        }

        return try await withCheckedThrowingContinuation { continuation in
            var allLocations: [CLLocation] = []
            let query = HKWorkoutRouteQuery(route: workoutRoute) { _, locations, done, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                if let locations {
                    allLocations.append(contentsOf: locations)
                }
                if done {
                    continuation.resume(returning: allLocations)
                }
            }
            HealthStoreProvider.shared.execute(query)
        }
    }
}
