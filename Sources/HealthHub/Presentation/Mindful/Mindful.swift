//
//  Mindful.swift
//  HealthHub
//
//  Created by matybrennan on 24/9/19.
//

import Foundation

public struct Mindful: Sendable {

    public struct Info: Sendable {
        public let value: Int
        public let startDate: Date
        public let endDate: Date
        
        /// Duration of the mindful session in minutes
        public var minutes: Int {
            Calendar.current.dateComponents([.minute], from: startDate, to: endDate).minute ?? 0
        }

        /// Duration of the mindful session in seconds
        public var duration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }
        
        public init(value: Int, startDate: Date, endDate: Date) {
            self.value = value
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]

    public init(items: [Info]) {
        self.items = items
    }

    /// Most recent mindful session
    public var mostRecent: Info? { items.first }

    /// Total mindful minutes across all sessions
    public var totalMinutes: Int {
        items.reduce(0) { $0 + $1.minutes }
    }

    /// Average session duration in minutes
    public var averageMinutes: Double? {
        guard !items.isEmpty else { return nil }
        return Double(totalMinutes) / Double(items.count)
    }
}

extension Mindful.Info {
    
    public init(startDate: Date) {
        value = 0
        self.startDate = startDate
        self.endDate = Date()
    }
}

