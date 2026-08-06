//
//  Mobility.swift
//  HealthHub
//
//  Created by Maty Brennan on 24/2/2024.
//

import Foundation

public struct CardioFitness: Sendable {

    public struct Item: Sendable {
        public let vo2Max: Double
        public let startDate: Date
        public let endDate: Date

        public init(vo2Max: Double, startDate: Date, endDate: Date) {
            self.vo2Max = vo2Max
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Cardio fitness classification based on general population norms
        public enum Classification: String, Sendable {
            case poor
            case belowAverage
            case average
            case aboveAverage
            case excellent
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }
}

public struct DoubleSupportTime: Sendable {

    public struct Item: Sendable {
        /// Percentage of gait cycle spent in double support (both feet on ground)
        public let percentage: Double
        public let startDate: Date
        public let endDate: Date

        public init(percentage: Double, startDate: Date, endDate: Date) {
            self.percentage = percentage
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average double support time percentage
    public var averagePercentage: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.percentage } / Double(items.count)
    }
}

public struct GroundContactTime: Sendable {

    public struct Item: Sendable {
        /// Duration in milliseconds
        public let duration: Double
        public let startDate: Date
        public let endDate: Date

        public init(duration: Double, startDate: Date, endDate: Date) {
            self.duration = duration
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average ground contact time in ms
    public var averageDuration: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.duration } / Double(items.count)
    }
}

public struct RunningStrideLength: Sendable {

    public struct Item: Sendable {
        /// Distance in meters
        public let distance: Double
        public let startDate: Date
        public let endDate: Date

        public init(distance: Double, startDate: Date, endDate: Date) {
            self.distance = distance
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average stride length in meters
    public var averageDistance: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.distance } / Double(items.count)
    }
}

public struct StairSpeedDown: Sendable {

    public struct Item: Sendable {
        /// Descent velocity in m/s
        public let velocity: Double
        public let startDate: Date
        public let endDate: Date

        public init(velocity: Double, startDate: Date, endDate: Date) {
            self.velocity = velocity
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average descent speed in m/s
    public var averageVelocity: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.velocity } / Double(items.count)
    }
}

public struct StairSpeedUp: Sendable {

    public struct Item: Sendable {
        /// Ascent velocity in m/s
        public let velocity: Double
        public let startDate: Date
        public let endDate: Date

        public init(velocity: Double, startDate: Date, endDate: Date) {
            self.velocity = velocity
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average ascent speed in m/s
    public var averageVelocity: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.velocity } / Double(items.count)
    }
}

public struct VerticalOscillation: Sendable {

    public struct Item: Sendable {
        /// Vertical oscillation in centimeters
        public let distance: Double
        public let startDate: Date
        public let endDate: Date

        public init(distance: Double, startDate: Date, endDate: Date) {
            self.distance = distance
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average vertical oscillation in cm
    public var averageDistance: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.distance } / Double(items.count)
    }
}

public struct WalkingAsymmetry: Sendable {

    public struct Item: Sendable {
        /// Asymmetry percentage (0% = perfectly symmetric)
        public let percentage: Double
        public let startDate: Date
        public let endDate: Date

        public init(percentage: Double, startDate: Date, endDate: Date) {
            self.percentage = percentage
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average walking asymmetry percentage
    public var averagePercentage: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.percentage } / Double(items.count)
    }
}

public struct WalkingSpeed: Sendable {

    public struct Item: Sendable {
        /// Walking speed in km/h
        public let velocity: Double
        public let startDate: Date
        public let endDate: Date

        public init(velocity: Double, startDate: Date, endDate: Date) {
            self.velocity = velocity
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average walking speed in km/h
    public var averageVelocity: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.velocity } / Double(items.count)
    }
}

public struct WalkingSteadiness: Sendable {

    public enum Classification: String, Sendable {
        case ok
        case low
        case veryLow

        public var displayName: String {
            switch self {
            case .ok: "OK"
            case .low: "Low"
            case .veryLow: "Very Low"
            }
        }
    }

    public struct Item: Sendable {
        /// Walking steadiness percentage (higher = more steady)
        public let percentage: Double
        public let startDate: Date
        public let endDate: Date

        public init(percentage: Double, startDate: Date, endDate: Date) {
            self.percentage = percentage
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Apple's walking steadiness classification
        public var classification: Classification {
            switch percentage {
            case ..<0.15: .veryLow
            case ..<0.30: .low
            default: .ok
            }
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }
}

public struct WalkingSteadinessEvent: Sendable {

    public enum Classification: Int, Sendable {
        case initialLow = 1
        case initialVeryLow = 2
        case repeatLow = 3
        case repeatVeryLow = 4

        public var displayName: String {
            switch self {
            case .initialLow: "Initial Low"
            case .initialVeryLow: "Initial Very Low"
            case .repeatLow: "Repeat Low"
            case .repeatVeryLow: "Repeat Very Low"
            }
        }

        public var isRepeatNotification: Bool {
            switch self {
            case .repeatLow, .repeatVeryLow: true
            case .initialLow, .initialVeryLow: false
            }
        }

        public var isVeryLow: Bool {
            switch self {
            case .initialVeryLow, .repeatVeryLow: true
            case .initialLow, .repeatLow: false
            }
        }
    }

    public struct Item: Sendable {
        public let classification: Classification
        public let startDate: Date
        public let endDate: Date

        public init(classification: Classification, startDate: Date, endDate: Date) {
            self.classification = classification
            self.startDate = startDate
            self.endDate = endDate
        }

        public var duration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.endDate < $1.endDate })
    }

    public var totalEvents: Int {
        items.count
    }
}

public struct WalkingStepLength: Sendable {

    public struct Item: Sendable {
        /// Step length in centimeters
        public let distance: Double
        public let startDate: Date
        public let endDate: Date

        public init(distance: Double, startDate: Date, endDate: Date) {
            self.distance = distance
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average step length in cm
    public var averageDistance: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.distance } / Double(items.count)
    }
}
