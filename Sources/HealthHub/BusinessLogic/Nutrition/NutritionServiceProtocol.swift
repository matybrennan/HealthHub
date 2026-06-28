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
 - https://developer.apple.com/documentation/healthkit/nutrition-type-identifiers
 - reference link for types
 */

public enum NutritionType: CaseIterable, Sendable {
    
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
    case pantothenicAcid
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

    // MARK: - Category

    public enum Category: String, CaseIterable, Sendable {
        case macronutrients = "Macronutrients"
        case vitamins = "Vitamins"
        case minerals = "Minerals"
        case ultratraceMinerals = "Ultratrace Minerals"
        case hydration = "Hydration"
        case caffeine = "Caffeine"
    }

    public var category: Category {
        switch self {
        case .energyConsumed, .carbohydrates, .fiber, .sugar, .fatTotal, .fatMono, .fatPoly, .fatSaturated, .cholesterol, .protein:
            return .macronutrients
        case .vitaminA, .thiamin, .riboflavin, .niacin, .pantothenicAcid, .vitaminB6, .biotin, .vitaminB12, .vitaminC, .vitaminD, .vitaminE, .vitaminK, .folate:
            return .vitamins
        case .calcium, .chloride, .iron, .magnesium, .phosphorus, .potassium, .sodium, .zinc:
            return .minerals
        case .chromium, .copper, .iodine, .manganese, .molybdenum, .selenium:
            return .ultratraceMinerals
        case .water:
            return .hydration
        case .caffeine:
            return .caffeine
        }
    }

    // MARK: - Display Name

    public var displayName: String {
        switch self {
        case .energyConsumed: return "Energy Consumed"
        case .carbohydrates: return "Carbohydrates"
        case .fiber: return "Fiber"
        case .sugar: return "Sugar"
        case .fatTotal: return "Total Fat"
        case .fatMono: return "Monounsaturated Fat"
        case .fatPoly: return "Polyunsaturated Fat"
        case .fatSaturated: return "Saturated Fat"
        case .cholesterol: return "Cholesterol"
        case .protein: return "Protein"
        case .vitaminA: return "Vitamin A"
        case .thiamin: return "Thiamin (B1)"
        case .riboflavin: return "Riboflavin (B2)"
        case .niacin: return "Niacin (B3)"
        case .pantothenicAcid: return "Pantothenic Acid (B5)"
        case .vitaminB6: return "Vitamin B6"
        case .biotin: return "Biotin (B7)"
        case .vitaminB12: return "Vitamin B12"
        case .vitaminC: return "Vitamin C"
        case .vitaminD: return "Vitamin D"
        case .vitaminE: return "Vitamin E"
        case .vitaminK: return "Vitamin K"
        case .folate: return "Folate"
        case .calcium: return "Calcium"
        case .chloride: return "Chloride"
        case .iron: return "Iron"
        case .magnesium: return "Magnesium"
        case .phosphorus: return "Phosphorus"
        case .potassium: return "Potassium"
        case .sodium: return "Sodium"
        case .zinc: return "Zinc"
        case .chromium: return "Chromium"
        case .copper: return "Copper"
        case .iodine: return "Iodine"
        case .manganese: return "Manganese"
        case .molybdenum: return "Molybdenum"
        case .selenium: return "Selenium"
        case .water: return "Water"
        case .caffeine: return "Caffeine"
        }
    }

    // MARK: - Unit Measure
    
    public var unitMeasure: (unit: HKUnit, unitStr: String) {
        switch self {
           
        // Macronutrients
        case .energyConsumed: (HKUnit.kilocalorie(), "kcal")
        case .carbohydrates: (HKUnit.gram(), "g")
        case .fiber: (HKUnit.gram(), "g")
        case .sugar: (HKUnit.gram(), "g")
        case .fatTotal: (HKUnit.gram(), "g")
        case .fatMono: (HKUnit.gram(), "g")
        case .fatPoly: (HKUnit.gram(), "g")
        case .fatSaturated: (HKUnit.gram(), "g")
        case .cholesterol: (HKUnit.gramUnit(with: .milli), "mg")
        case .protein: (HKUnit.gram(), "g")
        
        /// Vitamins
        case .vitaminA: (HKUnit.gramUnit(with: .micro), "mcg")
        case .thiamin: (HKUnit.gramUnit(with: .milli), "mg")
        case .riboflavin: (HKUnit.gramUnit(with: .milli), "mg")
        case .niacin: (HKUnit.gramUnit(with: .milli), "mg")
        case .pantothenicAcid: (HKUnit.gramUnit(with: .milli), "mg")
        case .vitaminB6: (HKUnit.gramUnit(with: .milli), "mg")
        case .biotin: (HKUnit.gramUnit(with: .micro), "mcg")
        case .vitaminB12: (HKUnit.gramUnit(with: .micro), "mcg")
        case .vitaminC: (HKUnit.gramUnit(with: .milli), "mg")
        case .vitaminD: (HKUnit.gramUnit(with: .micro), "mcg")
        case .vitaminE: (HKUnit.gramUnit(with: .milli), "mg")
        case .vitaminK: (HKUnit.gramUnit(with: .micro), "mcg")
        case .folate: (HKUnit.gramUnit(with: .micro), "mcg")
        
        /// Minerals
        case .calcium: (HKUnit.gramUnit(with: .milli), "mg")
        case .chloride: (HKUnit.gramUnit(with: .milli), "mg")
        case .iron: (HKUnit.gramUnit(with: .milli), "mg")
        case .magnesium: (HKUnit.gramUnit(with: .milli), "mg")
        case .phosphorus: (HKUnit.gramUnit(with: .milli), "mg")
        case .potassium: (HKUnit.gramUnit(with: .milli), "mg")
        case .sodium: (HKUnit.gramUnit(with: .milli), "mg")
        case .zinc: (HKUnit.gramUnit(with: .milli), "mg")
            
        /// Ultratrace Minerals
        case .chromium: (HKUnit.gramUnit(with: .micro), "mcg")
        case .copper: (HKUnit.gramUnit(with: .milli), "mg")
        case .iodine: (HKUnit.gramUnit(with: .micro), "mcg")
        case .manganese: (HKUnit.gramUnit(with: .milli), "mg")
        case .molybdenum: (HKUnit.gramUnit(with: .micro), "mcg")
        case .selenium: (HKUnit.gramUnit(with: .micro), "mcg")
            
        /// Hydration
        case .water: (HKUnit.literUnit(with: .milli), "mL")
            
        /// Caffeine
        case .caffeine: (HKUnit.gramUnit(with: .milli), "mg")
        }
    }

    // MARK: - Quantity Type
    
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
        case .pantothenicAcid: HKQuantityType(.dietaryPantothenicAcid)
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
