//
//  NutritionModels.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 5/24/18.
//

import Foundation

public struct Nutrition {
    
    public struct NutritionInfo {
        public let value: Double
        public let unit: String
        public let startDate: Date
        public let endDate: Date
    }
    
    public let items: [NutritionInfo]
    
}
