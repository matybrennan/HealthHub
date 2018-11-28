//
//  NutritionModels.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 5/24/18.
//

import Foundation

public struct Nutrition {
    
    public struct NutritionInfo {
        let value: Double
        let unit: String
        let startDate: Date
        let endDate: Date
    }
    
    let items: [NutritionInfo]
    
}
