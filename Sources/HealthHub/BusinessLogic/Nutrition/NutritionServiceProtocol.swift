//
//  NutritionServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 5/24/18.
//

import Foundation
import HealthKit

public protocol NutritionServiceProtocol {
    func nutrition(type: NutritionType) async throws -> Nutrition
    func save(model: Nutrition, extra: [String: Sendable]?) async throws
}

/*
 - https://developer.apple.com/documentation/healthkit/health_data_types/nutrition_type_identifiers
 - reference link for types
 */

public enum NutritionType {
    
    // Macronutrients
    case energyConsumed
    case carbohydrates
    case fiber
    case sugar
    case fatTotal
    case fatMono
    case fatPoly
    case fatSaturated
    case cholesterol
    case protein
    
    // Vitamins
    case vitaminA
    case thiamin
    case riboflavin
    case niacin
    case pathothenicAcid
    case vitaminB6
    case biotin
    case vitaminB12
    case vitaminC
    case vitaminD
    case vitaminE
    case vitaminK
    case folate
    
    /// Minerals
    case calcium
    case chloride
    case iron
    case magnesium
    case phosphorus
    case potassium
    case sodium
    case zinc
    
    /// Ultratrace Minerals
    case chromium
    case copper
    case iodine
    case manganese
    case molybdenum
    case selenium
    
    /// Hydration
    case water
    
    /// Caffeine
    case caffeine
    
    public var unitMeasure: (unit: HKUnit, unitStr: String) {
        
        var unitTuple: (HKUnit, String)!
        
        switch self {
           
        // Macronutrients
        case .energyConsumed: unitTuple = (HKUnit.kilocalorie(), "kcal")
        case .carbohydrates: unitTuple = (HKUnit.gram(), "g")
        case .fiber: unitTuple = (HKUnit.gram(), "g")
        case .sugar: unitTuple = (HKUnit.gram(), "g")
        case .fatTotal: unitTuple = (HKUnit.gram(), "g")
        case .fatMono: unitTuple = (HKUnit.gram(), "g")
        case .fatPoly: unitTuple = (HKUnit.gram(), "g")
        case .fatSaturated: unitTuple = (HKUnit.gram(), "g")
        case .cholesterol: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .protein: unitTuple = (HKUnit.gram(), "g")
        
        /// Vitamins
        case .vitaminA: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .thiamin: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .riboflavin: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .niacin: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .pathothenicAcid: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .vitaminB6: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .biotin: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .vitaminB12: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .vitaminC: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .vitaminD: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .vitaminE: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .vitaminK: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .folate: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        
        /// Minerals
        case .calcium: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .chloride: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .iron: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .magnesium: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .phosphorus: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .potassium: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .sodium: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .zinc: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
            
            
        /// Ultratrace Minerals
        case .chromium: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .copper: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .iodine: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .manganese: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .molybdenum: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .selenium: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
            
        /// Hydration
        case .water: unitTuple = (HKUnit.literUnit(with: HKMetricPrefix.milli), "mL")
            
        /// Caffeine
        case .caffeine: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        }
        
        return unitTuple
    }
    
    public var quantityType: HKQuantityType {
        switch self {
        
        /// Macronutrients
        case .energyConsumed: HKQuantityType(.dietaryEnergyConsumed)
        case .carbohydrates: HKQuantityType(.dietaryCarbohydrates)
        case .fiber: HKQuantityType(.dietaryFiber)
        case .sugar: HKQuantityType(.dietarySugar)
        case .fatTotal: HKQuantityType(.dietaryFatTotal)
        case .fatMono: HKQuantityType(.dietaryFatMonounsaturated)
        case .fatPoly: HKQuantityType(.dietaryFatPolyunsaturated)
        case .fatSaturated: HKQuantityType(.dietaryFatSaturated)
        case .cholesterol: HKQuantityType(.dietaryCholesterol)
        case .protein: HKQuantityType(.dietaryProtein)
        
        /// Vitamins
        case .vitaminA: HKQuantityType(.dietaryVitaminA)
        case .thiamin: HKQuantityType(.dietaryThiamin)
        case .riboflavin: HKQuantityType(.dietaryRiboflavin)
        case .niacin: HKQuantityType(.dietaryNiacin)
        case .pathothenicAcid: HKQuantityType(.dietaryPantothenicAcid)
        case .vitaminB6: HKQuantityType(.dietaryVitaminB6)
        case .biotin: HKQuantityType(.dietaryBiotin)
        case .vitaminB12: HKQuantityType(.dietaryVitaminB12)
        case .vitaminC: HKQuantityType(.dietaryVitaminC)
        case .vitaminD: HKQuantityType(.dietaryVitaminD)
        case .vitaminE: HKQuantityType(.dietaryVitaminE)
        case .vitaminK: HKQuantityType(.dietaryVitaminK)
        case .folate: HKQuantityType(.dietaryFolate)

        /// Minerals
        case .calcium: HKQuantityType(.dietaryCalcium)
        case .chloride: HKQuantityType(.dietaryChloride)
        case .iron: HKQuantityType(.dietaryIron)
        case .magnesium: HKQuantityType(.dietaryMagnesium)
        case .phosphorus: HKQuantityType(.dietaryPhosphorus)
        case .potassium: HKQuantityType(.dietaryPotassium)
        case .sodium: HKQuantityType(.dietarySodium)
        case .zinc: HKQuantityType(.dietaryZinc)

        /// Ultratrace Minerals
        case .chromium: HKQuantityType(.dietaryChromium)
        case .copper: HKQuantityType(.dietaryCopper)
        case .iodine: HKQuantityType(.dietaryIodine)
        case .manganese: HKQuantityType(.dietaryManganese)
        case .molybdenum: HKQuantityType(.dietaryMolybdenum)
        case .selenium: HKQuantityType(.dietarySelenium)

        /// Hydration
        case .water: HKQuantityType(.dietaryWater)

        /// Caffeine
        case .caffeine: HKQuantityType(.dietaryCaffeine)
            
        }
    }
}
