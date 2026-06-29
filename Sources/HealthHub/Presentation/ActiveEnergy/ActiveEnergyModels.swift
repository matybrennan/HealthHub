//
//  ActiveEnergyModels.swift
//  HealthHub
//
//  Created by matybrennan on 27/11/18.
//

import Foundation

public struct ActiveEnergy: Sendable {

    public struct Item: Sendable {
        public let calories: Double // kcal
        public let startDate: Date
        public let endDate: Date

        public init(calories: Double, startDate: Date, endDate: Date) {
            self.calories = calories
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

extension ActiveEnergy {

    /// Total calories burned across all items
    public var totalCalories: Double {
        items.reduce(0.0) { $0 + $1.calories }
    }

    /// Most recent energy reading
    public var mostRecent: Item? {
        items.max(by: { $0.endDate < $1.endDate })
    }

    /// Average calories per sample
    public var average: Double {
        items.isEmpty ? 0 : totalCalories / Double(items.count)
    }
}
