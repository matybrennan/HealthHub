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
        public let startDate: Date
        public let endDate: Date
        public let type: HKQuantityType
    }
    
    public let items: [Info]
}

extension Nutrition.Info {
    
    public init(value: Double, unit: String, startDate: Date, type: HKQuantityType) {
        self.value = value
        self.unit = unit
        self.startDate = startDate
        self.endDate = Date()
        self.type = type
    }
    
}
