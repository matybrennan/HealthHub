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
- 🧘 **Mental Wellbeing** — Mindfulness, state of mind, GAD-7, PHQ-9, sleep, daylight
- 🫁 **Respiratory** — Blood oxygen, respiratory rate, forced vital capacity
- 🍎 **Nutrition** — Macronutrients, vitamins, minerals, hydration, caffeine
- 🏋️ **Body** — Weight, BMI, body fat, height, temperature
- 🩺 **Vitals** — Blood glucose, blood pressure, body temperature
- 🔬 **Other Data** — Alcohol, hand washing, UV exposure, insulin, hearing & more
- 🧬 **Characteristics** — Biological sex, blood type, DOB, skin type
- 🚴 **Mobility** — Walking steadiness, stair speed, stride length
- 🩸 **Cycle Tracking** — Menstruation, ovulation, contraceptives, pregnancy, lactation, cycle notifications
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

| Method / Property | Description |
|--------|-------------|
| `requestAuthorization(toShare:toRead:)` | Request HealthKit permissions |
| `authorizationStatus(for:)` | Check read authorization status for a type |
| `sharingAuthorizationStatus(for:)` | Check write authorization status for a type |
| `isHealthDataAvailable` | Whether HealthKit is available on device |
| `state` | Observable authorization state (`.idle` / `.hasRequestedHealthKitInfo`) |
| `navigateToHealthSettings()` | Open the Apple Health app |

```swift
var configuration: ConfigurationServiceProtocol

// Check availability before requesting
guard hub.configuration.isHealthDataAvailable else { return }

// Request authorization
try await hub.configuration.requestAuthorization(
    toShare: [.stepCount, .workout],
    toRead: [.stepCount, .heartRate, .workout]
)

// Check individual type status
let status = hub.configuration.authorizationStatus(for: HealthObjectType.heartRate)
```

---

### Characteristics

All HealthKit user profile characteristics with strongly-typed enums:

```swift
let sex = hub.characteristics.biologicalSex
print(sex.name) // "Female", "Male", "Other"

let blood = hub.characteristics.bloodType
print(blood.name) // "A+", "O-", etc.

let skin = hub.characteristics.skinType
print(skin.name) // "Type III — Darker white skin"
print(skin.uvSensitivity) // "Moderate, sometimes burns"

let moveMode = hub.characteristics.activityMoveMode
print(moveMode.name) // "Active Energy" or "Move Time"
```

| Property | Return Type | Description |
|----------|-------------|-------------|
| `biologicalSex` | `BiologicalSex` | Female, Male, Other, Not Set |
| `bloodType` | `BloodType` | A±, B±, AB±, O±, Not Set |
| `dateOfBirth` | `DateComponents?` | Date of birth components |
| `skinType` | `FitzpatrickSkinType` | Types I–VI with UV sensitivity |
| `isWheelChairUser` | `WheelchairUse` | Yes, No, Not Set |
| `activityMoveMode` | `ActivityMoveMode` | Active Energy or Move Time |

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

Full mental health tracking with State of Mind, anxiety/depression screenings, mindfulness, and sleep:

| Data | Unit | Saveable |
|------|------|----------|
| Mindful Minutes | min | ✅ |
| State of Mind | valence (-1 to +1) | ✅ |
| GAD-7 (Anxiety) | score (0–21) | ✅ |
| PHQ-9 (Depression) | score (0–27) | ✅ |
| Sleep | hr | ✅ |
| Time in Daylight | min | ✅ |

**Features:**
- `MentalWellbeingType` enum with `displayName` and `unit`
- **State of Mind** — 38 emotion labels, 18 life associations, valence classification (Very Unpleasant → Very Pleasant), momentary emotion vs daily mood
- **GAD-7** — 7-question anxiety screening with risk levels (None to Minimal, Mild, Moderate, Severe)
- **PHQ-9** — 9-question depression screening with risk levels (None to Minimal → Severe)
- `Mindful.totalMinutes`, `averageMinutes`, `mostRecent`
- `StateOfMindEntry.averageValence`, `emotions`, `moods` filters
- Sort descriptors (newest first) on all queries

---

### Mobility

Full mobility and gait analysis with correct HealthKit identifiers and clinical classification:

| Data | Unit | Saveable |
|------|------|----------|
| Cardio Fitness (VO₂ Max) | mL/kg·min | ✅ |
| Double Support Time | % | ✅ |
| Ground Contact Time | ms | ✅ |
| Running Stride Length | m | ✅ |
| Six-Minute Walk | m | ✅ |
| Stair Speed: Down | m/s | ✅ |
| Stair Speed: Up | m/s | ✅ |
| Vertical Oscillation | cm | ✅ |
| Walking Asymmetry | % | — |
| Walking Speed | km/hr | ✅ |
| Walking Steadiness | % | — |
| Walking Step Length | cm | ✅ |

**Features:**
- `MobilityType` enum with `displayName`, `unit`, and `isSaveable` flag
- `WalkingSteadiness.Classification` — Apple's OK/Low/Very Low classification
- `mostRecent` and averaging computed properties on all models
- Sort descriptors (newest first) on all queries
- Consistent `startDate`/`endDate` on all models

---

### Nutrition

Query and save all HealthKit nutrition data types, organized by category with full metadata:

```swift
let protein = try await hub.nutrition.nutrition(type: .protein)
print("\(protein.displayName): \(protein.items.first?.value ?? 0) \(protein.items.first?.unit ?? "")")
print("Category: \(protein.category.rawValue)")

// Save nutrition data
try await hub.nutrition.save(model: proteinModel, extra: nil)
```

Results are sorted by date (most recent first) and include both start/end dates for accurate time-range tracking.

**Categories & Types:**

| Category | Types |
|----------|-------|
| Macronutrients | Energy Consumed, Carbohydrates, Fiber, Sugar, Total Fat, Monounsaturated Fat, Polyunsaturated Fat, Saturated Fat, Cholesterol, Protein |
| Vitamins | A, Thiamin (B1), Riboflavin (B2), Niacin (B3), Pantothenic Acid (B5), B6, Biotin (B7), B12, C, D, E, K, Folate |
| Minerals | Calcium, Chloride, Iron, Magnesium, Phosphorus, Potassium, Sodium, Zinc |
| Ultratrace Minerals | Chromium, Copper, Iodine, Manganese, Molybdenum, Selenium |
| Hydration | Water |
| Caffeine | Caffeine |

`NutritionType` conforms to `CaseIterable` for easy enumeration of all types.

---

### Respiratory

Full respiratory health tracking with clinical ratio analysis:

| Data | Unit | Saveable |
|------|------|----------|
| Blood Oxygen | % | ✅ |
| Forced Expiratory Volume (FEV1) | L | ✅ |
| Forced Vital Capacity (FVC) | L | ✅ |
| Inhaler Usage | uses | ✅ |
| Peak Expiratory Flow Rate | L/min | ✅ |
| Respiratory Rate | breaths/min | ✅ |
| Six Minute Walk | m | ✅ |

**Features:**
- `RespiratoryType` enum with `displayName` and `unit` for all types
- `FEV1FVCRatio` struct with clinical classification (Normal ≥0.70, Mild/Moderate/Severe/Very Severe obstruction per ATS/ERS)
- `mostRecent` on all models
- Sort descriptors (newest first) on all queries
- Consistent `startDate`/`endDate` on all models

---

### Sleep

Full sleep analysis with individual stage tracking, computed durations, and session grouping:

```swift
let sleep = try await hub.sleep.sleep()

// Per-stage durations
print("Core: \(sleep.coreSleepDuration / 60) min")
print("Deep: \(sleep.deepSleepDuration / 60) min")
print("REM: \(sleep.remSleepDuration / 60) min")

// Sleep efficiency (percentage of in-bed time spent asleep)
print("Efficiency: \(Int(sleep.sleepEfficiency * 100))%")

// Group into nightly sessions (splits on 2-hour gaps by default)
let sessions = sleep.sessions()
for session in sessions {
    print("\(session.startDate) — \(session.totalSleepDuration / 3600) hrs asleep")
    print("  Core: \(session.coreSleepDuration / 60) min")
    print("  Deep: \(session.deepSleepDuration / 60) min")
    print("  REM: \(session.remSleepDuration / 60) min")
    print("  Efficiency: \(Int(session.sleepEfficiency * 100))%")
}

// Save
try await hub.sleep.save(model: sleepModel, extra: nil)
```

Results are sorted by date (most recent first).

| Sleep Stage | Description |
|-------------|-------------|
| In Bed | Time spent in bed |
| Asleep (Unspecified) | General sleep without stage detail |
| Awake | Awake periods during sleep |
| Core Sleep | Light/core sleep stage |
| Deep Sleep | Deep sleep stage |
| REM Sleep | REM sleep stage |

**Computed Properties:** `totalSleepDuration`, `totalInBedDuration`, `totalAwakeDuration`, `coreSleepDuration`, `deepSleepDuration`, `remSleepDuration`, `sleepEfficiency`, `sessions(maxGap:)`

---

### Cycle Tracking

Full cycle tracking with contraceptive logging, pregnancy tracking, lactation, and Apple cycle notifications:

```swift
let menstruation = try await hub.cycleTracking.menstruation()
print("Flow: \(menstruation.mostRecent?.type.name ?? "")")
print("Cycle starts: \(menstruation.cycleStarts.count)")

let contraceptive = try await hub.cycleTracking.contraceptive()
print("Method: \(contraceptive.mostRecent?.type.name ?? "")")

// Cycle notifications (read-only, generated by Apple)
let irregular = try await hub.cycleTracking.irregularMenstrualCycles()
print("Irregular cycle alerts: \(irregular.items.count)")

// Save
try await hub.cycleTracking.saveMenstruation(model: menstruationModel, extra: nil)
try await hub.cycleTracking.saveContraceptive(model: contraceptiveModel, extra: nil)
```

Results are sorted by date (most recent first) with `mostRecent` computed properties on all models.

| Data | Saveable |
|------|----------|
| Abdominal Cramps | ✅ |
| Bloating | ✅ |
| Breast Pain | ✅ |
| Cervical Mucus Quality | ✅ |
| Contraceptive | ✅ |
| Lactation | ✅ |
| Menstruation | ✅ |
| Mood Changes | ✅ |
| Ovulation | ✅ |
| Pregnancy | ✅ |
| Pregnancy Test Result | ✅ |
| Progesterone Test Result | ✅ |
| Sexual Activity | ✅ |
| Spotting | ✅ |
| Vaginal Dryness | ✅ |
| Infrequent Menstrual Cycles | — (read-only notification) |
| Irregular Menstrual Cycles | — (read-only notification) |
| Persistent Intermenstrual Bleeding | — (read-only notification) |
| Prolonged Menstrual Periods | — (read-only notification) |

**Features:**
- `Contraceptive.Item.ContraceptiveType` — Implant, Injection, IUD, Intravaginal Ring, Oral, Patch
- `Menstruation.cycleStarts` — filter items that mark the beginning of a new cycle
- `Ovulation.positiveResults` / `PregnancyTestResult.positiveResults` — filter positive test results
- `CycleNotification` — read-only Apple-generated alerts for cycle irregularities
- `mostRecent` on all models, sort descriptors (newest first) on all queries

---

### Symptoms

38 symptom types — all readable and saveable, organized by category with display names:

```swift
let headaches = try await hub.symptoms.symptom(type: .headache)
print("\(headaches.displayName): \(headaches.items.first?.style.name ?? "")")
print("Category: \(headaches.category?.rawValue ?? "")")

// Save
try await hub.symptoms.saveSymptom(type: .headache, model: headacheModel, extra: nil)

// Appetite changes (has its own dedicated model with increase/decrease tracking)
let appetite = try await hub.symptoms.appetiteChanges()
```

Results are sorted by date (most recent first). `SymptomType` conforms to `CaseIterable` for easy enumeration.

**Categories & Types:**

| Category | Types |
|----------|-------|
| Gastrointestinal | Abdominal Cramps, Bloating, Constipation, Diarrhea, Heartburn, Nausea, Vomiting |
| Pain | Body & Muscle Ache, Breast Pain, Chest Tightness or Pain, Headache, Lower Back Pain, Pelvic Pain |
| Skin & Hair | Acne, Dry Skin, Hair Loss |
| Cardiovascular | Rapid/Pounding/Fluttering Heartbeat, Skipped Heartbeat |
| Respiratory | Congestion, Coughing, Runny Nose, Shortness of Breath, Sore Throat, Wheezing |
| Neurological & Mental | Dizziness, Fainting, Fatigue, Memory Lapse, Mood Changes, Sleep Changes |
| Constitutional | Chills, Fever, Hot Flashes, Night Sweats |
| Urogenital | Bladder Incontinence, Vaginal Dryness |
| Sensory | Loss of Smell, Loss of Taste |

---

### Vitals

All vital sign data types with full read/write support and sort-by-date ordering:

```swift
let bp = try await hub.vitals.bloodPressure()
print("\(bp.items.first?.value ?? "")") // "120/80 mmHg"

let glucose = try await hub.vitals.bloodGlucose()
print("\(glucose.items.first?.bloodGlucose ?? 0) mg/dL - \(glucose.items.first?.mealTime.name ?? "")")

// Save
try await hub.vitals.saveBloodPressure(model: bpModel, extra: nil)
```

`VitalType` enum provides `displayName` and `unit` for all types and conforms to `CaseIterable`.

| Data | Unit | Saveable |
|------|------|----------|
| Blood Glucose | mg/dL | ✅ |
| Blood Oxygen | % | ✅ |
| Blood Pressure | mmHg | ✅ |
| Body Temperature | °C / °F | ✅ |
| Menstruation | — | ✅ |
| Respiratory Rate | breaths/min | ✅ |

---

### Other Data

Comprehensive "Other Data" tracking with clinical helpers and hearing support:

| Data | Unit | Saveable |
|------|------|----------|
| Alcohol Consumption | drinks | ✅ |
| Blood Alcohol Content | % | ✅ |
| Blood Glucose | mg/dL | ✅ |
| Environmental Audio Exposure | dBASPL | — |
| Hand Washing | events | ✅ |
| Headphone Audio Exposure | dBASPL | — |
| Inhaler Usage | uses | ✅ |
| Insulin Delivery | IU | ✅ |
| Number of Times Fallen | times | ✅ |
| Sexual Activity | events | ✅ |
| Time in Daylight | min | ✅ |
| Tooth Brushing | events | ✅ |
| UV Exposure | UV Index | ✅ |
| Water Temperature | °C | ✅ |

**Features:**
- `OtherDataType` enum with `displayName`, `unit`, and 8-category grouping (Alcohol, Hygiene, Diabetes, Safety, Reproductive, Respiratory, Environment, Hearing)
- `UVExposure.Classification` — WHO/EPA UV Index levels (Low → Extreme)
- `HandWashing.meetsRecommendedDuration` — WHO 20-second guideline
- `ToothBrushing.meetsRecommendedDuration` — ADA 2-minute guideline
- `InsulinDelivery.totalBasal` / `totalBolus` — delivery breakdown
- `EnvironmentalAudioExposure.exceedsDamageThreshold` — NIOSH 85 dB limit
- `AlcoholContent.isAboveLegalLimit` — US 0.08% BAC limit
- Sort descriptors (newest first) and `mostRecent` on all models

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
