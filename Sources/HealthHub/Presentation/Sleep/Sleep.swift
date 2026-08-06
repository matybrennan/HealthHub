//
//  Sleep.swift
//  HealthHub
//
//  Created by matybrennan on 1/12/18.
//

import Foundation

public struct Sleep: Sendable {

    public struct Info: Sendable {

        /// Maps to HKCategoryValueSleepAnalysis raw values
        public enum Style: Int, Sendable {
            case inBed = 0
            case asleepUnspecified = 1
            case awake = 2
            case asleepCore = 3
            case asleepDeep = 4
            case asleepREM = 5

            public var displayName: String {
                switch self {
                case .inBed: return "In Bed"
                case .asleepUnspecified: return "Asleep"
                case .awake: return "Awake"
                case .asleepCore: return "Core Sleep"
                case .asleepDeep: return "Deep Sleep"
                case .asleepREM: return "REM Sleep"
                }
            }

            public var isAsleep: Bool {
                switch self {
                case .asleepUnspecified, .asleepCore, .asleepDeep, .asleepREM:
                    return true
                case .inBed, .awake:
                    return false
                }
            }
        }

        public let style: Style
        public let startDate: Date
        public let endDate: Date

        public var duration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }
        
        public init(style: Style, startDate: Date, endDate: Date) {
            self.style = style
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    /// Represents a grouped sleep session (one night of sleep)
    public struct Session: Sendable {
        public let items: [Info]
        public let startDate: Date
        public let endDate: Date

        public init(items: [Info], startDate: Date, endDate: Date) {
            self.items = items
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Total duration from first sample start to last sample end
        public var totalDuration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }

        /// Total time asleep across all stages
        public var totalSleepDuration: TimeInterval {
            items.filter { $0.style.isAsleep }.reduce(0) { $0 + $1.duration }
        }

        /// Total time in bed
        public var inBedDuration: TimeInterval {
            items.filter { $0.style == .inBed }.reduce(0) { $0 + $1.duration }
        }

        /// Time spent awake during the session
        public var awakeDuration: TimeInterval {
            items.filter { $0.style == .awake }.reduce(0) { $0 + $1.duration }
        }

        /// Time in core (light) sleep
        public var coreSleepDuration: TimeInterval {
            items.filter { $0.style == .asleepCore }.reduce(0) { $0 + $1.duration }
        }

        /// Time in deep sleep
        public var deepSleepDuration: TimeInterval {
            items.filter { $0.style == .asleepDeep }.reduce(0) { $0 + $1.duration }
        }

        /// Time in REM sleep
        public var remSleepDuration: TimeInterval {
            items.filter { $0.style == .asleepREM }.reduce(0) { $0 + $1.duration }
        }

        /// Sleep efficiency: percentage of in-bed time actually spent asleep (0.0–1.0)
        public var sleepEfficiency: Double {
            let inBed = inBedDuration
            guard inBed > 0 else { return 0 }
            return totalSleepDuration / inBed
        }
    }
    
    public let items: [Info]

    public init(items: [Info]) {
        self.items = items
    }

    // MARK: - Aggregate Durations

    /// Total time asleep (all sleep stages combined)
    public var totalSleepDuration: TimeInterval {
        items.filter { $0.style.isAsleep }.reduce(0) { $0 + $1.duration }
    }

    /// Total time in bed
    public var totalInBedDuration: TimeInterval {
        items.filter { $0.style == .inBed }.reduce(0) { $0 + $1.duration }
    }

    /// Total time awake during sleep periods
    public var totalAwakeDuration: TimeInterval {
        items.filter { $0.style == .awake }.reduce(0) { $0 + $1.duration }
    }

    // MARK: - Per-Stage Durations

    /// Total time in core (light) sleep
    public var coreSleepDuration: TimeInterval {
        items.filter { $0.style == .asleepCore }.reduce(0) { $0 + $1.duration }
    }

    /// Total time in deep sleep
    public var deepSleepDuration: TimeInterval {
        items.filter { $0.style == .asleepDeep }.reduce(0) { $0 + $1.duration }
    }

    /// Total time in REM sleep
    public var remSleepDuration: TimeInterval {
        items.filter { $0.style == .asleepREM }.reduce(0) { $0 + $1.duration }
    }

    // MARK: - Sleep Efficiency

    /// Sleep efficiency: percentage of in-bed time spent asleep (0.0–1.0)
    public var sleepEfficiency: Double {
        let inBed = totalInBedDuration
        guard inBed > 0 else { return 0 }
        return totalSleepDuration / inBed
    }

    // MARK: - Sleep Sessions

    /// Groups sleep samples into sessions (nights) based on time gaps.
    /// Samples separated by more than the given gap are considered separate sessions.
    /// - Parameter maxGap: Maximum gap in seconds between samples to be considered part of the same session. Defaults to 2 hours.
    public func sessions(maxGap: TimeInterval = 7200) -> [Session] {
        guard !items.isEmpty else { return [] }

        let sorted = items.sorted { $0.startDate < $1.startDate }
        var sessions: [Session] = []
        var currentGroup: [Info] = [sorted[0]]

        for i in 1..<sorted.count {
            let previous = currentGroup.last!
            let current = sorted[i]

            if current.startDate.timeIntervalSince(previous.endDate) > maxGap {
                // Start a new session
                let session = Session(
                    items: currentGroup,
                    startDate: currentGroup.first!.startDate,
                    endDate: currentGroup.last!.endDate
                )
                sessions.append(session)
                currentGroup = [current]
            } else {
                currentGroup.append(current)
            }
        }

        // Append the last session
        let session = Session(
            items: currentGroup,
            startDate: currentGroup.first!.startDate,
            endDate: currentGroup.last!.endDate
        )
        sessions.append(session)

        return sessions
    }
}

public struct SleepApneaEvent: Sendable {

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

public struct SleepingBreathingDisturbances: Sendable {

    public struct Item: Sendable {
        public let count: Double
        public let startDate: Date
        public let endDate: Date

        public init(count: Double, startDate: Date, endDate: Date) {
            self.count = count
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
        items.first
    }

    public var averageCount: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.count } / Double(items.count)
    }

    public var totalCount: Double {
        items.reduce(0) { $0 + $1.count }
    }
}
