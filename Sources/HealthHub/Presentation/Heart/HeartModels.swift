//
//  HeartModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/12/18.
//

import Foundation

public struct HeartRate: Sendable {

    public struct Item: Sendable {
        public let max: Double
        public let min: Double
        public let average: Double
        public let startDate: Date
        public let endDate: Date

        nonisolated public init(max: Double, min: Double, average: Double, startDate: Date = .now, endDate: Date = .now) {
            self.max = max
            self.min = min
            self.average = average
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Range between min and max BPM
        public var range: ClosedRange<Double> {
            min...max
        }
    }

    public let items: [Item]

    nonisolated public init(items: [Item]) {
        self.items = items
    }
}

extension HeartRate {

    public var total: Double {
        items.reduce(0.0) { $0 + $1.average }
    }

    public var average: Double {
        items.isEmpty ? 0.0 : total / Double(count)
    }

    public var overallMax: Double? {
        items.map(\.max).max()
    }

    public var overallMin: Double? {
        items.map(\.min).min()
    }

    public var first: Item? {
        items.first
    }

    public var last: Item? {
        items.last
    }

    public var count: Int {
        items.count
    }

    public var mostRecent: Item? {
        items.max(by: { $0.endDate < $1.endDate })
    }
}

public struct CardioRecovery: Sendable {

    public struct Item: Sendable {
        public let bpm: Int
        public let date: Date

        public init(bpm: Int, date: Date) {
            self.bpm = bpm
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.date < $1.date })
    }

    public var average: Double {
        guard !items.isEmpty else { return 0 }
        return Double(items.reduce(0) { $0 + $1.bpm }) / Double(items.count)
    }
}

public struct AtrialFibrillationHistory: Sendable {

    public struct Item: Sendable {
        public let percentage: Double
        public let startDate: Date
        public let endDate: Date

        public init(percentage: Double, startDate: Date, endDate: Date) {
            self.percentage = percentage
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Duration of the AFib episode
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

    /// Average AFib burden percentage
    public var averageBurden: Double {
        guard !items.isEmpty else { return 0 }
        return items.reduce(0.0) { $0 + $1.percentage } / Double(items.count)
    }
}

public struct PeripheralPerfusionIndex: Sendable {

    public struct Item: Sendable {
        public let percentage: Double
        public let date: Date

        public init(percentage: Double, date: Date) {
            self.percentage = percentage
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.date < $1.date })
    }
}

public struct HeartRateVariability: Sendable {

    public struct Item: Sendable {
        public let sdnn: Double // milliseconds
        public let date: Date

        public init(sdnn: Double, date: Date) {
            self.sdnn = sdnn
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.date < $1.date })
    }

    /// Average SDNN across all readings
    public var averageSDNN: Double {
        guard !items.isEmpty else { return 0 }
        return items.reduce(0.0) { $0 + $1.sdnn } / Double(items.count)
    }
}

public struct HighHeartRateEvent: Sendable {

    public struct Item: Sendable {
        public let startDate: Date
        public let endDate: Date

        public init(startDate: Date, endDate: Date) {
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

public struct IrregularHeartRhythmEvent: Sendable {

    public struct Item: Sendable {
        public let startDate: Date
        public let endDate: Date

        public init(startDate: Date, endDate: Date) {
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

public struct LowHeartRateEvent: Sendable {

    public struct Item: Sendable {
        public let startDate: Date
        public let endDate: Date

        public init(startDate: Date, endDate: Date) {
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

public struct RestingHeartRate: Sendable {

    public struct Item: Sendable {
        public let bpm: Double
        public let date: Date

        public init(bpm: Double, date: Date) {
            self.bpm = bpm
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.date < $1.date })
    }

    /// Average resting heart rate across all readings
    public var average: Double {
        guard !items.isEmpty else { return 0 }
        return items.reduce(0.0) { $0 + $1.bpm } / Double(items.count)
    }
}

public struct WalkingHeartRateAverage: Sendable {

    public struct Item: Sendable {
        public let bpm: Double
        public let date: Date

        public init(bpm: Double, date: Date) {
            self.bpm = bpm
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.date < $1.date })
    }

    /// Average walking heart rate across all readings
    public var average: Double {
        guard !items.isEmpty else { return 0 }
        return items.reduce(0.0) { $0 + $1.bpm } / Double(items.count)
    }
}

public struct LowCardioFitnessEvent: Sendable {

    public struct Item: Sendable {
        public let startDate: Date
        public let endDate: Date

        public init(startDate: Date, endDate: Date) {
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

/// Hypertension notification event. Requires iOS 26.2+.
public struct HypertensionEvent: Sendable {

    public struct Item: Sendable {
        public let startDate: Date
        public let endDate: Date

        public init(startDate: Date, endDate: Date) {
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
