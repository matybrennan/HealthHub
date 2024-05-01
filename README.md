# MBHealthTracker

## Goals

- Make using HealthKit to a project easy.
- Enable easy integration for health data.
- Provide an Open Source project for the iOS open source community.
- Help others learn about HealthKit.

## Installation

MBHealthTracker is available through Swift Package Manager, either via Xcode or in Package.swift:

```ruby
.package(url: "https://github.com/matybrennan/MBHealthTracker", from: "2.7.0"),
```

Package version "2.4.0" and above requires iOS17 and above in project

## Getting Started

### Configuration for HealthKit
Add health kit in capabilities through project in "Capabilities"

Add below code to your info.plist
```
<key>NSHealthShareUsageDescription</key>
<string>Health want to read your health data</string>
<key>NSHealthUpdateUsageDescription</key>
<string>Health wants to write your progress to health store</string>
```

### Guide

The main driver that contains all the business logic is ```MBHealthTracker``` which can be injected into your services with  ```MBHealthTrackerProtocol```

The ```MBHealthTracker``` contains all the services below
``` 
@StateObject private var healthTracker = MBHealthTracker()

or 

let tracker = MBHealthTracker()
let configuration = tracker.configuration
```

Alternatively is you just need a single service you could just inject the protocol needed

```
let configuration = ConfigurationService()
MyService -> init(configuration: ConfigurationServiceProtocol)
let myService = MyService(configuration: configuration)
```

### Configuration 
- requestingAuthorization
- presenting healthKit app

```var configuration: ConfigurationServiceProtocol```

### Handlers - These can only be accessed directly from ```MBHealthTracker```
```
let tracker = MBHealthTracker()
tracker.mbHealthHandler.state = .idle
tracker.mbHealthHandler.$state.sink { state in ... }
mbHealthHandler = MBHealthHandler()
```

### Characteristics
- biologicalSex
- bloodType
- dateOfBirth
- skinType
- isWheelChairUser

```var characteristics: CharacteristicServiceProtocol```

------------------------------------------------------------------------

### ActivityManager
The ```ActivityManager``` contains all the services below and can be injected into your services with  ```ActivityManagerProtocol``` if you just need this service
``` 
let activityManager = ActivityManager()
let activeEnergy = activityManager.activeEnergy
```
or using MBHealthTracker
``` 
let tracker = MBHealthTracker()
let activeEnergy = tracker.activityManager.activeEnergy
```
    
#### ActiveEnergy
Split into sections to gather data based on timeIntervals
- today, thisWeek, betweenTime

```var activeEnergy: ActiveEnergyServiceProtocol```
    
#### Steps
Split into sections to gather data based on timeIntervals
- last hour, today, thisWeek, betweenTime

```var steps: StepsServiceProtocol```

#### Workouts
- saveWorkoutItem
- workouts
- today, thisWeek, all

```var workout: WorkoutManagerProtocol```

------------------------------------------------------------------------

### Body Measurements
- basalBodyTemperature & saveBasalBodyTemperature(_: model, _:extra)
- bodyFatPercentage & saveBodyFatPercentage(_: model, _:extra)
- bodyMassIndex & saveBodyMassIndex(_: model, _:extra)
- bodyTemperature & saBeBodyTemperature(_: model, _:extra)
- electrodermalActivity & saveElectrodermalActivity(_: model, _:extra)
- height & saveHeight(_: model, _:extra)
- leanBodyMass & saveLeanBodyMass(_: model, _:extra)
- waistCircumference & saveWaistCircumference(_: model, _:extra)
- weight & saveweight(_: model, _:extra)
- wristTemperature

```var bodyMeasurements: BodyMeasurementsServiceProtocol```

------------------------------------------------------------------------

### Cycle Tracking
- abdominalCramps & saveAbdominalCramps(_: model, _:extra)
- bloating & saveBloating(_: model, _:extra)
- breastPain & saveBreastPain(_: model, _:extra)
- cervicalMucusQuality & saveCervicalMucusQuality(_: model, _:extra)
- menstruation & saveMenstruation(_: model, _:extra)
- moodChanges & saveMoodChanges(_: model, _:extra)
- ovulation & saveOvulation(_: model, _:extra)
- pregnancyTestResult & savePregnancyTestResult(_: model, _:extra)
- progesteroneTestResult & saveProgesteroneTestResult(_: model, _:extra)
- sexualActivity & saveSexualActivity(_: model, _:extra)
- spotting & saveSpotting(_: model, _:extra)
- vaginalDryness & saveVaginalDryness(_: model, _:extra)

```var cycleTracking: CycleTrackingServiceProtocol```

------------------------------------------------------------------------

### Heart
- atrialFibrillation
- bloodPressure & saveBloodPressure(_: model, _:extra)
- cardioFitness & saveCardioFitness(_: model, _:extra)
- cardioRecovery & saveCardioRecovery(_: model, _:extra)
- heartRate (timeIntervals -> current, today, thisWeek, all, between times)

```var heart: HeartServiceProtocol```

------------------------------------------------------------------------

### MentalWellbeing
- mindfulActivity & saveMindful(_: model, _:extra)
- sleep & saveSleep(_: model, _:extra)
- timeInDaylight & saveTimeInDaylight(_: model, _:extra)

```var mentalWellbeing: MentalWellbeingServiceProtocol```
    
------------------------------------------------------------------------

### Mobility
- cardioFitness & saveCardioFitness(_: model, _:extra)
- doubleSupportTime & saveDoubleSupportTime(_: model, _:extra)
- groundContactTime & saveGroundContactTime(_: model, _:extra)
- runningStrideLength & saveRunningStrideLength(_: model, _:extra)
- sixMinuteWalk & saveSixMinuteWalk(_: model, _:extra)
- stairSpeedDown & saveStairSpeedDown(_: model, _:extra)
- stairSpeedUp & saveStairSpeedUp(_: model, _:extra)
- verticalOscillation & saveVerticalOscillation(_: model, _:extra)
- walkingAsymmetry
- walkingSpeed & saveWalkingSpeed(_: model)
- walkingSteadiness
- walkingStepLength & saveWalkingStepLength(_: model)

```var mobility: MobilityServiceProtocol```

------------------------------------------------------------------------

### Nutrition
- nutrition(_ :type) & saveNutrition(_: model, _:extra)

Types vary based on:
- macronutrients
- minerals
- ultratrace minerals
- vitamins
- hydration
- caffeine

```var nutrition: NutritionServiceProtocol```

------------------------------------------------------------------------

### Respiratory
- bloodOxygen & saveBloodOxygen(_: model, _:extra)
- forcedExpiratoryVolume & saveForcedExpiratoryVolume(_: model, _:extra)
- forcedVitalCapacity & saveForcedVitalCapacity(_: model, _:extra)
- inhalerUsage & saveInhalerUsage(_: model, _:extra)
- peakExpiratoryFlowRate & savePeakExpiratoryFlowRate(_: model, _:extra)
- respiratoryRate & saveRespiratoryRate(_: model, _:extra)
- sixMinuteWalk & saveSixMinuteWalk(_: model, _:extra)

```var respiratory: RespiratoryServiceProtocol```

------------------------------------------------------------------------

### Sleep
- sleep & saveSleep(_: model, _:extra)

```var sleep: SleepServiceProtocol```

------------------------------------------------------------------------

### Symptoms
- appetiteChanges & saveAppetiteChanges(_: model, _:extra)
- symptom(_: type) & saveSymptom(_: model, _:extra)

Symptom types include:
- abdominalCramps, acne, bladderIncontinence, bloating, bodyAndMuscleAche, breastPain, 
chestTightnessOrPain, chills, congestion, constipation, coughing, diarrhea, dizziness,
drySkin, fainting, fatigue, fever, hairLoss, headache, hotFlushes, loss of smell, 
loss of taste, lowerBackPain, memoryLapse, moodChanges, nausea, nightSweats, pelvicPain,
rapidPoundingOrFlutteringHeartbeat, runnyNose, shortnessOfBreath, skippedHeartbeat, 
sleepChanges, soreThroat, vaginalDryness, vomiting, wheezing

```var symptoms: SymptomsServiceProtocol```

------------------------------------------------------------------------

### Vitals
- bloodGlucose & saveBloodGlucose(_: model, _:extra)
- bloodOxygen & saveBloodOxygen(_: model, _:extra)
- bloodPressure & saveBloodPressure(_: model, _:extra)
- bodyTemperature & saveBodyTemperature_: model, _:extra)
- menstruation & saveMenstruation(_: model, _:extra)
- respiratoryRate & saveRespiratoryRate(_: model, _:extra)

```var vitals: VitalsServiceProtocol```

------------------------------------------------------------------------

### Other Data
- alcoholConsumption & saveAlcoholConsumption(_: model, _:extra)
- bloodAlcoholContent & saveBloodAlcoholContent(_: model, _:extra)
- bloodGlucose & saveBloodGlucose(_: model, _:extra)
- handWashing & saveHandWashing(_: model, _:extra)
- inhalerUsage & saveInhalerUsage(_: model, _:extra)
- insulinDelivery & saveInsulinDelivery(_: model, _:extra)
- numberOfTimesFallen & saveNumberOfTimesFallen(_: model, _:extra)
- sexualActivity & saveSexualActivity(_: model, _:extra)
- toothBrushing & saveToothBrushing(_: model, _:extra)
- timeInDaylight & saveTimeInDaylight(_: model, _:extra)
- uvExposure & saveUvExposure(_: model, _:extra)
- waterTemperature & saveWaterTemperature(_: model, _:extra)

```var otherData: OtherDataServiceProtocol```

------------------------------------------------------------------------

## Contact

Have a question or an issue about MBHealthTracker? Create an [issue](https://github.com/matybrennan/MBHealthTracker/issues/new)!

Interested in contributing to MBHealthTracker? Branch off and create a PR 

### Apps using this library

Add your app to the list of apps using this library and make a pull request.

- [FitnessKit](https://apps.apple.com/us/app/gym-log-custom-workout-plan/id1445516231)

## License

MBHealthTracker is available under the MIT license.
