//
//  HealthType.swift
//  MBHealthTracker
//
//  Created by matybrennan on 23/4/18.
//

import Foundation
import HealthKit

public protocol SharableType {
    var sharable: HKSampleType? { get }
}

public protocol ReadableType {
    var readable: HKObjectType { get }
}

public typealias SharableReadableType = SharableType & ReadableType

public enum MBObjectType: SharableReadableType, CaseIterable {

    // Duplicates
    case sexualActivity // cycle, other
    case respiratoryRate
    case bodyTemperature
    case menstruation
    case abdominalCramps
    case bloodGlucose
    case bloodOxygen
    case inhalerUsage
    case sixMinuteWalk // mobility and respiratory

    // Heart
    case stepCount
    case heartRate
    case workout
    case activeEnergy
    
    // Body
    case basalBodyTemperature
    case bodyMassIndex
    case bodyFatPercentage
    case electrodermalActivity
    case height
    case leanBodyMass
    //case visionPrescription // Probably dont need
    case waistCircumference
    case weight
    case wristTemperature
    
    // Mobility
    case cardioFitness
    case doubleSupportTime
    case groundContactTime
    case runningStrideLength
    case stairSpeedDown
    case stairSpeedUp

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
    case sleepAnalysis
    
    // Mindful
    case mindful
    
    // Cycle tracking
    case bloating
    case breastPain
    case cervicalMucusQuality
    //case contraceptives // no values needed for now
    //case lactation // no values needed for now
    case moodChanges
    case ovulationTestResult
    //case pregnancy // no values needed for now
    case pregancyTestResult
    case progesteroneTestResult
    case spotting
    case vaginalDryness
    
    // Symptoms
    case acne
    case appetiteChanges
    case bladderIncontinence
    case bodyAndAchePain
    case chills
    case chestTightnessOrPain
    case constipation
    case coughing
    case diarrhea
    case dizziness
    case drySkin
    case fainting
    case fatigue
    case fever
    case hairLoss
    case headache
    case heartBurn
    case hotFlushes
    case lossOfSmell
    case lossOfTaste
    case lowerBackPain
    case memoryLapse
    case nausea
    case nightSweats
    case pelvicPain
    case rapidPoundingOrFlutteringHeartbeat
    case runnyNose
    case shortnessOfBreath
    case skippedHeartbeat
    case sleepChanges
    case soreThroat
    case vomiting
    case wheezing
    
    // Respiratory
    case forcedRespiratoryVolume
    case forcedVitalCapacity
    case peakExpiratoryFlowRate

    // Vitals
    case bloodPressureSystolic
    case bloodPressureDiastolic
    
    // Other Data
    case alcoholConsumption
    case alcoholContent
    case handWashing
    case insulinDelivery
    case numberOfTimesFallen
    case toothBrushing
    case timeInDaylight
    case uvExposure
    case waterTemperature
    
    public var sharable: HKSampleType? {
        switch self {
            
        // Common
        case .sexualActivity: return HKCategoryType(.sexualActivity)
        case .respiratoryRate: return HKQuantityType(.respiratoryRate)
        case .bodyTemperature: return HKQuantityType(.bodyTemperature)
        case .menstruation: return HKCategoryType(.menstrualFlow)
        case .abdominalCramps: return HKCategoryType(.abdominalCramps)
        case .bloodGlucose: return HKQuantityType(.bloodGlucose)
        case .bloodOxygen: return HKQuantityType(.oxygenSaturation)
        case .inhalerUsage: return HKQuantityType(.inhalerUsage)
        case .sixMinuteWalk: return HKQuantityType(.sixMinuteWalkTestDistance)

        // Heart
        case .stepCount: return HKQuantityType(.stepCount)
        case .heartRate: return HKQuantityType(.heartRate)
        case .workout: return HKWorkoutType.workoutType()
        case .activeEnergy: return HKQuantityType(.activeEnergyBurned)

        // Body
        case .basalBodyTemperature: return HKQuantityType(.basalBodyTemperature)
        case .weight: return HKQuantityType(.bodyMass)
        case .electrodermalActivity: return HKQuantityType(.electrodermalActivity)
        case .leanBodyMass: return HKQuantityType(.leanBodyMass)
        case .height: return HKQuantityType(.height)
        case .bodyMassIndex: return HKQuantityType(.bodyMassIndex)
        case .bodyFatPercentage: return HKQuantityType(.bodyFatPercentage)
        case .waistCircumference: return HKQuantityType(.waistCircumference)
        case .wristTemperature: return nil

        // Mobility
        case .cardioFitness: return nil
        case .doubleSupportTime: return HKQuantityType(.walkingDoubleSupportPercentage)
        case .groundContactTime: return HKQuantityType(.runningGroundContactTime)
        case .runningStrideLength: return HKQuantityType(.runningStrideLength)
        case .stairSpeedDown: return HKQuantityType(.stairDescentSpeed)
        case .stairSpeedUp: return HKQuantityType(.stairAscentSpeed)

        // Nutrition
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
        case .sleepAnalysis: return HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
            
        // Mindful
        case .mindful: return HKCategoryType.categoryType(forIdentifier: .mindfulSession)!
            
        // Cycle tracking
        case .bloating: return HKQuantityType.categoryType(forIdentifier: .bloating)!
        case .breastPain: return HKQuantityType.categoryType(forIdentifier: .breastPain)!
        case .cervicalMucusQuality: return HKQuantityType.categoryType(forIdentifier: .cervicalMucusQuality)!
        //case .contraceptives: return HKQuantityType.categoryType(forIdentifier: .contraceptive)!
        //case .lactation: return HKQuantityType.categoryType(forIdentifier: .lactation)!
        case .moodChanges: return HKQuantityType.categoryType(forIdentifier: .moodChanges)!
        case .ovulationTestResult: return HKQuantityType.categoryType(forIdentifier: .ovulationTestResult)!
        case .pregancyTestResult: return HKQuantityType.categoryType(forIdentifier: .pregnancyTestResult)!
        case .progesteroneTestResult: return HKQuantityType.categoryType(forIdentifier: .progesteroneTestResult)!
        case .spotting: return HKQuantityType.categoryType(forIdentifier: .intermenstrualBleeding)!
        case .vaginalDryness: return HKQuantityType.categoryType(forIdentifier: .vaginalDryness)!
           
        // Symptoms
        case .acne: return HKQuantityType.categoryType(forIdentifier: .acne)!
        case .appetiteChanges: return HKQuantityType.categoryType(forIdentifier: .appetiteChanges)!
        case .bladderIncontinence: return HKQuantityType.categoryType(forIdentifier: .bladderIncontinence)!
        case .bodyAndAchePain: return HKQuantityType.categoryType(forIdentifier: .generalizedBodyAche)!
        case .chills: return HKQuantityType.categoryType(forIdentifier: .chills)!
        case .chestTightnessOrPain: return HKQuantityType.categoryType(forIdentifier: .chestTightnessOrPain)!
        case .constipation: return HKQuantityType.categoryType(forIdentifier: .constipation)!
        case .coughing: return HKQuantityType.categoryType(forIdentifier: .coughing)!
        case .diarrhea: return HKQuantityType.categoryType(forIdentifier: .diarrhea)!
        case .dizziness: return HKQuantityType.categoryType(forIdentifier: .dizziness)!
        case .drySkin: return HKQuantityType.categoryType(forIdentifier: .drySkin)!
        case .fatigue: return HKQuantityType.categoryType(forIdentifier: .fatigue)!
        case .fainting: return HKQuantityType.categoryType(forIdentifier: .fainting)!
        case .fever: return HKQuantityType.categoryType(forIdentifier: .fever)!
        case .hairLoss: return HKQuantityType.categoryType(forIdentifier: .hairLoss)!
        case .headache: return HKQuantityType.categoryType(forIdentifier: .headache)!
        case .heartBurn: return HKQuantityType.categoryType(forIdentifier: .heartburn)!
        case .hotFlushes: return HKQuantityType.categoryType(forIdentifier: .hotFlashes)!
        case .lossOfSmell: return HKQuantityType.categoryType(forIdentifier: .lossOfSmell)!
        case .lossOfTaste: return HKQuantityType.categoryType(forIdentifier: .lossOfTaste)!
        case .lowerBackPain: return HKQuantityType.categoryType(forIdentifier: .lowerBackPain)!
        case .memoryLapse: return HKQuantityType.categoryType(forIdentifier: .memoryLapse)!
        case .nausea: return HKQuantityType.categoryType(forIdentifier: .nausea)!
        case .nightSweats: return HKQuantityType.categoryType(forIdentifier: .nightSweats)!
        case .pelvicPain: return HKQuantityType.categoryType(forIdentifier: .pelvicPain)!
        case .rapidPoundingOrFlutteringHeartbeat: return HKQuantityType.categoryType(forIdentifier: .rapidPoundingOrFlutteringHeartbeat)!
        case .runnyNose: return HKQuantityType.categoryType(forIdentifier: .runnyNose)!
        case .shortnessOfBreath: return HKQuantityType.categoryType(forIdentifier: .shortnessOfBreath)!
        case .skippedHeartbeat: return HKQuantityType.categoryType(forIdentifier: .skippedHeartbeat)!
        case .sleepChanges: return HKQuantityType.categoryType(forIdentifier: .sleepChanges)!
        case .soreThroat: return HKQuantityType.categoryType(forIdentifier: .soreThroat)!
        case .vomiting: return HKQuantityType.categoryType(forIdentifier: .vomiting)!
        case .wheezing: return HKQuantityType.categoryType(forIdentifier: .wheezing)!
            
        // Respiratory
        case .forcedRespiratoryVolume: return HKSampleType.quantityType(forIdentifier: .forcedExpiratoryVolume1)!
        case .forcedVitalCapacity: return HKSampleType.quantityType(forIdentifier: .forcedVitalCapacity)!
        case .peakExpiratoryFlowRate: return HKSampleType.quantityType(forIdentifier: .peakExpiratoryFlowRate)!

        // Vitals
        case .bloodPressureSystolic: return HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)!
        case .bloodPressureDiastolic: return HKSampleType.quantityType(forIdentifier: .bloodPressureDiastolic)!
            
        // Other Data
        case .alcoholConsumption: return HKSampleType.quantityType(forIdentifier: .numberOfAlcoholicBeverages)!
        case .alcoholContent: return HKSampleType.quantityType(forIdentifier: .bloodAlcoholContent)!
        case .handWashing: return HKSampleType.categoryType(forIdentifier: .handwashingEvent)!
        case .insulinDelivery: return HKSampleType.quantityType(forIdentifier: .insulinDelivery)!
        case .numberOfTimesFallen: return HKSampleType.quantityType(forIdentifier: .numberOfTimesFallen)!
        case .toothBrushing: return HKSampleType.categoryType(forIdentifier: .toothbrushingEvent)!
        case .timeInDaylight: return HKQuantityType.quantityType(forIdentifier: .timeInDaylight)!
        case .uvExposure: return HKQuantityType.quantityType(forIdentifier: .uvExposure)!
        case .waterTemperature: return HKQuantityType.quantityType(forIdentifier: .waterTemperature)!
        }
    }
    
    public var readable: HKObjectType {
        switch self {
            
        // Common
        case .sexualActivity: return HKCategoryType(.sexualActivity)
        case .respiratoryRate: return HKQuantityType(.respiratoryRate)
        case .bodyTemperature: return HKQuantityType(.bodyTemperature)
        case .menstruation: return HKCategoryType(.menstrualFlow)
        case .abdominalCramps: return HKCategoryType(.abdominalCramps)
        case .bloodGlucose: return HKQuantityType(.bloodGlucose)
        case .bloodOxygen: return HKQuantityType(.oxygenSaturation)
        case .inhalerUsage: return HKQuantityType(.inhalerUsage)
        case .sixMinuteWalk: return HKQuantityType(.sixMinuteWalkTestDistance)

        // Heart
        case .stepCount: return HKQuantityType(.stepCount)
        case .heartRate: return HKQuantityType(.heartRate)
        case .workout: return HKWorkoutType.workoutType()
        case .activeEnergy: return HKQuantityType(.activeEnergyBurned)

        // Body
        case .basalBodyTemperature: return HKQuantityType(.basalBodyTemperature)
        case .weight: return HKQuantityType(.bodyMass)
        case .electrodermalActivity: return HKQuantityType(.electrodermalActivity)
        case .leanBodyMass: return HKQuantityType(.leanBodyMass)
        case .height: return HKQuantityType(.height)
        case .bodyMassIndex: return HKQuantityType(.bodyMassIndex)
        case .bodyFatPercentage: return HKQuantityType(.bodyFatPercentage)
        case .waistCircumference: return HKQuantityType(.waistCircumference)
        case .wristTemperature: return HKQuantityType(.appleSleepingWristTemperature)

        // Mobility
        case .cardioFitness: return HKCategoryType(.lowCardioFitnessEvent)
        case .doubleSupportTime: return HKQuantityType(.walkingDoubleSupportPercentage)
        case .groundContactTime: return HKQuantityType(.runningGroundContactTime)
        case .runningStrideLength: return HKQuantityType(.runningStrideLength)
        case .stairSpeedDown: return HKQuantityType(.stairDescentSpeed)
        case .stairSpeedUp: return HKQuantityType(.stairAscentSpeed)

        // Nutrition
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
        case .sleepAnalysis: return HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
            
        // Mindful
        case .mindful: return HKCategoryType.categoryType(forIdentifier: .mindfulSession)!
        
        // Cycle tracking
        case .bloating: return HKQuantityType.categoryType(forIdentifier: .bloating)!
        case .breastPain: return HKQuantityType.categoryType(forIdentifier: .breastPain)!
        case .cervicalMucusQuality: return HKQuantityType.categoryType(forIdentifier: .cervicalMucusQuality)!
        //case .contraceptives: return HKQuantityType.categoryType(forIdentifier: .contraceptive)!
        //case .lactation: return HKQuantityType.categoryType(forIdentifier: .lactation)!
        case .moodChanges: return HKQuantityType.categoryType(forIdentifier: .moodChanges)!
        case .ovulationTestResult: return HKQuantityType.categoryType(forIdentifier: .ovulationTestResult)!
        case .pregancyTestResult: return HKQuantityType.categoryType(forIdentifier: .pregnancyTestResult)!
        case .progesteroneTestResult: return HKQuantityType.categoryType(forIdentifier: .progesteroneTestResult)!
        case .spotting: return HKQuantityType.categoryType(forIdentifier: .intermenstrualBleeding)!
        case .vaginalDryness: return HKQuantityType.categoryType(forIdentifier: .vaginalDryness)!
        
        // Symptoms
        case .acne: return HKQuantityType.categoryType(forIdentifier: .acne)!
        case .appetiteChanges: return HKQuantityType.categoryType(forIdentifier: .appetiteChanges)!
        case .bladderIncontinence: return HKQuantityType.categoryType(forIdentifier: .bladderIncontinence)!
        case .bodyAndAchePain: return HKQuantityType.categoryType(forIdentifier: .generalizedBodyAche)!
        case .chills: return HKQuantityType.categoryType(forIdentifier: .chills)!
        case .chestTightnessOrPain: return HKQuantityType.categoryType(forIdentifier: .chestTightnessOrPain)!
        case .constipation: return HKQuantityType.categoryType(forIdentifier: .constipation)!
        case .coughing: return HKQuantityType.categoryType(forIdentifier: .coughing)!
        case .diarrhea: return HKQuantityType.categoryType(forIdentifier: .diarrhea)!
        case .dizziness: return HKQuantityType.categoryType(forIdentifier: .dizziness)!
        case .drySkin: return HKQuantityType.categoryType(forIdentifier: .drySkin)!
        case .fatigue: return HKQuantityType.categoryType(forIdentifier: .fatigue)!
        case .fainting: return HKQuantityType.categoryType(forIdentifier: .fainting)!
        case .fever: return HKQuantityType.categoryType(forIdentifier: .fever)!
        case .hairLoss: return HKQuantityType.categoryType(forIdentifier: .hairLoss)!
        case .headache: return HKQuantityType.categoryType(forIdentifier: .headache)!
        case .heartBurn: return HKQuantityType.categoryType(forIdentifier: .heartburn)!
        case .hotFlushes: return HKQuantityType.categoryType(forIdentifier: .hotFlashes)!
        case .lossOfSmell: return HKQuantityType.categoryType(forIdentifier: .lossOfSmell)!
        case .lossOfTaste: return HKQuantityType.categoryType(forIdentifier: .lossOfTaste)!
        case .lowerBackPain: return HKQuantityType.categoryType(forIdentifier: .lowerBackPain)!
        case .memoryLapse: return HKQuantityType.categoryType(forIdentifier: .memoryLapse)!
        case .nausea: return HKQuantityType.categoryType(forIdentifier: .nausea)!
        case .nightSweats: return HKQuantityType.categoryType(forIdentifier: .nightSweats)!
        case .pelvicPain: return HKQuantityType.categoryType(forIdentifier: .pelvicPain)!
        case .rapidPoundingOrFlutteringHeartbeat: return HKQuantityType.categoryType(forIdentifier: .rapidPoundingOrFlutteringHeartbeat)!
        case .runnyNose: return HKQuantityType.categoryType(forIdentifier: .runnyNose)!
        case .shortnessOfBreath: return HKQuantityType.categoryType(forIdentifier: .shortnessOfBreath)!
        case .skippedHeartbeat: return HKQuantityType.categoryType(forIdentifier: .skippedHeartbeat)!
        case .sleepChanges: return HKQuantityType.categoryType(forIdentifier: .sleepChanges)!
        case .soreThroat: return HKQuantityType.categoryType(forIdentifier: .soreThroat)!
        case .vomiting: return HKQuantityType.categoryType(forIdentifier: .vomiting)!
        case .wheezing: return HKQuantityType.categoryType(forIdentifier: .wheezing)!
        
        // Respiratory
        case .forcedRespiratoryVolume: return HKSampleType.quantityType(forIdentifier: .forcedExpiratoryVolume1)!
        case .forcedVitalCapacity: return HKSampleType.quantityType(forIdentifier: .forcedVitalCapacity)!
        case .peakExpiratoryFlowRate: return HKSampleType.quantityType(forIdentifier: .peakExpiratoryFlowRate)!

        // Vitals
        case .bloodPressureSystolic: return HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)!
        case .bloodPressureDiastolic: return HKSampleType.quantityType(forIdentifier: .bloodPressureDiastolic)!
            
        // Other Data
        case .alcoholConsumption: return HKSampleType.quantityType(forIdentifier: .numberOfAlcoholicBeverages)!
        case .alcoholContent: return HKSampleType.quantityType(forIdentifier: .bloodAlcoholContent)!
        case .handWashing: return HKSampleType.categoryType(forIdentifier: .handwashingEvent)!
        case .insulinDelivery: return HKSampleType.quantityType(forIdentifier: .insulinDelivery)!
        case .numberOfTimesFallen: return HKSampleType.quantityType(forIdentifier: .numberOfTimesFallen)!
        case .toothBrushing: return HKSampleType.categoryType(forIdentifier: .toothbrushingEvent)!
        case .timeInDaylight: return HKQuantityType.quantityType(forIdentifier: .timeInDaylight)!
        case .uvExposure: return HKQuantityType.quantityType(forIdentifier: .uvExposure)!
        case .waterTemperature: return HKQuantityType.quantityType(forIdentifier: .waterTemperature)!
        }
    }
}

public struct MBHealthType {
    
    static func shareTypes(_ types: [SharableType]) -> Set<HKSampleType> {
        let res = types.compactMap { $0.sharable }
        return Set(res)
    }
    
    static func readTypes(_ types: [ReadableType]) -> Set<HKObjectType> {
        let res = types.map { $0.readable }
        return Set(res)
    }
}
