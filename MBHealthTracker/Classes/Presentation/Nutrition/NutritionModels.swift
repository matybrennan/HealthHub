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
        public let type: HKQuantityType
        public let startDate: Date
        public let endDate: Date
    }
    
    public let items: [Info]
}
