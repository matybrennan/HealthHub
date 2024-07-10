//
//  NutritionServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 5/24/18.
//

import Foundation
import HealthKit

@MainActor
public protocol NutritionServiceProtocol: Sendable {
    func nutrition(type: NutritionType) async throws -> Nutrition
    func save(model: Nutrition, extra: [String : Any]?) async throws
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
        case .energyConsumed: return HKQuantityType(.dietaryEnergyConsumed)
        case .carbohydrates: return HKQuantityType(.dietaryCarbohydrates)
        case .fiber: return HKQuantityType(.dietaryFiber)
        case .sugar: return HKQuantityType(.dietarySugar)
        case .fatTotal: return HKQuantityType(.dietaryFatTotal)
        case .fatMono: return HKQuantityType(.dietaryFatMonounsaturated)
        case .fatPoly: return HKQuantityType(.dietaryFatPolyunsaturated)
        case .fatSaturated: return HKQuantityType(.dietaryFatSaturated)
        case .cholesterol: return HKQuantityType(.dietaryCholesterol)
        case .protein: return HKQuantityType(.dietaryProtein)
        
        /// Vitamins
        case .vitaminA: return HKQuantityType(.dietaryVitaminA)
        case .thiamin: return HKQuantityType(.dietaryThiamin)
        case .riboflavin: return HKQuantityType(.dietaryRiboflavin)
        case .niacin: return HKQuantityType(.dietaryNiacin)
        case .pathothenicAcid: return HKQuantityType(.dietaryPantothenicAcid)
        case .vitaminB6: return HKQuantityType(.dietaryVitaminB6)
        case .biotin: return HKQuantityType(.dietaryBiotin)
        case .vitaminB12: return HKQuantityType(.dietaryVitaminB12)
        case .vitaminC: return HKQuantityType(.dietaryVitaminC)
        case .vitaminD: return HKQuantityType(.dietaryVitaminD)
        case .vitaminE: return HKQuantityType(.dietaryVitaminE)
        case .vitaminK: return HKQuantityType(.dietaryVitaminK)
        case .folate: return HKQuantityType(.dietaryFolate)

        /// Minerals
        case .calcium: return HKQuantityType(.dietaryCalcium)
        case .chloride: return HKQuantityType(.dietaryChloride)
        case .iron: return HKQuantityType(.dietaryIron)
        case .magnesium: return HKQuantityType(.dietaryMagnesium)
        case .phosphorus: return HKQuantityType(.dietaryPhosphorus)
        case .potassium: return HKQuantityType(.dietaryPotassium)
        case .sodium: return HKQuantityType(.dietarySodium)
        case .zinc: return HKQuantityType(.dietaryZinc)

        /// Ultratrace Minerals
        case .chromium: return HKQuantityType(.dietaryChromium)
        case .copper: return HKQuantityType(.dietaryCopper)
        case .iodine: return HKQuantityType(.dietaryIodine)
        case .manganese: return HKQuantityType(.dietaryManganese)
        case .molybdenum: return HKQuantityType(.dietaryMolybdenum)
        case .selenium: return HKQuantityType(.dietarySelenium)

        /// Hydration
        case .water: return HKQuantityType(.dietaryWater)

        /// Caffeine
        case .caffeine: return HKQuantityType(.dietaryCaffeine)
            
        }
    }
}
