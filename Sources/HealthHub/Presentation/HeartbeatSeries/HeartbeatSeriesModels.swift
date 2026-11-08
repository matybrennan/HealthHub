//
//  HeartbeatSeriesModels.swift
//  HealthHub
//
//  Created by Copilot on 7/8/2026.
//

import Foundation

public struct HeartbeatSeries: Sendable {

    public struct Heartbeat: Sendable {
        public let timeSinceSeriesStart: TimeInterval
        public let precededByGap: Bool

        public init(timeSinceSeriesStart: TimeInterval, precededByGap: Bool) {
            self.timeSinceSeriesStart = timeSinceSeriesStart
            self.precededByGap = precededByGap
        }
    }

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

    public struct Record: Sendable {
        public let startDate: Date
        public let heartbeats: [Heartbeat]

        public init(startDate: Date, heartbeats: [Heartbeat]) {
            self.startDate = startDate
            self.heartbeats = heartbeats
        }

        public var endDate: Date {
            guard let latestHeartbeat = heartbeats.map(\.timeSinceSeriesStart).max() else { return startDate }
            return startDate.addingTimeInterval(latestHeartbeat)
        }

        public var totalHeartbeats: Int {
            heartbeats.count
        }

        public var containsGaps: Bool {
            heartbeats.contains(where: \.precededByGap)
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.endDate < $1.endDate })
    }

    public var totalDuration: TimeInterval {
        items.reduce(0) { $0 + $1.duration }
    }
}
