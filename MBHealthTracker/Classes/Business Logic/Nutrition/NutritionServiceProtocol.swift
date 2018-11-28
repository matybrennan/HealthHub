//
//  NutritionServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 5/24/18.
//

import Foundation
import HealthKit

/*
 - https://developer.apple.com/documentation/healthkit/health_data_types/nutrition_type_identifiers
 - reference link for types
 */


public enum NutritionType {
    
    // Macronutrients
    case energyConsumed
    case carbohydrates
    
    // Vitamins
    case vitaminA
    
    // Minerals
    case calcium
    case chloride
    case iron
    
    var value: HKQuantityType {
        switch self {
        case .energyConsumed: return HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        case .carbohydrates: return HKQuantityType.quantityType(forIdentifier: .dietaryCarbohydrates)!
        
        case .vitaminA: return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminA)!
        
        case .calcium: return HKQuantityType.quantityType(forIdentifier: .dietaryCalcium)!
        case .chloride: return HKQuantityType.quantityType(forIdentifier: .dietaryChloride)!
        case .iron: return HKQuantityType.quantityType(forIdentifier: .dietaryIron)!
        
        }
    }
}

public protocol NutritionServiceProtocol {
    
    func getNutrition(fromType type: NutritionType, completionHandler: @escaping (AsyncCallResult<Nutrition>) -> Void) throws
}
