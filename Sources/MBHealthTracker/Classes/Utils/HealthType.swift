//
//  HealthType.swift
//  MBHealthTracker
//
//  Created by matybrennan on 23/4/18.
//

import Foundation
import HealthKit

public protocol SharableType {
    var sharable: HKSampleType { get }
}

public protocol ReadableType {
    var readable: HKObjectType { get }
}

public typealias SharableReadableType = SharableType & ReadableType

/// Has both read and sharing capabilities
public enum MBObjectType: SharableType, ReadableType {
    
    case stepCount
    case heartRate
    case workout
    case activeEnergy
    
    // Body
    case bodyMass
    case leanBodyMass
    case height
    case bodyMassIndex
    case bodyFatPercentage
    case bodyTemperature
    case basalBodyTemperature
    case waistCircumference
    
    // Nutrition
    /// Macronutrients
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
    /// Vitamins
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
    
    
    // Sleep
    case sleep
    
    // Mindful
    case mindful
    
    // Cycle tracking
    case abdominalCramps
    case acne
    case appetiteChanges
    case bladderIncontinence
    case bloating
    case breastPain
    case chills
    case constipation
    //case contraceptives // no values needed for now
    case diarrhea
    case drySkin
    case fatigue
    case hairLoss
    case headache
    case hotFlashes
    case cervicalMucusQuality
    case menstruation
    case ovulationTestResult
    case sexualActivity
    case spotting
    
    // Vitals
    case bloodPressureSystolic
    case bloodPressureDiastolic
    case respiratoryRate
    case bloodGlucose
    case bloodOxygen
    
    public var sharable: HKSampleType {
        switch self {
        case .stepCount: return HKQuantityType.quantityType(forIdentifier: .stepCount)!
        case .heartRate: return HKQuantityType.quantityType(forIdentifier: .heartRate)!
        case .workout: return HKWorkoutType.workoutType()
        case .activeEnergy: return HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        
        // Body
        case .basalBodyTemperature: return HKQuantityType.quantityType(forIdentifier: .basalBodyTemperature)!
        case .bodyTemperature: return HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!
        case .bodyMass: return HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        case .leanBodyMass: return HKQuantityType.quantityType(forIdentifier: .leanBodyMass)!
        case .height: return HKQuantityType.quantityType(forIdentifier: .height)!
        case .bodyMassIndex: return HKQuantityType.quantityType(forIdentifier: .bodyMassIndex)!
        case .bodyFatPercentage: return HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)!
        case .waistCircumference: return HKQuantityType.quantityType(forIdentifier: .waistCircumference)!
            
        // Nutrition
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
            
        // Sleep
        case .sleep: return HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
            
        // Mindful
        case .mindful: return HKCategoryType.categoryType(forIdentifier: .mindfulSession)!
            
        // Cycle tracking
        case .abdominalCramps: return HKQuantityType.categoryType(forIdentifier: .abdominalCramps)!
        case .acne: return HKQuantityType.categoryType(forIdentifier: .acne)!
        case .appetiteChanges: return HKQuantityType.categoryType(forIdentifier: .appetiteChanges)!
        case .bladderIncontinence: return HKQuantityType.categoryType(forIdentifier: .bladderIncontinence)!
        case .bloating: return HKQuantityType.categoryType(forIdentifier: .bloating)!
        case .breastPain: return HKQuantityType.categoryType(forIdentifier: .breastPain)!
        case .cervicalMucusQuality: return HKQuantityType.categoryType(forIdentifier: .cervicalMucusQuality)!
        case .chills: return HKQuantityType.categoryType(forIdentifier: .chills)!
        case .constipation: return HKQuantityType.categoryType(forIdentifier: .constipation)!
        //case .contraceptives: return HKQuantityType.categoryType(forIdentifier: .contraceptive)!
        case .diarrhea: return HKQuantityType.categoryType(forIdentifier: .diarrhea)!
        case .drySkin: return HKQuantityType.categoryType(forIdentifier: .drySkin)!
        case .fatigue: return HKQuantityType.categoryType(forIdentifier: .fatigue)!
        case .hairLoss: return HKQuantityType.categoryType(forIdentifier: .hairLoss)!
        case .headache: return HKQuantityType.categoryType(forIdentifier: .headache)!
        case .hotFlashes: return HKQuantityType.categoryType(forIdentifier: .hotFlashes)!
        
        case .menstruation: return HKQuantityType.categoryType(forIdentifier: .menstrualFlow)!
        case .ovulationTestResult: return HKQuantityType.categoryType(forIdentifier: .ovulationTestResult)!
        case .sexualActivity: return HKQuantityType.categoryType(forIdentifier: .sexualActivity)!
        case .spotting: return HKQuantityType.categoryType(forIdentifier: .intermenstrualBleeding)!
            
        // Vitals
        case .bloodPressureSystolic: return HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)!
        case .bloodPressureDiastolic: return HKSampleType.quantityType(forIdentifier: .bloodPressureDiastolic)!
        case .respiratoryRate: return HKSampleType.quantityType(forIdentifier: .respiratoryRate)!
        case .bloodGlucose: return HKSampleType.quantityType(forIdentifier: .bloodGlucose)!
        case .bloodOxygen: return HKSampleType.quantityType(forIdentifier: .oxygenSaturation)!
        }
    }
    
    public var readable: HKObjectType {
        switch self {
        case .stepCount: return HKQuantityType.quantityType(forIdentifier: .stepCount)!
        case .heartRate: return HKQuantityType.quantityType(forIdentifier: .heartRate)!
        case .workout: return HKWorkoutType.workoutType()
        case .activeEnergy: return HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        
        // Body
        case .basalBodyTemperature: return HKQuantityType.quantityType(forIdentifier: .basalBodyTemperature)!
        case .bodyTemperature: return HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!
        case .bodyMass: return HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        case .leanBodyMass: return HKQuantityType.quantityType(forIdentifier: .leanBodyMass)!
        case .height: return HKQuantityType.quantityType(forIdentifier: .height)!
        case .bodyMassIndex: return HKQuantityType.quantityType(forIdentifier: .bodyMassIndex)!
        case .bodyFatPercentage: return HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)!
        case .waistCircumference: return HKQuantityType.quantityType(forIdentifier: .waistCircumference)!
        
        // Nutrition
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
            
        // Sleep
        case .sleep: return HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
            
        // Mindful
        case .mindful: return HKCategoryType.categoryType(forIdentifier: .mindfulSession)!
            
        // Cycle tracking
        case .abdominalCramps: return HKQuantityType.categoryType(forIdentifier: .abdominalCramps)!
        case .acne: return HKQuantityType.categoryType(forIdentifier: .acne)!
        case .appetiteChanges: return HKQuantityType.categoryType(forIdentifier: .appetiteChanges)!
        case .bladderIncontinence: return HKQuantityType.categoryType(forIdentifier: .bladderIncontinence)!
        case .bloating: return HKQuantityType.categoryType(forIdentifier: .bloating)!
        case .breastPain: return HKQuantityType.categoryType(forIdentifier: .breastPain)!
        case .chills: return HKQuantityType.categoryType(forIdentifier: .chills)!
        case .cervicalMucusQuality: return HKQuantityType.categoryType(forIdentifier: .cervicalMucusQuality)!
        case .constipation: return HKQuantityType.categoryType(forIdentifier: .constipation)!
        //case .contraceptives: return HKQuantityType.categoryType(forIdentifier: .contraceptive)!
        case .diarrhea: return HKQuantityType.categoryType(forIdentifier: .diarrhea)!
        case .drySkin: return HKQuantityType.categoryType(forIdentifier: .drySkin)!
        case .fatigue: return HKQuantityType.categoryType(forIdentifier: .fatigue)!
        case .hairLoss: return HKQuantityType.categoryType(forIdentifier: .hairLoss)!
        case .headache: return HKQuantityType.categoryType(forIdentifier: .headache)!
        case .hotFlashes: return HKQuantityType.categoryType(forIdentifier: .hotFlashes)!
        case .menstruation: return HKQuantityType.categoryType(forIdentifier: .menstrualFlow)!
        case .ovulationTestResult: return HKQuantityType.categoryType(forIdentifier: .ovulationTestResult)!
        case .sexualActivity: return HKQuantityType.categoryType(forIdentifier: .sexualActivity)!
        case .spotting: return HKQuantityType.categoryType(forIdentifier: .intermenstrualBleeding)!
            
        // Vitals
        case .bloodPressureSystolic: return HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)!
        case .bloodPressureDiastolic: return HKSampleType.quantityType(forIdentifier: .bloodPressureDiastolic)!
        case .respiratoryRate: return HKSampleType.quantityType(forIdentifier: .respiratoryRate)!
        case .bloodGlucose: return HKSampleType.quantityType(forIdentifier: .bloodGlucose)!
        case .bloodOxygen: return HKSampleType.quantityType(forIdentifier: .oxygenSaturation)!
        }
    }
}

/// Just has read capabilities
public enum MBReadType: ReadableType {
    
    // Characteristics
    case dob
    case gender
    
    public var readable: HKObjectType {
        switch self {
        case .dob:
            return HKCharacteristicType.characteristicType(forIdentifier: .dateOfBirth)!
        case .gender:
            return HKCharacteristicType.characteristicType(forIdentifier: .biologicalSex)!
        }
    }
}

/// Just has share capabilities
public enum MBShareType: SharableType {
    
    public var sharable: HKSampleType {
        switch self {
            //
        }
    }
}


public struct MBHealthType {
    
    static func shareTypes(_ types: [SharableType]) -> Set<HKSampleType>? {
        let res = types.map { $0.sharable }
        return Set(res)
    }
    
    static func readTypes(_ types: [ReadableType]) -> Set<HKObjectType>? {
        let res = types.map { $0.readable }
        return Set(res)
    }
}
