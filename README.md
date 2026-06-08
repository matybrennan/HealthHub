# 🏥 HealthHub

[![Swift](https://img.shields.io/badge/Swift-6.2-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS_26+-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![SPM](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg)](https://swift.org/package-manager/)

A modern Swift library that makes HealthKit integration simple, testable, and elegant. Read and write health data with protocol-driven architecture and full dependency injection support.

---

## ✨ Features

- 🏃 **Activity** — Steps, workouts, active energy, cycling, running, swimming & more
- ❤️ **Heart** — Heart rate, HRV, AFib, blood pressure, cardio fitness
- 🧘 **Mental Wellbeing** — Mindfulness, sleep, time in daylight
- 🫁 **Respiratory** — Blood oxygen, respiratory rate, forced vital capacity
- 🍎 **Nutrition** — Macronutrients, vitamins, minerals, hydration, caffeine
- 🏋️ **Body** — Weight, BMI, body fat, height, temperature
- 🩺 **Vitals** — Blood glucose, blood pressure, body temperature
- 🔬 **Other Data** — Alcohol, hand washing, UV exposure, insulin & more
- 🧬 **Characteristics** — Biological sex, blood type, DOB, skin type
- 🚴 **Mobility** — Walking steadiness, stair speed, stride length
- 🩸 **Cycle Tracking** — Menstruation, ovulation, symptoms
- 🤒 **Symptoms** — 35+ symptom types

---

## 📦 Installation

### Swift Package Manager

Add HealthHub to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/matybrennan/HealthHub", from: "3.2.0")
]
```

Or add it via Xcode: **File → Add Package Dependencies** → paste the URL above.

> ⚠️ **Requires iOS 26+** (Package version 3.2.0 and above)

---

## 🚀 Getting Started

### 1. Enable HealthKit Capability

In your Xcode project, go to **Signing & Capabilities** → **+ Capability** → **HealthKit**

### 2. Add Info.plist Keys

```xml
<key>NSHealthShareUsageDescription</key>
<string>We need access to read your health data</string>
<key>NSHealthUpdateUsageDescription</key>
<string>We need access to write health data</string>
```

### 3. Request Authorization

```swift
import HealthHub

let hub = HealthHubManager()

// Request access to read/write specific data types
try await hub.configuration.requestAuthorization(
    toShare: [.stepCount, .workout],
    toRead: [.stepCount, .heartRate, .workout]
)
```

---

## 🏗️ Architecture

HealthHub uses a **protocol-driven, dependency-injectable architecture** that makes testing easy:

```
HealthHubManager (facade)
├── ConfigurationService
├── ActivityManager
│   ├── ActiveEnergyService
│   ├── StepsService
│   ├── WorkoutManager
│   │   ├── WorkoutReadService
│   │   └── WorkoutWriteService
│   └── ActivityService
├── HeartManager
│   └── HeartRateService
├── BodyMeasurementsService
├── MobilityService
├── NutritionService
├── SleepService
├── MentalWellbeingService
├── CycleTracking
├── SymptomsService
├── RespiratoryService
├── VitalsService
└── OtherDataService
```

Every layer is backed by protocols and supports dependency injection:

```swift
// Production — uses default concrete implementations
let hub = HealthHubManager()

// Testing — inject mocks at any level
let hub = HealthHubManager(
    configuration: MockConfigurationService(),
    activityManager: MockActivityManager(),
    heartManager: MockHeartManager(),
    // ... inject what you need
)
```

---

## 📖 Usage

### Using the Main Manager

```swift
let hub = HealthHubManager()

// Access any service through the manager
let workouts = try await hub.activityManager.workout.workouts(fromWorkoutType: .today)
let heartRate = hub.activityManager.steps
```

### Using Individual Services

If you only need a specific service, inject it directly:

```swift
let workoutManager = WorkoutManager(
    readService: WorkoutReadService(),
    writeService: WorkoutWriteService()
)
let todayWorkouts = try await workoutManager.workouts(fromWorkoutType: .today)
```

---

## 📚 API Reference

### Configuration

| Method | Description |
|--------|-------------|
| `requestAuthorization(toShare:toRead:)` | Request HealthKit permissions |
| `navigateToHealthSettings()` | Open the Health app settings |

```swift
var configuration: ConfigurationServiceProtocol
```

---

### Characteristics

| Data | Description |
|------|-------------|
| `biologicalSex` | Biological sex |
| `bloodType` | Blood type |
| `dateOfBirth` | Date of birth |
| `skinType` | Fitzpatrick skin type |
| `isWheelChairUser` | Wheelchair use status |

```swift
var characteristics: CharacteristicServiceProtocol
```

---

### Activity Manager

Access via `hub.activityManager` or use `ActivityManager()` directly.

#### Active Energy

Retrieve calories burned by time period.

```swift
let energy = try await hub.activityManager.activeEnergy.activeEnergy(from: .today)
print("Burned: \(energy.calories) kcal")
```

| Query Type | Description |
|-----------|-------------|
| `.today` | Today's active energy |
| `.thisWeek` | This week's active energy |
| `.betweenTimePref(start:end:)` | Custom date range |

#### Steps

Retrieve step counts with observable state.

```swift
try hub.activityManager.steps.steps(fromStepsType: .today(timeInterval: 1))
// Access results via published properties
let todaySteps = hub.activityManager.steps.today
```

| Query Type | Description |
|-----------|-------------|
| `.lastHour` | Steps in the last hour |
| `.today(timeInterval:)` | Today's steps in hourly batches |
| `.thisWeek(timeInterval:)` | This week's steps in daily batches |
| `.betweenTimePreference(start:end:)` | Custom date range |

#### Workouts

Read and save workouts with full detail support including routes, heart rate, and events.

```swift
// Fetch workouts
let workouts = try await hub.activityManager.workout.workouts(fromWorkoutType: .thisWeek)

// Fetch detailed workout info (route, HR, events)
let detail = try await hub.activityManager.workout.workoutDetail(
    for: workout.startDate,
    endDate: workout.endDate
)

// Save a workout with associated data
try await hub.activityManager.workout.saveWorkout(
    workout: workoutItem,
    events: lapEvents,
    routeLocations: gpsLocations,
    heartRateSamples: hrSamples,
    extra: nil
)
```

| Query Type | Description |
|-----------|-------------|
| `.today` | Today's workouts |
| `.thisWeek` | This week's workouts |
| `.all` | All workouts |
| `.betweenTimePreference(start:end:)` | Custom date range |
| `.byActivityType(HKWorkoutActivityType)` | Filter by sport |

| Detail Methods | Description |
|---------------|-------------|
| `workoutRoute(for:endDate:)` | GPS route data |
| `workoutHeartRate(for:endDate:)` | Heart rate during workout |
| `workoutEvents(for:endDate:)` | Laps, pauses, segments |
| `workoutDetail(for:endDate:)` | Combined rich detail |

#### Activity Service

All other Apple Health activity data types — cycling distance/speed/power, running metrics, swimming, skiing, and more.

```swift
var activity: ActivityServiceProtocol
```

<details>
<summary>View all activity data types</summary>

- crossCountrySkiingDistance & save
- crossCountrySkiingSpeed & save
- cyclingCadence & save
- cyclingDistance & save
- cyclingFunctionalThresholdPower & save
- cyclingPower & save
- cyclingSpeed & save
- downhillSnowSportsDistance & save
- exerciseMinutes
- flightsClimbed & save
- moveTime
- nikeFuel & save
- physicalEffort & save
- pushCount & save
- restingEnergy & save
- runningPower & save
- runningSpeed & save
- standTime
- swimmingDistance & save
- swimmingStrokeCount & save
- walkingRunningDistance & save
- wheelchairDistance & save

</details>

---

### Heart Manager

Access via `hub.heartManager` or use `HeartManager()` directly.

```swift
let afib = try await hub.heartManager.atrialFibrillation()
let bp = try await hub.heartManager.bloodPressure()
```

| Data | Saveable |
|------|----------|
| Heart Rate (real-time, observable) | — |
| Atrial Fibrillation | — |
| Blood Pressure | ✅ |
| Cardio Fitness (VO2 Max) | ✅ |
| Cardio Recovery | ✅ |
| Heart Rate Variability | — |
| High Heart Rate Events | — |
| Irregular Heart Rhythm Events | — |
| Low Heart Rate Events | — |
| Peripheral Perfusion Index | ✅ |
| Resting Heart Rate | — |
| Walking Heart Rate Average | — |

#### Heart Rate (Observable)

```swift
try hub.heartManager.heartRate.heartRate(fromHeartRateType: .current)
// Access via published properties
let current = hub.heartManager.heartRate.current
```

---

### Body Measurements

```swift
let weight = try await hub.bodyMeasurements.weight()
try await hub.bodyMeasurements.saveWeight(model: weightModel, extra: nil)
```

| Data | Saveable |
|------|----------|
| Basal Body Temperature | ✅ |
| Body Fat Percentage | ✅ |
| Body Mass Index | ✅ |
| Body Temperature | ✅ |
| Electrodermal Activity | ✅ |
| Height | ✅ |
| Lean Body Mass | ✅ |
| Waist Circumference | ✅ |
| Weight | ✅ |
| Wrist Temperature | — |

---

### Mental Wellbeing

| Data | Saveable |
|------|----------|
| Mindful Activity | ✅ |
| Sleep | ✅ |
| Time in Daylight | ✅ |

---

### Mobility

| Data | Saveable |
|------|----------|
| Cardio Fitness | ✅ |
| Double Support Time | ✅ |
| Ground Contact Time | ✅ |
| Running Stride Length | ✅ |
| Six Minute Walk | ✅ |
| Stair Speed Down | ✅ |
| Stair Speed Up | ✅ |
| Vertical Oscillation | ✅ |
| Walking Asymmetry | — |
| Walking Speed | ✅ |
| Walking Steadiness | — |
| Walking Step Length | ✅ |

---

### Nutrition

Query and save 50+ nutrition data types organized by category:

```swift
let protein = try await hub.nutrition.nutrition(.macronutrients(.protein))
try await hub.nutrition.saveNutrition(model: proteinModel, extra: nil)
```

**Categories:** Macronutrients, Minerals, Ultratrace Minerals, Vitamins, Hydration, Caffeine

---

### Respiratory

| Data | Saveable |
|------|----------|
| Blood Oxygen | ✅ |
| Forced Expiratory Volume | ✅ |
| Forced Vital Capacity | ✅ |
| Inhaler Usage | ✅ |
| Peak Expiratory Flow Rate | ✅ |
| Respiratory Rate | ✅ |
| Six Minute Walk | ✅ |

---

### Sleep

```swift
let sleep = try await hub.sleep.sleep()
try await hub.sleep.saveSleep(model: sleepModel, extra: nil)
```

---

### Cycle Tracking

| Data | Saveable |
|------|----------|
| Abdominal Cramps | ✅ |
| Bloating | ✅ |
| Breast Pain | ✅ |
| Cervical Mucus Quality | ✅ |
| Menstruation | ✅ |
| Mood Changes | ✅ |
| Ovulation | ✅ |
| Pregnancy Test Result | ✅ |
| Progesterone Test Result | ✅ |
| Sexual Activity | ✅ |
| Spotting | ✅ |
| Vaginal Dryness | ✅ |

---

### Symptoms

35+ symptom types — all readable and saveable:

```swift
let headaches = try await hub.symptoms.symptom(.headache)
try await hub.symptoms.saveSymptom(model: headacheModel, extra: nil)
```

<details>
<summary>View all symptom types</summary>

abdominalCramps, acne, bladderIncontinence, bloating, bodyAndMuscleAche, breastPain, chestTightnessOrPain, chills, congestion, constipation, coughing, diarrhea, dizziness, drySkin, fainting, fatigue, fever, hairLoss, headache, hotFlushes, lossOfSmell, lossOfTaste, lowerBackPain, memoryLapse, moodChanges, nausea, nightSweats, pelvicPain, rapidPoundingOrFlutteringHeartbeat, runnyNose, shortnessOfBreath, skippedHeartbeat, sleepChanges, soreThroat, vaginalDryness, vomiting, wheezing

</details>

---

### Vitals

| Data | Saveable |
|------|----------|
| Blood Glucose | ✅ |
| Blood Oxygen | ✅ |
| Blood Pressure | ✅ |
| Body Temperature | ✅ |
| Menstruation | ✅ |
| Respiratory Rate | ✅ |

---

### Other Data

| Data | Saveable |
|------|----------|
| Alcohol Consumption | ✅ |
| Blood Alcohol Content | ✅ |
| Blood Glucose | ✅ |
| Hand Washing | ✅ |
| Inhaler Usage | ✅ |
| Insulin Delivery | ✅ |
| Number of Times Fallen | ✅ |
| Sexual Activity | ✅ |
| Tooth Brushing | ✅ |
| Time in Daylight | ✅ |
| UV Exposure | ✅ |
| Water Temperature | ✅ |

---

## 🧪 Testing

HealthHub is designed for testability. Every service uses protocols, and managers accept injected dependencies:

```swift
import Testing
@testable import HealthHub

@Suite("Workout Tests")
struct WorkoutTests {

    @Test("Fetches today's workouts")
    func fetchWorkouts() async throws {
        let mockRead = MockWorkoutReadService()
        mockRead.stubbedWorkouts = Workout(items: [
            .init(duration: 3600, energyBurned: 500, startDate: .now, endDate: .now, activityType: .running)
        ])

        let manager = WorkoutManager(readService: mockRead, writeService: MockWorkoutWriteService())
        let result = try await manager.workouts(fromWorkoutType: .today)

        #expect(result.items.count == 1)
        #expect(result.items[0].activityType == .running)
    }
}
```

---

## 🤝 Contributing

Have a question or found a bug? Create an [issue](https://github.com/matybrennan/HealthHub/issues/new)!

Want to contribute? Fork the repo, branch off `main`, and open a PR.

---

## 📱 Apps Using HealthHub

- [FitnessKit](https://apps.apple.com/us/app/gym-log-custom-workout-plan/id1445516231)

*Using HealthHub in your app? Open a PR to add it here!*

---

## 📄 License

HealthHub is available under the [MIT License](LICENSE).
