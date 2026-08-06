//
//  NutritionModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 5/24/18.
//

import Foundation
import HealthKit

public struct Nutrition: Sendable {

    public struct Info: Sendable {
        public let value: Double
        public let unit: String
        public let startDate: Date
        public let endDate: Date

        public init(value: Double, unit: String, startDate: Date, endDate: Date) {
            self.value = value
            self.unit = unit
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]
    public let type: HKQuantityType
    public let displayName: String
    public let category: NutritionType.Category

    public init(items: [Info], type: HKQuantityType, displayName: String, category: NutritionType.Category) {
        self.items = items
        self.type = type
        self.displayName = displayName
        self.category = category
    }
}

/// Groups multiple nutrition quantity samples into a single meal/food entry, mirroring
/// the `HKCorrelationTypeIdentifier.food` correlation type.
public struct Food: Sendable {

    public struct Item: Sendable {
        public let foodType: String?
        public let nutrients: [NutritionType: Double]
        public let startDate: Date
        public let endDate: Date

        public init(foodType: String? = nil, nutrients: [NutritionType: Double], startDate: Date, endDate: Date) {
            self.foodType = foodType
            self.nutrients = nutrients
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.endDate < $1.endDate })
    }
}
