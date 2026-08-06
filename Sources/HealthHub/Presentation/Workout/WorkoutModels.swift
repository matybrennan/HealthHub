//
//  WorkoutModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/18/18.
//

import Foundation
import HealthKit
import CoreLocation

public struct Workout: Sendable {

    public struct Item: Sendable {

        public var duration: Double // secs
        public var energyBurned: Double? // cals
        public var distance: Double? // meters
        public var startDate: Date
        public var endDate: Date
        public var activityType: HKWorkoutActivityType
        public var source: String?
        public var elevationAscended: Double? // meters
        public var elevationDescended: Double? // meters
        public var averageHeartRate: Double? // bpm
        public var swimmingStrokeCount: Double?
        public var metadata: [String: Sendable]?

        public init(
            duration: Double,
            energyBurned: Double? = nil,
            distance: Double? = nil,
            startDate: Date,
            endDate: Date,
            activityType: HKWorkoutActivityType = .other,
            source: String? = nil,
            elevationAscended: Double? = nil,
            elevationDescended: Double? = nil,
            averageHeartRate: Double? = nil,
            swimmingStrokeCount: Double? = nil,
            metadata: [String: Sendable]? = nil
        ) {
            self.duration = duration
            self.energyBurned = energyBurned
            self.distance = distance
            self.startDate = startDate
            self.endDate = endDate
            self.activityType = activityType
            self.source = source
            self.elevationAscended = elevationAscended
            self.elevationDescended = elevationDescended
            self.averageHeartRate = averageHeartRate
            self.swimmingStrokeCount = swimmingStrokeCount
            self.metadata = metadata
        }

        /// Duration formatted as hours and minutes
        public var durationFormatted: String {
            let hours = Int(duration) / 3600
            let minutes = (Int(duration) % 3600) / 60
            if hours > 0 {
                return "\(hours)h \(minutes)m"
            }
            return "\(minutes)m"
        }

        /// Distance in kilometers
        public var distanceKilometers: Double? {
            distance.map { $0 / 1000 }
        }

        /// Distance in miles
        public var distanceMiles: Double? {
            distance.map { $0 / 1609.344 }
        }

        /// Average pace in min/km (for running/walking)
        public var paceMinPerKm: Double? {
            guard let distance, distance > 0 else { return nil }
            return (duration / 60) / (distance / 1000)
        }

        /// Calories per minute
        public var caloriesPerMinute: Double? {
            guard duration > 0 else { return nil }
            return energyBurned.map { $0 / (duration / 60) }
        }
    }

    public struct Event: Sendable {
        public let type: HKWorkoutEventType
        public let startDate: Date
        public let endDate: Date?
        public let metadata: [String: Sendable]?

        public init(type: HKWorkoutEventType, startDate: Date, endDate: Date? = nil, metadata: [String: Sendable]? = nil) {
            self.type = type
            self.startDate = startDate
            self.endDate = endDate
            self.metadata = metadata
        }
    }

    public struct Route: Sendable {
        public let locations: [Location]

        public init(locations: [Location]) {
            self.locations = locations
        }

        /// Total distance of the route in meters
        public var totalDistance: Double {
            guard locations.count > 1 else { return 0 }
            var total = 0.0
            for i in 1..<locations.count {
                let prev = locations[i - 1]
                let curr = locations[i]
                let latDiff = curr.latitude - prev.latitude
                let lonDiff = curr.longitude - prev.longitude
                // Approximate distance using Haversine
                let a = sin(latDiff * .pi / 180 / 2) * sin(latDiff * .pi / 180 / 2) +
                    cos(prev.latitude * .pi / 180) * cos(curr.latitude * .pi / 180) *
                    sin(lonDiff * .pi / 180 / 2) * sin(lonDiff * .pi / 180 / 2)
                let c = 2 * atan2(sqrt(a), sqrt(1 - a))
                total += 6371000 * c // Earth radius in meters
            }
            return total
        }

        /// Elevation gain across the route
        public var elevationGain: Double {
            guard locations.count > 1 else { return 0 }
            var gain = 0.0
            for i in 1..<locations.count {
                let diff = locations[i].altitude - locations[i - 1].altitude
                if diff > 0 { gain += diff }
            }
            return gain
        }

        public struct Location: Sendable {
            public let latitude: Double
            public let longitude: Double
            public let altitude: Double
            public let timestamp: Date
            public let speed: Double? // m/s
            public let horizontalAccuracy: Double?

            public init(latitude: Double, longitude: Double, altitude: Double, timestamp: Date, speed: Double? = nil, horizontalAccuracy: Double? = nil) {
                self.latitude = latitude
                self.longitude = longitude
                self.altitude = altitude
                self.timestamp = timestamp
                self.speed = speed
                self.horizontalAccuracy = horizontalAccuracy
            }
        }
    }

    public struct HeartRateSample: Sendable {
        public let bpm: Double
        public let timestamp: Date

        public init(bpm: Double, timestamp: Date) {
            self.bpm = bpm
            self.timestamp = timestamp
        }
    }

    public struct Detail: Sendable {
        public let item: Item
        public let events: [Event]
        public let route: Route?
        public let heartRateSamples: [HeartRateSample]

        public init(item: Item, events: [Event] = [], route: Route? = nil, heartRateSamples: [HeartRateSample] = []) {
            self.item = item
            self.events = events
            self.route = route
            self.heartRateSamples = heartRateSamples
        }

        /// Average heart rate from samples
        public var averageHeartRate: Double? {
            guard !heartRateSamples.isEmpty else { return nil }
            return heartRateSamples.reduce(0.0) { $0 + $1.bpm } / Double(heartRateSamples.count)
        }

        /// Max heart rate from samples
        public var maxHeartRate: Double? {
            heartRateSamples.map(\.bpm).max()
        }

        /// Min heart rate from samples
        public var minHeartRate: Double? {
            heartRateSamples.map(\.bpm).min()
        }

        /// Number of laps (from lap events)
        public var lapCount: Int {
            events.filter { $0.type == .lap }.count
        }
    }

    /// A single sub-activity segment within a multi-sport (composite) workout, e.g. one leg of a triathlon.
    public struct Activity: Sendable {
        public let activityType: HKWorkoutActivityType
        public let startDate: Date
        public let endDate: Date?
        public let duration: Double // secs
        public let metadata: [String: Sendable]?

        public init(activityType: HKWorkoutActivityType, startDate: Date, endDate: Date? = nil, duration: Double, metadata: [String: Sendable]? = nil) {
            self.activityType = activityType
            self.startDate = startDate
            self.endDate = endDate
            self.duration = duration
            self.metadata = metadata
        }
    }

    /// Describes how a workout (and optionally one of its sub-activities) relates to other samples,
    /// such as a workout effort score. See `HKWorkoutEffortRelationshipQuery` (iOS 18+).
    public struct EffortRelationship: Sendable {
        public let workoutStartDate: Date
        public let workoutEndDate: Date
        public let activityStartDate: Date?
        public let activityEndDate: Date?
        public let relatedSampleCount: Int

        public init(workoutStartDate: Date, workoutEndDate: Date, activityStartDate: Date? = nil, activityEndDate: Date? = nil, relatedSampleCount: Int) {
            self.workoutStartDate = workoutStartDate
            self.workoutEndDate = workoutEndDate
            self.activityStartDate = activityStartDate
            self.activityEndDate = activityEndDate
            self.relatedSampleCount = relatedSampleCount
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

extension Workout {

    /// Most recent workout
    public var mostRecent: Item? {
        items.max(by: { $0.endDate < $1.endDate })
    }

    /// Total energy burned across all workouts
    public var totalEnergyBurned: Double {
        items.compactMap(\.energyBurned).reduce(0, +)
    }

    /// Total duration across all workouts (seconds)
    public var totalDuration: Double {
        items.reduce(0.0) { $0 + $1.duration }
    }

    /// Total distance across all workouts (meters)
    public var totalDistance: Double {
        items.compactMap(\.distance).reduce(0, +)
    }

    /// Number of workouts
    public var count: Int {
        items.count
    }
}
