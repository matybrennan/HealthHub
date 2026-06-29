//
//  StepsModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation

public struct Steps: Sendable {

    public struct Item: Sendable, Equatable {
        public let count: Double
        public let startDate: Date
        public let endDate: Date

        nonisolated public init(count: Double, startDate: Date = .now, endDate: Date = .now) {
            self.count = count
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    nonisolated public init(items: [Item]) {
        self.items = items
    }
}

extension Steps {

    /// Total step count across all items
    public var total: Double {
        items.reduce(0.0) { $0 + $1.count }
    }

    /// Average step count per interval
    public var average: Double {
        items.isEmpty ? 0 : total / Double(items.count)
    }

    /// Most recent step reading
    public var mostRecent: Item? {
        items.max(by: { $0.endDate < $1.endDate })
    }

    /// Highest step count in a single interval
    public var peakInterval: Item? {
        items.max(by: { $0.count < $1.count })
    }

    /// Number of intervals
    public var count: Int {
        items.count
    }
}
