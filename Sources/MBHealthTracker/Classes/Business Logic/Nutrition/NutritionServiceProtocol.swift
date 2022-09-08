//
//  NutritionServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 5/24/18.
//

import Foundation
import HealthKit

public protocol NutritionServiceProtocol {
    func nutrition(type: NutritionType) async throws -> Nutrition
    func save(nutrition: Nutrition.Info, extra: [String : Any]?) async throws
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
        case .energyConsumed: return HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        case .carbohydrates: return HKQuantityType.quantityType(forIdentifier: .dietaryCarbohydrates)!
        case .fiber: return HKQuantityType.quantityType(forIdentifier: .dietaryFiber)!
        case .sugar: return HKQuantityType.quantityType(forIdentifier: .dietarySugar)!
        case .fatTotal: return HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal)!
        case .fatMono: return HKQuantityType.quantityType(forIdentifier: .dietaryFatMonounsaturated)!
        case .fatPoly: return HKQuantityType.quantityType(forIdentifier: .dietaryFatPolyunsaturated)!
        case .fatSaturated: return HKQuantityType.quantityType(forIdentifier: .dietaryFatSaturated)!
        case .cholesterol: return HKQuantityType.quantityType(forIdentifier: .dietaryCholesterol)!
        case .protein: return HKQuantityType.quantityType(forIdentifier: .dietaryProtein)!
        
        /// Vitamins
        case .vitaminA: return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminA)!
        case .thiamin: return HKQuantityType.quantityType(forIdentifier: .dietaryThiamin)!
        case .riboflavin: return HKQuantityType.quantityType(forIdentifier: .dietaryRiboflavin)!
        case .niacin: return HKQuantityType.quantityType(forIdentifier: .dietaryNiacin)!
        case .pathothenicAcid: return HKQuantityType.quantityType(forIdentifier: .dietaryPantothenicAcid)!
        case .vitaminB6: return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminB6)!
        case .biotin: return HKQuantityType.quantityType(forIdentifier: .dietaryBiotin)!
        case .vitaminB12: return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminB12)!
        case .vitaminC: return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminC)!
        case .vitaminD: return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminD)!
        case .vitaminE: return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminE)!
        case .vitaminK: return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminK)!
        case .folate: return HKQuantityType.quantityType(forIdentifier: .dietaryFolate)!
        
        /// Minerals
        case .calcium: return HKQuantityType.quantityType(forIdentifier: .dietaryCalcium)!
        case .chloride: return HKQuantityType.quantityType(forIdentifier: .dietaryChloride)!
        case .iron: return HKQuantityType.quantityType(forIdentifier: .dietaryIron)!
        case .magnesium: return HKQuantityType.quantityType(forIdentifier: .dietaryMagnesium)!
        case .phosphorus: return HKQuantityType.quantityType(forIdentifier: .dietaryPhosphorus)!
        case .potassium: return HKQuantityType.quantityType(forIdentifier: .dietaryPotassium)!
        case .sodium: return HKQuantityType.quantityType(forIdentifier: .dietarySodium)!
        case .zinc: return HKQuantityType.quantityType(forIdentifier: .dietaryZinc)!
        
        /// Ultratrace Minerals
        case .chromium: return HKQuantityType.quantityType(forIdentifier: .dietaryChromium)!
        case .copper: return HKQuantityType.quantityType(forIdentifier: .dietaryCopper)!
        case .iodine: return HKQuantityType.quantityType(forIdentifier: .dietaryIodine)!
        case .manganese: return HKQuantityType.quantityType(forIdentifier: .dietaryManganese)!
        case .molybdenum: return HKQuantityType.quantityType(forIdentifier: .dietaryMolybdenum)!
        case .selenium: return HKQuantityType.quantityType(forIdentifier: .dietarySelenium)!
           
        /// Hydration
        case .water: return HKQuantityType.quantityType(forIdentifier: .dietaryWater)!
            
        /// Caffeine
        case .caffeine: return HKQuantityType.quantityType(forIdentifier: .dietaryCaffeine)!
            
        }
    }
}
