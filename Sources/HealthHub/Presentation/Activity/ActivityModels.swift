//
//  ActivityModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/6/2026.
//

import Foundation

// MARK: - Distance Types

public struct CyclingDistance: Sendable {

    public struct Item: Sendable {
        public let distance: Double // meters
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }

        /// Distance in kilometers
        public var kilometers: Double { distance / 1000 }
        /// Distance in miles
        public var miles: Double { distance / 1609.344 }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var totalDistance: Double { items.reduce(0.0) { $0 + $1.distance } }
    public var totalKilometers: Double { totalDistance / 1000 }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct WalkingRunningDistance: Sendable {

    public struct Item: Sendable {
        public let distance: Double // meters
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }

        public var kilometers: Double { distance / 1000 }
        public var miles: Double { distance / 1609.344 }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var totalDistance: Double { items.reduce(0.0) { $0 + $1.distance } }
    public var totalKilometers: Double { totalDistance / 1000 }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct SwimmingDistance: Sendable {

    public struct Item: Sendable {
        public let distance: Double // meters
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }

        /// Distance in yards (common pool unit)
        public var yards: Double { distance * 1.09361 }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var totalDistance: Double { items.reduce(0.0) { $0 + $1.distance } }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct WheelchairDistance: Sendable {

    public struct Item: Sendable {
        public let distance: Double // meters
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }

        public var kilometers: Double { distance / 1000 }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var totalDistance: Double { items.reduce(0.0) { $0 + $1.distance } }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct DownhillSnowSportsDistance: Sendable {

    public struct Item: Sendable {
        public let distance: Double // meters
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }

        public var kilometers: Double { distance / 1000 }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var totalDistance: Double { items.reduce(0.0) { $0 + $1.distance } }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct CrossCountrySkiingDistance: Sendable {

    public struct Item: Sendable {
        public let distance: Double // meters
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }

        public var kilometers: Double { distance / 1000 }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var totalDistance: Double { items.reduce(0.0) { $0 + $1.distance } }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

// MARK: - Speed Types

public struct CrossCountrySkiingSpeed: Sendable {

    public struct Item: Sendable {
        public let speed: Double // m/s
        public let date: Date

        public init(speed: Double, date: Date) {
            self.speed = speed
            self.date = date
        }

        /// Speed in km/h
        public var kmPerHour: Double { speed * 3.6 }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var average: Double {
        items.isEmpty ? 0 : items.reduce(0.0) { $0 + $1.speed } / Double(items.count)
    }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct CyclingSpeed: Sendable {

    public struct Item: Sendable {
        public let speed: Double // m/s
        public let date: Date

        public init(speed: Double, date: Date) {
            self.speed = speed
            self.date = date
        }

        /// Speed in km/h
        public var kmPerHour: Double { speed * 3.6 }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var average: Double {
        items.isEmpty ? 0 : items.reduce(0.0) { $0 + $1.speed } / Double(items.count)
    }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct RunningSpeed: Sendable {

    public struct Item: Sendable {
        public let speed: Double // m/s
        public let date: Date

        public init(speed: Double, date: Date) {
            self.speed = speed
            self.date = date
        }

        /// Speed in km/h
        public var kmPerHour: Double { speed * 3.6 }
        /// Pace in min/km
        public var paceMinPerKm: Double { speed > 0 ? (1000 / speed) / 60 : 0 }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var average: Double {
        items.isEmpty ? 0 : items.reduce(0.0) { $0 + $1.speed } / Double(items.count)
    }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

// MARK: - Cycling Specific

public struct CyclingCadence: Sendable {

    public struct Item: Sendable {
        public let rpm: Double // revolutions per minute
        public let date: Date

        public init(rpm: Double, date: Date) {
            self.rpm = rpm
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var average: Double {
        items.isEmpty ? 0 : items.reduce(0.0) { $0 + $1.rpm } / Double(items.count)
    }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct CyclingFunctionalThresholdPower: Sendable {

    public struct Item: Sendable {
        public let power: Double // watts
        public let date: Date

        public init(power: Double, date: Date) {
            self.power = power
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct CyclingPower: Sendable {

    public struct Item: Sendable {
        public let power: Double // watts
        public let date: Date

        public init(power: Double, date: Date) {
            self.power = power
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var average: Double {
        items.isEmpty ? 0 : items.reduce(0.0) { $0 + $1.power } / Double(items.count)
    }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

// MARK: - Exercise & Energy

public struct ExerciseMinutes: Sendable {

    public struct Item: Sendable {
        public let duration: Double // minutes
        public let date: Date

        public init(duration: Double, date: Date) {
            self.duration = duration
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Total exercise minutes
    public var total: Double { items.reduce(0.0) { $0 + $1.duration } }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct RestingEnergy: Sendable {

    public struct Item: Sendable {
        public let calories: Double // kcal
        public let date: Date

        public init(calories: Double, date: Date) {
            self.calories = calories
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Total resting energy in kcal
    public var total: Double { items.reduce(0.0) { $0 + $1.calories } }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct StandTime: Sendable {

    public struct Item: Sendable {
        public let duration: Double // minutes
        public let date: Date

        public init(duration: Double, date: Date) {
            self.duration = duration
            self.date = date
        }

        /// Duration in hours
        public var hours: Double { duration / 60 }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Total stand time in minutes
    public var total: Double { items.reduce(0.0) { $0 + $1.duration } }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct MoveTime: Sendable {

    public struct Item: Sendable {
        public let duration: Double // minutes
        public let date: Date

        public init(duration: Double, date: Date) {
            self.duration = duration
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Total move time in minutes
    public var total: Double { items.reduce(0.0) { $0 + $1.duration } }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

// MARK: - Running Specific

public struct RunningPower: Sendable {

    public struct Item: Sendable {
        public let power: Double // watts
        public let date: Date

        public init(power: Double, date: Date) {
            self.power = power
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var average: Double {
        items.isEmpty ? 0 : items.reduce(0.0) { $0 + $1.power } / Double(items.count)
    }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct RunningVerticalOscillation: Sendable {

    public struct Item: Sendable {
        public let oscillation: Double // centimeters
        public let date: Date

        public init(oscillation: Double, date: Date) {
            self.oscillation = oscillation
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var average: Double {
        items.isEmpty ? 0 : items.reduce(0.0) { $0 + $1.oscillation } / Double(items.count)
    }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct RunningGroundContactTime: Sendable {

    public struct Item: Sendable {
        public let duration: Double // milliseconds
        public let date: Date

        public init(duration: Double, date: Date) {
            self.duration = duration
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var average: Double {
        items.isEmpty ? 0 : items.reduce(0.0) { $0 + $1.duration } / Double(items.count)
    }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

// MARK: - Swimming Specific

public struct SwimmingStrokeCount: Sendable {

    public struct Item: Sendable {
        public let count: Double
        public let date: Date

        public init(count: Double, date: Date) {
            self.count = count
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var total: Double { items.reduce(0.0) { $0 + $1.count } }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

// MARK: - Miscellaneous Activity

public struct FlightsClimbed: Sendable {

    public struct Item: Sendable {
        public let count: Double
        public let date: Date

        public init(count: Double, date: Date) {
            self.count = count
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var total: Double { items.reduce(0.0) { $0 + $1.count } }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct PushCount: Sendable {

    public struct Item: Sendable {
        public let count: Double
        public let date: Date

        public init(count: Double, date: Date) {
            self.count = count
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var total: Double { items.reduce(0.0) { $0 + $1.count } }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct NikeFuel: Sendable {

    public struct Item: Sendable {
        public let count: Double
        public let date: Date

        public init(count: Double, date: Date) {
            self.count = count
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var total: Double { items.reduce(0.0) { $0 + $1.count } }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

public struct PhysicalEffort: Sendable {

    public struct Item: Sendable {
        public let effort: Double // Apple Effort Score (0–10 scale)
        public let date: Date

        public init(effort: Double, date: Date) {
            self.effort = effort
            self.date = date
        }

        /// Effort intensity level
        public var intensity: Intensity {
            switch effort {
            case ..<3: .low
            case 3..<6: .moderate
            case 6..<8: .high
            default: .veryHigh
            }
        }

        public enum Intensity: String, Sendable {
            case low, moderate, high, veryHigh
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var average: Double {
        items.isEmpty ? 0 : items.reduce(0.0) { $0 + $1.effort } / Double(items.count)
    }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}

// MARK: - Underwater

public struct UnderwaterDepth: Sendable {

    public struct Item: Sendable {
        public let depth: Double // meters
        public let date: Date

        public init(depth: Double, date: Date) {
            self.depth = depth
            self.date = date
        }

        /// Depth in feet
        public var feet: Double { depth * 3.28084 }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var maxDepth: Double? { items.map(\.depth).max() }
    public var mostRecent: Item? { items.max(by: { $0.date < $1.date }) }
}
