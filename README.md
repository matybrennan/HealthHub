# MBHealthTracker

[![Version](https://img.shields.io/cocoapods/v/MBHealthTracker.svg?style=flat)](http://cocoapods.org/pods/MBHealthTracker)
[![Tag](https://img.shields.io/cocoapods/v/MBHealthTracker.svg?style=flat)](http://cocoapods.org/pods/MBHealthTracker)
[![License](https://img.shields.io/cocoapods/l/MBHealthTracker.svg?style=flat)](http://cocoapods.org/pods/MBHealthTracker)
[![Platform](https://img.shields.io/cocoapods/p/MBHealthTracker.svg?style=flat)](http://cocoapods.org/pods/MBHealthTracker)


<p align="center">
<a href="https://github.com/onevcat/Kingfisher/actions?query=workflow%3Abuild"><img src="https://github.com/onevcat/kingfisher/workflows/build/badge.svg?branch=master"></a>
<a href="https://swiftpackageindex.com/onevcat/Kingfisher/master/documentation/kingfisher"><img src="https://img.shields.io/badge/Swift-Doc-DE5C43.svg?style=flat"></a>
<a href="https://cocoapods.org/pods/Kingfisher"><img src="https://img.shields.io/github/v/tag/onevcat/Kingfisher.svg?color=blue&include_prereleases=&sort=semver"></a>
<a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat"></a>
<a href="https://raw.githubusercontent.com/onevcat/Kingfisher/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-black"></a>
</p>

## Goals

- Make using HealthKit to a project easy.
- Enable easy integration for health data.
- Provide an Open Source project for the iOS open source community.
- Help others learn about HealthKit.

## Installation

MBHealthTracker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
Requires iOS 16.0 and above

```ruby
pod 'MBHealthTracker'
```

MBHealthTracker is available through Swift Package Manager, either via Xcode or in Package.swift:

```ruby
.package(url: "https://github.com/matybrennan/MBHealthTracker", from: "2.2.0"),
```

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
```
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

### Body
- basalBodyTemperature
- bodyFatPercentage
- bodyMassIndex
- bodyTemperature
- height
- electrodermalActivity
- leanBodyMass
- waistCircumference
- weight
- wristTemperature

```var body: BodyServiceProtocol```

### Nutrition
- macronutrients
- minerals
- ultratrace minerals
- vitamins
- hydration
- caffeine

```var nutritionService: NutritionServiceProtocol```

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
- bodyAndMuscleAche
- chestTightnessOrPain
- chills
- congestion
- constipation
- coughing
- diarrhea
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
- nausea
- nightSweats
- pelvicPain
- rapidPoundingOrFlutteringHeartbeat
- runnyNose
- shortnessOfBreath
- skippedHeartbeat
- sleepChanges
- soreThroat
- vomiting
- wheezing

```var symptoms: SymptomsServiceProtocol```

### Respiratory
- respiratoryRate
- forcedExpiratoryVolume
- forcedVitalCapacity
- peakExpiratoryFlowRate

```var respiratory: RespiratoryServiceProtocol```

### Vitals
- bloodPressure
- bloodGlucose
- bloodOxygen
- bodyTemperature
- menstruation
- respiratoryRate

```var vitals: VitalsServiceProtocol```

### Other Data
- alcoholConsumption
- alcoholContent
- handWashing
- inhalerUsage
- insulinDelivery
- numberOfTimesFallen
- sexualActivity
- toothBrushing
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
