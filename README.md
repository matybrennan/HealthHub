# MBHealthTracker

## Goals

- Make using HealthKit to a project easy.
- Enable easy integration for health data.
- Provide an Open Source project for the iOS open source community.
- Help others learn about HealthKit.

## Installation

MBHealthTracker is available through Swift Package Manager, either via Xcode or in Package.swift:

```ruby
.package(url: "https://github.com/matybrennan/MBHealthTracker", from: "2.5.0"),
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

### Sleep
- sleep
- saving sleep item

```var sleep: SleepServiceProtocol```

### Mindfulness
- mindful sessions
- saving mindful item

```var mindful: MindfulnessServiceProtocol```

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
- basalBodyTemperature
- bodyFatPercentage
- bodyMassIndex
- bodyTemperature
- electrodermalActivity
- height
- leanBodyMass
- waistCircumference
- weight
- wristTemperature

```var bodyMeasurements: BodyMeasurementsServiceProtocol```

### Mobility
- cardioFitness
- doubleSupportTime
- groundContactTime
- runningStrideLength
- sixMinuteWalk
- stairSpeedDown
- stairSpeedUp

```var mobility: MobilityServiceProtocol```

### Nutrition
- macronutrients
- minerals
- ultratrace minerals
- vitamins
- hydration
- caffeine

```var nutrition: NutritionServiceProtocol```

### Heart
- heartRate (timeIntervals -> current, today, thisWeek, all, between times)

```var heart: HeartServiceProtocol```

### Cycle Tracking
- abdominalCramps
- bloating
- breastPain
- cervicalMucusQuality
- menstruation
- moodChanges
- ovulation
- pregnancyTestResult
- progesteroneTestResult
- sexualActivity
- spotting
- vaginalDryness

```var cycleTracking: CycleTrackingServiceProtocol```

### Symptoms
- abdominalCramps
- acne        
- appetiteChanges
- bladderIncontinence
- bloating
- bodyAndMuscleAche
- breastPain
- chestTightnessOrPain
- chills
- congestion
- constipation
- coughing
- diarrhea
- dizziness
- drySkin
- fainting
- fatigue
- fever
- hairLoss
- headache
- hotFlushes
- loss of smell
- loss of taste
- lowerBackPain
- memoryLapse
- moodChanges
- nausea
- nightSweats
- pelvicPain
- rapidPoundingOrFlutteringHeartbeat
- runnyNose
- shortnessOfBreath
- skippedHeartbeat
- sleepChanges
- soreThroat
- vaginalDryness
- vomiting
- wheezing

```var symptoms: SymptomsServiceProtocol```

### Respiratory
- bloodOxygen
- forcedExpiratoryVolume
- forcedVitalCapacity
- inhalerUsage
- peakExpiratoryFlowRate
- respiratoryRate
- sixMinuteWalk

```var respiratory: RespiratoryServiceProtocol```

### Vitals
- bloodGlucose
- bloodOxygen
- bloodPressure
- bodyTemperature
- menstruation
- respiratoryRate

```var vitals: VitalsServiceProtocol```

### Other Data
- alcoholConsumption
- bloodAlcoholContent
- bloodGlucose
- handWashing
- inhalerUsage
- insulinDelivery
- numberOfTimesFallen
- sexualActivity
- toothBrushing
- timeInDaylight
- uvExposure
- waterTemperature

```var otherData: OtherDataServiceProtocol```

## Contact

Have a question or an issue about MBHealthTracker? Create an [issue](https://github.com/matybrennan/MBHealthTracker/issues/new)!

Interested in contributing to MBHealthTracker? Branch off and create a PR 

### Apps using this library

Add your app to the list of apps using this library and make a pull request.

- [FitnessKit](https://apps.apple.com/us/app/gym-log-custom-workout-plan/id1445516231)

## License

MBHealthTracker is available under the MIT license.
