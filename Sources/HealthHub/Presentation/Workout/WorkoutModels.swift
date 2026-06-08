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
    }
    
    public let items: [Item]
    
    public init(items: [Item]) {
        self.items = items
    }
}
