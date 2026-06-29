//
//  HealthType.swift
//  HealthHub
//
//  Created by matybrennan on 23/4/18.
//

import Foundation
import HealthKit

public protocol ShareableType: Sendable {
    var sharable: HKSampleType? { get }
}

public protocol ReadableType: Sendable {
    var readable: HKObjectType { get }
}

public typealias ShareableReadableType = ShareableType & ReadableType

public enum HealthObjectType: ShareableReadableType, CaseIterable {

    // Characteristics
    case biologicalSex
    case bloodType
    case dateOfBirth
    case skinType
    case wheelchairUse
    case activityMoveMode

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
    case cyclingDistance
    case walkingRunningDistance
    case swimmingDistance
    case wheelchairDistance
    case downhillSnowSportsDistance
    case crossCountrySkiingDistance
    case crossCountrySkiingSpeed
    case cyclingSpeed
    case runningSpeed
    case cyclingCadence
    case cyclingFunctionalThresholdPower
    case cyclingPower
    case exerciseMinutes
    case restingEnergy
    case standTime
    case moveTime
    case runningPower
    case swimmingStrokeCount
    case flightsClimbed
    case pushCount
    case nikeFuel
    case physicalEffort

    // Heart
    case atrialFibrillation
    case heartRate
    case heartRateVariability
    case highHeartRateEvent
    case irregularHeartRhythmEvent
    case lowHeartRateEvent
    case cardioRecovery
    case peripheralPerfusionIndex
    case restingHeartRate
    case walkingHeartRateAverage

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
    
    
    // Sleep
    case sleepAnalysis
    
    // Mental Wellbeing
    case mindful
    case stateOfMind
    case gad7Assessment
    case phq9Assessment
    
    // Cycle tracking
    case bloating
    case breastPain
    case cervicalMucusQuality
    case contraceptives
    case lactation
    case moodChanges
    case ovulationTestResult
    case pregnancy
    case pregancyTestResult
    case progesteroneTestResult
    case spotting
    case vaginalDryness
    case infrequentMenstrualCycles
    case irregularMenstrualCycles
    case persistentIntermenstrualBleeding
    case prolongedMenstrualPeriods
    
    // Symptoms
    case acne
    case appetiteChanges
    case bladderIncontinence
    case bodyAndAchePain
    case chills
    case chestTightnessOrPain
    case congestion
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

    // Hearing
    case environmentalAudioExposure
    case headphoneAudioExposure
    
    public var sharable: HKSampleType? {
        switch self {

        // Characteristics
        case .biologicalSex: nil
        case .bloodType: nil
        case .dateOfBirth: nil
        case .skinType: nil
        case .wheelchairUse: nil
        case .activityMoveMode: nil

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
        case .cyclingDistance: HKQuantityType(.distanceCycling)
        case .walkingRunningDistance: HKQuantityType(.distanceWalkingRunning)
        case .swimmingDistance: HKQuantityType(.distanceSwimming)
        case .wheelchairDistance: HKQuantityType(.distanceWheelchair)
        case .downhillSnowSportsDistance: HKQuantityType(.distanceDownhillSnowSports)
        case .crossCountrySkiingDistance: HKQuantityType(.distanceCrossCountrySkiing)
        case .crossCountrySkiingSpeed: HKQuantityType(.crossCountrySkiingSpeed)
        case .cyclingSpeed: HKQuantityType(.cyclingSpeed)
        case .runningSpeed: HKQuantityType(.runningSpeed)
        case .cyclingCadence: HKQuantityType(.cyclingCadence)
        case .cyclingFunctionalThresholdPower: HKQuantityType(.cyclingFunctionalThresholdPower)
        case .cyclingPower: HKQuantityType(.cyclingPower)
        case .exerciseMinutes: nil
        case .restingEnergy: HKQuantityType(.basalEnergyBurned)
        case .standTime: nil
        case .moveTime: nil
        case .runningPower: HKQuantityType(.runningPower)
        case .swimmingStrokeCount: HKQuantityType(.swimmingStrokeCount)
        case .flightsClimbed: HKQuantityType(.flightsClimbed)
        case .pushCount: HKQuantityType(.pushCount)
        case .nikeFuel: HKQuantityType(.nikeFuel)
        case .physicalEffort: HKQuantityType(.physicalEffort)

        // Heart
        case .atrialFibrillation: nil
        case .heartRate: HKQuantityType(.heartRate)
        case .heartRateVariability: nil
        case .highHeartRateEvent: nil
        case .irregularHeartRhythmEvent: nil
        case .lowHeartRateEvent: nil
        case .cardioRecovery: HKQuantityType(.heartRateRecoveryOneMinute)
        case .peripheralPerfusionIndex: HKQuantityType(.peripheralPerfusionIndex)
        case .restingHeartRate: nil
        case .walkingHeartRateAverage: nil

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

        // Sleep
        case .sleepAnalysis: HKCategoryType(.sleepAnalysis)

        // Mental Wellbeing
        case .mindful: HKCategoryType(.mindfulSession)
        case .stateOfMind: HKSampleType.stateOfMindType()
        case .gad7Assessment: HKScoredAssessmentType(.GAD7)
        case .phq9Assessment: HKScoredAssessmentType(.PHQ9)

        // Cycle tracking
        case .bloating: HKCategoryType(.bloating)
        case .breastPain: HKCategoryType(.breastPain)
        case .cervicalMucusQuality: HKCategoryType(.cervicalMucusQuality)
        case .contraceptives: HKCategoryType(.contraceptive)
        case .lactation: HKCategoryType(.lactation)
        case .moodChanges: HKCategoryType(.moodChanges)
        case .ovulationTestResult: HKCategoryType(.ovulationTestResult)
        case .pregnancy: HKCategoryType(.pregnancy)
        case .pregancyTestResult: HKCategoryType(.pregnancyTestResult)
        case .progesteroneTestResult: HKCategoryType(.progesteroneTestResult)
        case .spotting: HKCategoryType(.intermenstrualBleeding)
        case .vaginalDryness: HKCategoryType(.vaginalDryness)
        case .infrequentMenstrualCycles: nil
        case .irregularMenstrualCycles: nil
        case .persistentIntermenstrualBleeding: nil
        case .prolongedMenstrualPeriods: nil

        // Symptoms
        case .acne: HKCategoryType(.acne)
        case .appetiteChanges: HKCategoryType(.appetiteChanges)
        case .bladderIncontinence: HKCategoryType(.bladderIncontinence)
        case .bodyAndAchePain: HKCategoryType(.generalizedBodyAche)
        case .chills: HKCategoryType(.chills)
        case .chestTightnessOrPain: HKCategoryType(.chestTightnessOrPain)
        case .congestion: HKCategoryType(.sinusCongestion)
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

        // Hearing
        case .environmentalAudioExposure: HKQuantityType(.environmentalAudioExposure)
        case .headphoneAudioExposure: HKQuantityType(.headphoneAudioExposure)
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
        case .activityMoveMode: HKCharacteristicType(.activityMoveMode)

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
        case .cyclingDistance: HKQuantityType(.distanceCycling)
        case .walkingRunningDistance: HKQuantityType(.distanceWalkingRunning)
        case .swimmingDistance: HKQuantityType(.distanceSwimming)
        case .wheelchairDistance: HKQuantityType(.distanceWheelchair)
        case .downhillSnowSportsDistance: HKQuantityType(.distanceDownhillSnowSports)
        case .crossCountrySkiingDistance: HKQuantityType(.distanceCrossCountrySkiing)
        case .crossCountrySkiingSpeed: HKQuantityType(.crossCountrySkiingSpeed)
        case .cyclingSpeed: HKQuantityType(.cyclingSpeed)
        case .runningSpeed: HKQuantityType(.runningSpeed)
        case .cyclingCadence: HKQuantityType(.cyclingCadence)
        case .cyclingFunctionalThresholdPower: HKQuantityType(.cyclingFunctionalThresholdPower)
        case .cyclingPower: HKQuantityType(.cyclingPower)
        case .exerciseMinutes: HKQuantityType(.appleExerciseTime)
        case .restingEnergy: HKQuantityType(.basalEnergyBurned)
        case .standTime: HKQuantityType(.appleStandTime)
        case .moveTime: HKQuantityType(.appleMoveTime)
        case .runningPower: HKQuantityType(.runningPower)
        case .swimmingStrokeCount: HKQuantityType(.swimmingStrokeCount)
        case .flightsClimbed: HKQuantityType(.flightsClimbed)
        case .pushCount: HKQuantityType(.pushCount)
        case .nikeFuel: HKQuantityType(.nikeFuel)
        case .physicalEffort: HKQuantityType(.physicalEffort)

        // Heart
        case .atrialFibrillation: HKQuantityType(.atrialFibrillationBurden)
        case .heartRate: HKQuantityType(.heartRate)
        case .heartRateVariability: HKQuantityType(.heartRateVariabilitySDNN)
        case .highHeartRateEvent: HKCategoryType(.highHeartRateEvent)
        case .irregularHeartRhythmEvent: HKCategoryType(.irregularHeartRhythmEvent)
        case .lowHeartRateEvent: HKCategoryType(.lowHeartRateEvent)
        case .cardioRecovery: HKQuantityType(.heartRateRecoveryOneMinute)
        case .peripheralPerfusionIndex: HKQuantityType(.peripheralPerfusionIndex)
        case .restingHeartRate: HKQuantityType(.restingHeartRate)
        case .walkingHeartRateAverage: HKQuantityType(.walkingHeartRateAverage)

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

        // Sleep
        case .sleepAnalysis: HKCategoryType(.sleepAnalysis)

        // Mental Wellbeing
        case .mindful: HKCategoryType(.mindfulSession)
        case .stateOfMind: HKSampleType.stateOfMindType()
        case .gad7Assessment: HKScoredAssessmentType(.GAD7)
        case .phq9Assessment: HKScoredAssessmentType(.PHQ9)

        // Cycle tracking
        case .bloating: HKCategoryType(.bloating)
        case .breastPain: HKCategoryType(.breastPain)
        case .cervicalMucusQuality: HKCategoryType(.cervicalMucusQuality)
        case .contraceptives: HKCategoryType(.contraceptive)
        case .lactation: HKCategoryType(.lactation)
        case .moodChanges: HKCategoryType(.moodChanges)
        case .ovulationTestResult: HKCategoryType(.ovulationTestResult)
        case .pregnancy: HKCategoryType(.pregnancy)
        case .pregancyTestResult: HKCategoryType(.pregnancyTestResult)
        case .progesteroneTestResult: HKCategoryType(.progesteroneTestResult)
        case .spotting: HKCategoryType(.intermenstrualBleeding)
        case .vaginalDryness: HKCategoryType(.vaginalDryness)
        case .infrequentMenstrualCycles: HKCategoryType(.infrequentMenstrualCycles)
        case .irregularMenstrualCycles: HKCategoryType(.irregularMenstrualCycles)
        case .persistentIntermenstrualBleeding: HKCategoryType(.persistentIntermenstrualBleeding)
        case .prolongedMenstrualPeriods: HKCategoryType(.prolongedMenstrualPeriods)

        // Symptoms
        case .acne: HKCategoryType(.acne)
        case .appetiteChanges: HKCategoryType(.appetiteChanges)
        case .bladderIncontinence: HKCategoryType(.bladderIncontinence)
        case .bodyAndAchePain: HKCategoryType(.generalizedBodyAche)
        case .chills: HKCategoryType(.chills)
        case .chestTightnessOrPain: HKCategoryType(.chestTightnessOrPain)
        case .congestion: HKCategoryType(.sinusCongestion)
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

        // Hearing
        case .environmentalAudioExposure: HKQuantityType(.environmentalAudioExposure)
        case .headphoneAudioExposure: HKQuantityType(.headphoneAudioExposure)
        }
    }
}

public enum HealthType {
    
    public static func shareTypes(from types: [ShareableType]) -> Set<HKSampleType> {
        Set(types.compactMap(\.sharable))
    }
    
    public static func readTypes(_ types: [ReadableType]) -> Set<HKObjectType> {
        Set(types.map(\.readable))
    }
}
