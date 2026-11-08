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
        let workoutItems = samples.map(workoutItem(from:))
        
        return Workout(items: workoutItems)
    }

    public func workoutRoute(for startDate: Date, endDate: Date) async throws -> Workout.Route {
        let workout = try await findWorkout(startDate: startDate, endDate: endDate)
        let locations = try await fetchRouteLocations(for: workout)
        let routeLocations = locations.map(routeLocation(from:))
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
        return (workout.workoutEvents ?? []).map(workoutEvent(from:))
    }

    public func workoutDetail(for startDate: Date, endDate: Date) async throws -> Workout.Detail {
        let workout = try await findWorkout(startDate: startDate, endDate: endDate)

        let item = workoutItem(from: workout)
        let events = (workout.workoutEvents ?? []).map(workoutEvent(from:))

        let route: Workout.Route?
        let locations = try? await fetchRouteLocations(for: workout)
        if let locations, !locations.isEmpty {
            route = Workout.Route(locations: locations.map(routeLocation(from:)))
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
                metadata: $0.metadata.sendableMetadata
            )
        }
    }

    public func workoutEffortRelationships(for startDate: Date, endDate: Date) async throws -> [Workout.EffortRelationship] {
        let workout = try await findWorkout(startDate: startDate, endDate: endDate)
        let descriptor = HKWorkoutEffortRelationshipQueryDescriptor(
            predicate: HKQuery.predicateForObjects(from: workout),
            anchor: nil,
            option: .mostRelevant
        )
        let relationships = try await descriptor.result(for: HealthStoreProvider.shared).relationships

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

        var locations: [CLLocation] = []
        for try await location in HKWorkoutRouteQueryDescriptor(workoutRoute).results(for: HealthStoreProvider.shared) {
            locations.append(location)
        }
        return locations
    }

    func workoutItem(from workout: HKWorkout) -> Workout.Item {
        let energy = workout.statistics(for: HKQuantityType(.activeEnergyBurned))?.sumQuantity()
        let strokes = workout.statistics(for: HKQuantityType(.swimmingStrokeCount))?.sumQuantity()
        return Workout.Item(
            duration: workout.duration,
            energyBurned: energy?.doubleValue(for: Unit.workoutEnergy),
            distance: workout.totalDistance?.doubleValue(for: Unit.workoutDistance),
            startDate: workout.startDate,
            endDate: workout.endDate,
            activityType: workout.workoutActivityType,
            source: workout.sourceRevision.source.name,
            elevationAscended: workout.metadata?[HKMetadataKeyElevationAscended] as? Double,
            elevationDescended: workout.metadata?[HKMetadataKeyElevationDescended] as? Double,
            swimmingStrokeCount: strokes?.doubleValue(for: Unit.strokeCount),
            metadata: workout.metadata.sendableMetadata
        )
    }

    func workoutEvent(from event: HKWorkoutEvent) -> Workout.Event {
        Workout.Event(
            type: event.type,
            startDate: event.dateInterval.start,
            endDate: event.dateInterval.end,
            metadata: event.metadata.sendableMetadata
        )
    }

    func routeLocation(from location: CLLocation) -> Workout.Route.Location {
        Workout.Route.Location(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            altitude: location.altitude,
            timestamp: location.timestamp,
            speed: location.speed >= 0 ? location.speed : nil,
            horizontalAccuracy: location.horizontalAccuracy >= 0 ? location.horizontalAccuracy : nil
        )
    }
}
