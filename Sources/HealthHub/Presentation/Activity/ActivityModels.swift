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
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WalkingRunningDistance: Sendable {

    public struct Item: Sendable {
        public let distance: Double // meters
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct SwimmingDistance: Sendable {

    public struct Item: Sendable {
        public let distance: Double // meters
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WheelchairDistance: Sendable {

    public struct Item: Sendable {
        public let distance: Double // meters
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct DownhillSnowSportsDistance: Sendable {

    public struct Item: Sendable {
        public let distance: Double // meters
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct CrossCountrySkiingDistance: Sendable {

    public struct Item: Sendable {
        public let distance: Double // meters
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
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
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct CyclingSpeed: Sendable {

    public struct Item: Sendable {
        public let speed: Double // m/s
        public let date: Date

        public init(speed: Double, date: Date) {
            self.speed = speed
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct RunningSpeed: Sendable {

    public struct Item: Sendable {
        public let speed: Double // m/s
        public let date: Date

        public init(speed: Double, date: Date) {
            self.speed = speed
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
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
}

public struct StandTime: Sendable {

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
}

public struct PhysicalEffort: Sendable {

    public struct Item: Sendable {
        public let effort: Double // Apple Effort Score (0–10 scale)
        public let date: Date

        public init(effort: Double, date: Date) {
            self.effort = effort
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}
