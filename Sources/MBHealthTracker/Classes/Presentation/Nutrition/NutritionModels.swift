//
//  NutritionModels.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 5/24/18.
//

import Foundation
import HealthKit

public struct Nutrition {
    
    public struct Info {
        public let value: Double
        public let unit: String
        public let date: Date
        public let type: HKQuantityType
        
        public init(value: Double, unit: String, date: Date, type: HKQuantityType) {
            self.value = value
            self.unit = unit
            self.date = date
            self.type = type
        }
    }
    
    public let items: [Info]
}
