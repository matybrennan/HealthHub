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
    case respiratoryRate // respiratory, vitals
    case bodyTemperature // body, vitals
    case menstruation // cycle, vitals
    case abdominalCramps // cycle, symptoms
    case bloodGlucose // vitals, other
    case bloodOxygen // respiratory, vitals
    case inhalerUsage // respiratory, other
    case sixMinuteWalk // mobility, respiratory

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
        case .vitaminA: return HKQuantityType(.dietaryVitaminA)
        case .thiamin: return HKQuantityType(.dietaryThiamin)
        case .riboflavin: return HKQuantityType(.dietaryRiboflavin)
        case .niacin: return HKQuantityType(.dietaryNiacin)
        case .pathothenicAcid: return HKQuantityType(.dietaryPantothenicAcid)
        case .vitaminB6: return HKQuantityType(.dietaryVitaminB6)
        case .biotin: return HKQuantityType(.dietaryBiotin)
        case .vitaminB12: return HKQuantityType(.dietaryEnergyConsumed)
        case .vitaminC: return HKQuantityType(.dietaryVitaminB12)
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
        case .sodium: return HKQuantityType(.dietaryPotassium)
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

        // Sleep
        case .sleepAnalysis: return HKCategoryType(.sleepAnalysis)

        // Mindful
        case .mindful: return HKCategoryType(.mindfulSession)

        // Cycle tracking
        case .bloating: return HKCategoryType(.bloating)
        case .breastPain: return HKCategoryType(.breastPain)
        case .cervicalMucusQuality: return HKCategoryType(.cervicalMucusQuality)
        //case .contraceptives: return HKCategoryType(.contraceptive)
        //case .lactation: return HKCategoryType(.lactation)
        case .moodChanges: return HKCategoryType(.moodChanges)
        case .ovulationTestResult: return HKCategoryType(.ovulationTestResult)
        case .pregancyTestResult: return HKCategoryType(.pregnancyTestResult)
        case .progesteroneTestResult: return HKCategoryType(.progesteroneTestResult)
        case .spotting: return HKCategoryType(.intermenstrualBleeding)
        case .vaginalDryness: return HKCategoryType(.vaginalDryness)

        // Symptoms
        case .acne: return HKCategoryType(.acne)
        case .appetiteChanges: return HKCategoryType(.appetiteChanges)
        case .bladderIncontinence: return HKCategoryType(.bladderIncontinence)
        case .bodyAndAchePain: return HKCategoryType(.generalizedBodyAche)
        case .chills: return HKCategoryType(.chills)
        case .chestTightnessOrPain: return HKCategoryType(.chestTightnessOrPain)
        case .constipation: return HKCategoryType(.constipation)
        case .coughing: return HKCategoryType(.coughing)
        case .diarrhea: return HKCategoryType(.diarrhea)
        case .dizziness: return HKCategoryType(.dizziness)
        case .drySkin: return HKCategoryType(.drySkin)
        case .fatigue: return HKCategoryType(.fatigue)
        case .fainting: return HKCategoryType(.fainting)
        case .fever: return HKCategoryType(.fever)
        case .hairLoss: return HKCategoryType(.hairLoss)
        case .headache: return HKCategoryType(.headache)
        case .heartBurn: return HKCategoryType(.heartburn)
        case .hotFlushes: return HKCategoryType(.hotFlashes)
        case .lossOfSmell: return HKCategoryType(.lossOfSmell)
        case .lossOfTaste: return HKCategoryType(.lossOfTaste)
        case .lowerBackPain: return HKCategoryType(.lowerBackPain)
        case .memoryLapse: return HKCategoryType(.memoryLapse)
        case .nausea: return HKCategoryType(.nausea)
        case .nightSweats: return HKCategoryType(.nightSweats)
        case .pelvicPain: return HKCategoryType(.pelvicPain)
        case .rapidPoundingOrFlutteringHeartbeat: return HKCategoryType(.rapidPoundingOrFlutteringHeartbeat)
        case .runnyNose: return HKCategoryType(.runnyNose)
        case .shortnessOfBreath: return HKCategoryType(.shortnessOfBreath)
        case .skippedHeartbeat: return HKCategoryType(.skippedHeartbeat)
        case .sleepChanges: return HKCategoryType(.sleepChanges)
        case .soreThroat: return HKCategoryType(.soreThroat)
        case .vomiting: return HKCategoryType(.vomiting)
        case .wheezing: return HKCategoryType(.wheezing)

        // Respiratory
        case .forcedRespiratoryVolume: return HKQuantityType(.forcedExpiratoryVolume1)
        case .forcedVitalCapacity: return HKQuantityType(.forcedVitalCapacity)
        case .peakExpiratoryFlowRate: return HKQuantityType(.peakExpiratoryFlowRate)

        // Vitals
        case .bloodPressureSystolic: return HKQuantityType(.bloodPressureSystolic)
        case .bloodPressureDiastolic: return HKQuantityType(.bloodPressureDiastolic)

        // Other Data
        case .alcoholConsumption: return HKQuantityType(.numberOfAlcoholicBeverages)
        case .alcoholContent: return HKQuantityType(.bloodAlcoholContent)
        case .handWashing: return HKCategoryType(.handwashingEvent)
        case .insulinDelivery: return HKQuantityType(.insulinDelivery)
        case .numberOfTimesFallen: return HKQuantityType(.numberOfTimesFallen)
        case .toothBrushing: return HKCategoryType(.toothbrushingEvent)
        case .timeInDaylight: return HKQuantityType(.timeInDaylight)
        case .uvExposure: return HKQuantityType(.uvExposure)
        case .waterTemperature: return HKQuantityType(.waterTemperature)
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
        case .vitaminA: return HKQuantityType(.dietaryVitaminA)
        case .thiamin: return HKQuantityType(.dietaryThiamin)
        case .riboflavin: return HKQuantityType(.dietaryRiboflavin)
        case .niacin: return HKQuantityType(.dietaryNiacin)
        case .pathothenicAcid: return HKQuantityType(.dietaryPantothenicAcid)
        case .vitaminB6: return HKQuantityType(.dietaryVitaminB6)
        case .biotin: return HKQuantityType(.dietaryBiotin)
        case .vitaminB12: return HKQuantityType(.dietaryEnergyConsumed)
        case .vitaminC: return HKQuantityType(.dietaryVitaminB12)
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
        case .sodium: return HKQuantityType(.dietaryPotassium)
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

        // Sleep
        case .sleepAnalysis: return HKCategoryType(.sleepAnalysis)

        // Mindful
        case .mindful: return HKCategoryType(.mindfulSession)

        // Cycle tracking
        case .bloating: return HKCategoryType(.bloating)
        case .breastPain: return HKCategoryType(.breastPain)
        case .cervicalMucusQuality: return HKCategoryType(.cervicalMucusQuality)
        //case .contraceptives: return HKCategoryType(.contraceptive)
        //case .lactation: return HKCategoryType(.lactation)
        case .moodChanges: return HKCategoryType(.moodChanges)
        case .ovulationTestResult: return HKCategoryType(.ovulationTestResult)
        case .pregancyTestResult: return HKCategoryType(.pregnancyTestResult)
        case .progesteroneTestResult: return HKCategoryType(.progesteroneTestResult)
        case .spotting: return HKCategoryType(.intermenstrualBleeding)
        case .vaginalDryness: return HKCategoryType(.vaginalDryness)

        // Symptoms
        case .acne: return HKCategoryType(.acne)
        case .appetiteChanges: return HKCategoryType(.appetiteChanges)
        case .bladderIncontinence: return HKCategoryType(.bladderIncontinence)
        case .bodyAndAchePain: return HKCategoryType(.generalizedBodyAche)
        case .chills: return HKCategoryType(.chills)
        case .chestTightnessOrPain: return HKCategoryType(.chestTightnessOrPain)
        case .constipation: return HKCategoryType(.constipation)
        case .coughing: return HKCategoryType(.coughing)
        case .diarrhea: return HKCategoryType(.diarrhea)
        case .dizziness: return HKCategoryType(.dizziness)
        case .drySkin: return HKCategoryType(.drySkin)
        case .fatigue: return HKCategoryType(.fatigue)
        case .fainting: return HKCategoryType(.fainting)
        case .fever: return HKCategoryType(.fever)
        case .hairLoss: return HKCategoryType(.hairLoss)
        case .headache: return HKCategoryType(.headache)
        case .heartBurn: return HKCategoryType(.heartburn)
        case .hotFlushes: return HKCategoryType(.hotFlashes)
        case .lossOfSmell: return HKCategoryType(.lossOfSmell)
        case .lossOfTaste: return HKCategoryType(.lossOfTaste)
        case .lowerBackPain: return HKCategoryType(.lowerBackPain)
        case .memoryLapse: return HKCategoryType(.memoryLapse)
        case .nausea: return HKCategoryType(.nausea)
        case .nightSweats: return HKCategoryType(.nightSweats)
        case .pelvicPain: return HKCategoryType(.pelvicPain)
        case .rapidPoundingOrFlutteringHeartbeat: return HKCategoryType(.rapidPoundingOrFlutteringHeartbeat)
        case .runnyNose: return HKCategoryType(.runnyNose)
        case .shortnessOfBreath: return HKCategoryType(.shortnessOfBreath)
        case .skippedHeartbeat: return HKCategoryType(.skippedHeartbeat)
        case .sleepChanges: return HKCategoryType(.sleepChanges)
        case .soreThroat: return HKCategoryType(.soreThroat)
        case .vomiting: return HKCategoryType(.vomiting)
        case .wheezing: return HKCategoryType(.wheezing)

        // Respiratory
        case .forcedRespiratoryVolume: return HKQuantityType(.forcedExpiratoryVolume1)
        case .forcedVitalCapacity: return HKQuantityType(.forcedVitalCapacity)
        case .peakExpiratoryFlowRate: return HKQuantityType(.peakExpiratoryFlowRate)

        // Vitals
        case .bloodPressureSystolic: return HKQuantityType(.bloodPressureSystolic)
        case .bloodPressureDiastolic: return HKQuantityType(.bloodPressureDiastolic)

        // Other Data
        case .alcoholConsumption: return HKQuantityType(.numberOfAlcoholicBeverages)
        case .alcoholContent: return HKQuantityType(.bloodAlcoholContent)
        case .handWashing: return HKCategoryType(.handwashingEvent)
        case .insulinDelivery: return HKQuantityType(.insulinDelivery)
        case .numberOfTimesFallen: return HKQuantityType(.numberOfTimesFallen)
        case .toothBrushing: return HKCategoryType(.toothbrushingEvent)
        case .timeInDaylight: return HKQuantityType(.timeInDaylight)
        case .uvExposure: return HKQuantityType(.uvExposure)
        case .waterTemperature: return HKQuantityType(.waterTemperature)
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
