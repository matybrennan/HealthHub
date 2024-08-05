//
//  HealthType.swift
//  MBHealthTracker
//
//  Created by matybrennan on 23/4/18.
//

import Foundation
import HealthKit

public protocol SharableType: Sendable {
    var sharable: HKSampleType? { get }
}

public protocol ReadableType: Sendable {
    var readable: HKObjectType { get }
}

public typealias SharableReadableType = SharableType & ReadableType

public enum MBObjectType: SharableReadableType, CaseIterable {

    // Characteristics
    case biologicalSex
    case bloodType
    case dateOfBirth
    case skinType
    case wheelchairUse

    // Duplicates
    case cardioFitness // Mobility & heart
    case sexualActivity // cycle, other
    case respiratoryRate // respiratory, vitals
    case bodyTemperature // body, vitals
    case menstruation // cycle, vitals
    case abdominalCramps // cycle, symptoms
    case bloodGlucose // vitals, other
    case bloodOxygen // respiratory, vitals
    case inhalerUsage // respiratory, other
    case sixMinuteWalk // mobility, respiratory

    // Activity
    case stepCount
    case workout
    case activeEnergy

    // Heart
    case atrialFibrillation
    case heartRate
    case cardioRecovery

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
    case doubleSupportTime
    case groundContactTime
    case runningStrideLength
    case stairSpeedDown
    case stairSpeedUp
    case verticalOscillation
    case walkingAsymmetry
    case walkingSpeed
    case walkingSteadiness
    case walkingStepLength

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

        // Characteristics
        case .biologicalSex: nil
        case .bloodType: nil
        case .dateOfBirth: nil
        case .skinType: nil
        case .wheelchairUse: nil

        // Common
        case .cardioFitness: HKQuantityType(.vo2Max)
        case .sexualActivity: HKCategoryType(.sexualActivity)
        case .respiratoryRate: HKQuantityType(.respiratoryRate)
        case .bodyTemperature: HKQuantityType(.bodyTemperature)
        case .menstruation: HKCategoryType(.menstrualFlow)
        case .abdominalCramps: HKCategoryType(.abdominalCramps)
        case .bloodGlucose: HKQuantityType(.bloodGlucose)
        case .bloodOxygen: HKQuantityType(.oxygenSaturation)
        case .inhalerUsage: HKQuantityType(.inhalerUsage)
        case .sixMinuteWalk: HKQuantityType(.sixMinuteWalkTestDistance)

        // Activity
        case .stepCount: HKQuantityType(.stepCount)
        case .workout: HKWorkoutType.workoutType()
        case .activeEnergy: HKQuantityType(.activeEnergyBurned)

        // Heart
        case .atrialFibrillation: nil
        case .heartRate: HKQuantityType(.heartRate)
        case .cardioRecovery: HKQuantityType(.heartRateRecoveryOneMinute)

        // Body
        case .basalBodyTemperature: HKQuantityType(.basalBodyTemperature)
        case .weight: HKQuantityType(.bodyMass)
        case .electrodermalActivity: HKQuantityType(.electrodermalActivity)
        case .leanBodyMass: HKQuantityType(.leanBodyMass)
        case .height: HKQuantityType(.height)
        case .bodyMassIndex: HKQuantityType(.bodyMassIndex)
        case .bodyFatPercentage: HKQuantityType(.bodyFatPercentage)
        case .waistCircumference: HKQuantityType(.waistCircumference)
        case .wristTemperature: nil

        // Mobility
        case .doubleSupportTime: HKQuantityType(.walkingDoubleSupportPercentage)
        case .groundContactTime: HKQuantityType(.runningGroundContactTime)
        case .runningStrideLength: HKQuantityType(.runningStrideLength)
        case .stairSpeedDown: HKQuantityType(.stairDescentSpeed)
        case .stairSpeedUp: HKQuantityType(.stairAscentSpeed)
        case .verticalOscillation: HKQuantityType(.runningVerticalOscillation)
        case .walkingAsymmetry: nil
        case .walkingSpeed: HKQuantityType(.walkingSpeed)
        case .walkingSteadiness: nil
        case .walkingStepLength: HKQuantityType(.walkingStepLength)

        // Nutrition
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
        case .vitaminB12: HKQuantityType(.dietaryEnergyConsumed)
        case .vitaminC: HKQuantityType(.dietaryVitaminB12)
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
        case .sodium: HKQuantityType(.dietaryPotassium)
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

        // Sleep
        case .sleepAnalysis: HKCategoryType(.sleepAnalysis)

        // Mindful
        case .mindful: HKCategoryType(.mindfulSession)

        // Cycle tracking
        case .bloating: HKCategoryType(.bloating)
        case .breastPain: HKCategoryType(.breastPain)
        case .cervicalMucusQuality: HKCategoryType(.cervicalMucusQuality)
        //case .contraceptives: HKCategoryType(.contraceptive)
        //case .lactation: HKCategoryType(.lactation)
        case .moodChanges: HKCategoryType(.moodChanges)
        case .ovulationTestResult: HKCategoryType(.ovulationTestResult)
        case .pregancyTestResult: HKCategoryType(.pregnancyTestResult)
        case .progesteroneTestResult: HKCategoryType(.progesteroneTestResult)
        case .spotting: HKCategoryType(.intermenstrualBleeding)
        case .vaginalDryness: HKCategoryType(.vaginalDryness)

        // Symptoms
        case .acne: HKCategoryType(.acne)
        case .appetiteChanges: HKCategoryType(.appetiteChanges)
        case .bladderIncontinence: HKCategoryType(.bladderIncontinence)
        case .bodyAndAchePain: HKCategoryType(.generalizedBodyAche)
        case .chills: HKCategoryType(.chills)
        case .chestTightnessOrPain: HKCategoryType(.chestTightnessOrPain)
        case .constipation: HKCategoryType(.constipation)
        case .coughing: HKCategoryType(.coughing)
        case .diarrhea: HKCategoryType(.diarrhea)
        case .dizziness: HKCategoryType(.dizziness)
        case .drySkin: HKCategoryType(.drySkin)
        case .fatigue: HKCategoryType(.fatigue)
        case .fainting: HKCategoryType(.fainting)
        case .fever: HKCategoryType(.fever)
        case .hairLoss: HKCategoryType(.hairLoss)
        case .headache: HKCategoryType(.headache)
        case .heartBurn: HKCategoryType(.heartburn)
        case .hotFlushes: HKCategoryType(.hotFlashes)
        case .lossOfSmell: HKCategoryType(.lossOfSmell)
        case .lossOfTaste: HKCategoryType(.lossOfTaste)
        case .lowerBackPain: HKCategoryType(.lowerBackPain)
        case .memoryLapse: HKCategoryType(.memoryLapse)
        case .nausea: HKCategoryType(.nausea)
        case .nightSweats: HKCategoryType(.nightSweats)
        case .pelvicPain: HKCategoryType(.pelvicPain)
        case .rapidPoundingOrFlutteringHeartbeat: HKCategoryType(.rapidPoundingOrFlutteringHeartbeat)
        case .runnyNose: HKCategoryType(.runnyNose)
        case .shortnessOfBreath: HKCategoryType(.shortnessOfBreath)
        case .skippedHeartbeat: HKCategoryType(.skippedHeartbeat)
        case .sleepChanges: HKCategoryType(.sleepChanges)
        case .soreThroat: HKCategoryType(.soreThroat)
        case .vomiting: HKCategoryType(.vomiting)
        case .wheezing: HKCategoryType(.wheezing)

        // Respiratory
        case .forcedRespiratoryVolume: HKQuantityType(.forcedExpiratoryVolume1)
        case .forcedVitalCapacity: HKQuantityType(.forcedVitalCapacity)
        case .peakExpiratoryFlowRate: HKQuantityType(.peakExpiratoryFlowRate)

        // Vitals
        case .bloodPressureSystolic: HKQuantityType(.bloodPressureSystolic)
        case .bloodPressureDiastolic: HKQuantityType(.bloodPressureDiastolic)

        // Other Data
        case .alcoholConsumption: HKQuantityType(.numberOfAlcoholicBeverages)
        case .alcoholContent: HKQuantityType(.bloodAlcoholContent)
        case .handWashing: HKCategoryType(.handwashingEvent)
        case .insulinDelivery: HKQuantityType(.insulinDelivery)
        case .numberOfTimesFallen: HKQuantityType(.numberOfTimesFallen)
        case .toothBrushing: HKCategoryType(.toothbrushingEvent)
        case .timeInDaylight: HKQuantityType(.timeInDaylight)
        case .uvExposure: HKQuantityType(.uvExposure)
        case .waterTemperature: HKQuantityType(.waterTemperature)
        }
    }
    
    public var readable: HKObjectType {
        switch self {

        // Characteristics
        case .biologicalSex: HKCharacteristicType(.biologicalSex)
        case .bloodType: HKCharacteristicType(.bloodType)
        case .dateOfBirth: HKCharacteristicType(.dateOfBirth)
        case .skinType: HKCharacteristicType(.fitzpatrickSkinType)
        case .wheelchairUse: HKCharacteristicType(.wheelchairUse)

        // Common
        case .cardioFitness: HKQuantityType(.vo2Max)
        case .sexualActivity: HKCategoryType(.sexualActivity)
        case .respiratoryRate: HKQuantityType(.respiratoryRate)
        case .bodyTemperature: HKQuantityType(.bodyTemperature)
        case .menstruation: HKCategoryType(.menstrualFlow)
        case .abdominalCramps: HKCategoryType(.abdominalCramps)
        case .bloodGlucose: HKQuantityType(.bloodGlucose)
        case .bloodOxygen: HKQuantityType(.oxygenSaturation)
        case .inhalerUsage: HKQuantityType(.inhalerUsage)
        case .sixMinuteWalk: HKQuantityType(.sixMinuteWalkTestDistance)

        // Activity
        case .stepCount: HKQuantityType(.stepCount)
        case .workout: HKWorkoutType.workoutType()
        case .activeEnergy: HKQuantityType(.activeEnergyBurned)

        // Heart
        case .atrialFibrillation: HKQuantityType(.atrialFibrillationBurden)
        case .heartRate: HKQuantityType(.heartRate)
        case .cardioRecovery: HKQuantityType(.heartRateRecoveryOneMinute)

        // Body
        case .basalBodyTemperature: HKQuantityType(.basalBodyTemperature)
        case .weight: HKQuantityType(.bodyMass)
        case .electrodermalActivity: HKQuantityType(.electrodermalActivity)
        case .leanBodyMass: HKQuantityType(.leanBodyMass)
        case .height: HKQuantityType(.height)
        case .bodyMassIndex: HKQuantityType(.bodyMassIndex)
        case .bodyFatPercentage: HKQuantityType(.bodyFatPercentage)
        case .waistCircumference: HKQuantityType(.waistCircumference)
        case .wristTemperature: HKQuantityType(.appleSleepingWristTemperature)

        // Mobility
        case .doubleSupportTime: HKQuantityType(.walkingDoubleSupportPercentage)
        case .groundContactTime: HKQuantityType(.runningGroundContactTime)
        case .runningStrideLength: HKQuantityType(.runningStrideLength)
        case .stairSpeedDown: HKQuantityType(.stairDescentSpeed)
        case .stairSpeedUp: HKQuantityType(.stairAscentSpeed)
        case .verticalOscillation: HKQuantityType(.runningVerticalOscillation)
        case .walkingAsymmetry: HKQuantityType(.walkingAsymmetryPercentage)
        case .walkingSpeed: HKQuantityType(.walkingSpeed)
        case .walkingSteadiness: HKQuantityType(.appleWalkingSteadiness)
        case .walkingStepLength: HKQuantityType(.walkingStepLength)

        // Nutrition
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
        case .vitaminB12: HKQuantityType(.dietaryEnergyConsumed)
        case .vitaminC: HKQuantityType(.dietaryVitaminB12)
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
        case .sodium: HKQuantityType(.dietaryPotassium)
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

        // Sleep
        case .sleepAnalysis: HKCategoryType(.sleepAnalysis)

        // Mindful
        case .mindful: HKCategoryType(.mindfulSession)

        // Cycle tracking
        case .bloating: HKCategoryType(.bloating)
        case .breastPain: HKCategoryType(.breastPain)
        case .cervicalMucusQuality: HKCategoryType(.cervicalMucusQuality)
        //case .contraceptives: HKCategoryType(.contraceptive)
        //case .lactation: HKCategoryType(.lactation)
        case .moodChanges: HKCategoryType(.moodChanges)
        case .ovulationTestResult: HKCategoryType(.ovulationTestResult)
        case .pregancyTestResult: HKCategoryType(.pregnancyTestResult)
        case .progesteroneTestResult: HKCategoryType(.progesteroneTestResult)
        case .spotting: HKCategoryType(.intermenstrualBleeding)
        case .vaginalDryness: HKCategoryType(.vaginalDryness)

        // Symptoms
        case .acne: HKCategoryType(.acne)
        case .appetiteChanges: HKCategoryType(.appetiteChanges)
        case .bladderIncontinence: HKCategoryType(.bladderIncontinence)
        case .bodyAndAchePain: HKCategoryType(.generalizedBodyAche)
        case .chills: HKCategoryType(.chills)
        case .chestTightnessOrPain: HKCategoryType(.chestTightnessOrPain)
        case .constipation: HKCategoryType(.constipation)
        case .coughing: HKCategoryType(.coughing)
        case .diarrhea: HKCategoryType(.diarrhea)
        case .dizziness: HKCategoryType(.dizziness)
        case .drySkin: HKCategoryType(.drySkin)
        case .fatigue: HKCategoryType(.fatigue)
        case .fainting: HKCategoryType(.fainting)
        case .fever: HKCategoryType(.fever)
        case .hairLoss: HKCategoryType(.hairLoss)
        case .headache: HKCategoryType(.headache)
        case .heartBurn: HKCategoryType(.heartburn)
        case .hotFlushes: HKCategoryType(.hotFlashes)
        case .lossOfSmell: HKCategoryType(.lossOfSmell)
        case .lossOfTaste: HKCategoryType(.lossOfTaste)
        case .lowerBackPain: HKCategoryType(.lowerBackPain)
        case .memoryLapse: HKCategoryType(.memoryLapse)
        case .nausea: HKCategoryType(.nausea)
        case .nightSweats: HKCategoryType(.nightSweats)
        case .pelvicPain: HKCategoryType(.pelvicPain)
        case .rapidPoundingOrFlutteringHeartbeat: HKCategoryType(.rapidPoundingOrFlutteringHeartbeat)
        case .runnyNose: HKCategoryType(.runnyNose)
        case .shortnessOfBreath: HKCategoryType(.shortnessOfBreath)
        case .skippedHeartbeat: HKCategoryType(.skippedHeartbeat)
        case .sleepChanges: HKCategoryType(.sleepChanges)
        case .soreThroat: HKCategoryType(.soreThroat)
        case .vomiting: HKCategoryType(.vomiting)
        case .wheezing: HKCategoryType(.wheezing)

        // Respiratory
        case .forcedRespiratoryVolume: HKQuantityType(.forcedExpiratoryVolume1)
        case .forcedVitalCapacity: HKQuantityType(.forcedVitalCapacity)
        case .peakExpiratoryFlowRate: HKQuantityType(.peakExpiratoryFlowRate)

        // Vitals
        case .bloodPressureSystolic: HKQuantityType(.bloodPressureSystolic)
        case .bloodPressureDiastolic: HKQuantityType(.bloodPressureDiastolic)

        // Other Data
        case .alcoholConsumption: HKQuantityType(.numberOfAlcoholicBeverages)
        case .alcoholContent: HKQuantityType(.bloodAlcoholContent)
        case .handWashing: HKCategoryType(.handwashingEvent)
        case .insulinDelivery: HKQuantityType(.insulinDelivery)
        case .numberOfTimesFallen: HKQuantityType(.numberOfTimesFallen)
        case .toothBrushing: HKCategoryType(.toothbrushingEvent)
        case .timeInDaylight: HKQuantityType(.timeInDaylight)
        case .uvExposure: HKQuantityType(.uvExposure)
        case .waterTemperature: HKQuantityType(.waterTemperature)
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
