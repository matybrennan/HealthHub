//
//  OtherDataModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation

public struct AlcoholConsumption: Sendable {

    public struct Item: Sendable {
        public let drinks: Double
        public let startDate: Date
        public let endDate: Date

        public init(drinks: Double, startDate: Date, endDate: Date) {
            self.drinks = drinks
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

    /// Total drinks across all entries
    public var totalDrinks: Double {
        items.reduce(0) { $0 + $1.drinks }
    }
}

public struct AlcoholContent: Sendable {

    public struct Item: Sendable {
        public let percentage: Double
        public let startDate: Date
        public let endDate: Date

        public init(percentage: Double, startDate: Date, endDate: Date) {
            self.percentage = percentage
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Legal limit classification (US: 0.08%)
        public var isAboveLegalLimit: Bool {
            percentage >= 0.08
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }
}

public struct HandWashing: Sendable {

    public struct Item: Sendable {
        public let startDate: Date
        public let endDate: Date

        public init(startDate: Date, endDate: Date) {
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Duration of handwashing in seconds
        public var duration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }

        /// WHO recommends at least 20 seconds
        public var meetsRecommendedDuration: Bool {
            duration >= 20
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average handwashing duration in seconds
    public var averageDuration: TimeInterval? {
        guard !items.isEmpty else { return nil }
        let total = items.reduce(0.0) { $0 + $1.duration }
        return total / Double(items.count)
    }
}

public struct InhalerUsage: Sendable {

    public struct Item: Sendable {
        public let value: Int
        public let startDate: Date
        public let endDate: Date

        public init(value: Int, startDate: Date, endDate: Date) {
            self.value = value
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent usage
    public var mostRecent: Item? { items.first }

    /// Total inhaler uses across all entries
    public var totalUses: Int {
        items.reduce(0) { $0 + $1.value }
    }
}

public struct InsulinDelivery: Sendable {

    public struct Item: Sendable {

        public enum Purpose: Int, Sendable {
            case basal = 1
            case bolus

            public var displayName: String {
                switch self {
                case .basal: "Basal"
                case .bolus: "Bolus"
                }
            }
        }
        
        public let value: Double
        public let purpose: Purpose
        public let startDate: Date
        public let endDate: Date

        public init(value: Double, purpose: Purpose, startDate: Date, endDate: Date) {
            self.value = value
            self.purpose = purpose
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent delivery
    public var mostRecent: Item? { items.first }

    /// Total insulin delivered (IU)
    public var totalDelivered: Double {
        items.reduce(0) { $0 + $1.value }
    }

    /// Total basal insulin delivered (IU)
    public var totalBasal: Double {
        items.filter { $0.purpose == .basal }.reduce(0) { $0 + $1.value }
    }

    /// Total bolus insulin delivered (IU)
    public var totalBolus: Double {
        items.filter { $0.purpose == .bolus }.reduce(0) { $0 + $1.value }
    }
}

public struct NumberOfTimesFallen: Sendable {

    public struct Item: Sendable {
        public let value: Int
        public let startDate: Date
        public let endDate: Date

        public init(value: Int, startDate: Date, endDate: Date) {
            self.value = value
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

    /// Total number of falls
    public var totalFalls: Int {
        items.reduce(0) { $0 + $1.value }
    }
}

public struct ToothBrushing: Sendable {

    public struct Item: Sendable {
        public let startDate: Date
        public let endDate: Date

        public init(startDate: Date, endDate: Date) {
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Duration of brushing in seconds
        public var duration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }

        /// ADA recommends at least 2 minutes (120 seconds)
        public var meetsRecommendedDuration: Bool {
            duration >= 120
        }
    }
    
    public let items: [Item]
    
    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average brushing duration in seconds
    public var averageDuration: TimeInterval? {
        guard !items.isEmpty else { return nil }
        let total = items.reduce(0.0) { $0 + $1.duration }
        return total / Double(items.count)
    }
}

public struct UVExposure: Sendable {

    public struct Item: Sendable {
        public let value: Int
        public let startDate: Date
        public let endDate: Date

        public init(value: Int, startDate: Date, endDate: Date) {
            self.value = value
            self.startDate = startDate
            self.endDate = endDate
        }

        /// UV Index classification per WHO/EPA guidelines
        public enum Classification: String, Sendable {
            case low
            case moderate
            case high
            case veryHigh
            case extreme
        }

        public var classification: Classification {
            switch value {
            case 0...2: .low
            case 3...5: .moderate
            case 6...7: .high
            case 8...10: .veryHigh
            default: .extreme
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

public struct TimeInDaylight: Sendable {

    public struct Item: Sendable {
        public let duration: TimeInterval
        public let startDate: Date
        public let endDate: Date

        public init(duration: TimeInterval, startDate: Date, endDate: Date) {
            self.duration = duration
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Duration in minutes
        public var durationMinutes: Double {
            duration / 60.0
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Total time in daylight in minutes
    public var totalMinutes: Double {
        items.reduce(0) { $0 + $1.durationMinutes }
    }
}

public struct WaterTemperature: Sendable {

    public struct Item: Sendable {
        public let celsius: Double
        public let fahrenheit: Double
        public let startDate: Date
        public let endDate: Date
        
        public init(celsius: Double, fahrenheit: Double, startDate: Date, endDate: Date) {
            self.celsius = celsius
            self.fahrenheit = fahrenheit
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
}

public struct EnvironmentalAudioExposure: Sendable {

    public struct Item: Sendable {
        /// Sound level in dB A-weighted Sound Pressure Level
        public let value: Double
        public let startDate: Date
        public let endDate: Date

        public init(value: Double, startDate: Date, endDate: Date) {
            self.value = value
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Duration of the measurement period
        public var duration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }

        /// WHO recommends max 70 dB for prolonged exposure
        public var exceedsRecommendedLevel: Bool {
            value > 70
        }

        /// NIOSH damage threshold (85 dB for 8 hours)
        public var exceedsDamageThreshold: Bool {
            value > 85
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average sound level
    public var averageLevel: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.value } / Double(items.count)
    }
}

public struct HeadphoneAudioExposure: Sendable {

    public struct Item: Sendable {
        /// Sound level in dB A-weighted Sound Pressure Level
        public let value: Double
        public let startDate: Date
        public let endDate: Date

        public init(value: Double, startDate: Date, endDate: Date) {
            self.value = value
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Duration of listening
        public var duration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }

        /// WHO recommends max 85 dB for headphone listening
        public var exceedsRecommendedLevel: Bool {
            value > 85
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average sound level
    public var averageLevel: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.value } / Double(items.count)
    }
}
