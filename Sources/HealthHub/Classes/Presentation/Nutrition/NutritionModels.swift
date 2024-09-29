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
        public let date: Date

        public init(value: Double, unit: String, date: Date) {
            self.value = value
            self.unit = unit
            self.date = date
        }
    }
    
    public let items: [Info]
    public let type: HKQuantityType

    public init(items: [Info], type: HKQuantityType) {
        self.items = items
        self.type = type
    }
}
