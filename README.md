# 🏥 HealthHub

[![Swift](https://img.shields.io/badge/Swift-6.4-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS_27+-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![SPM](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg)](https://swift.org/package-manager/)

A Swift 6.4, iOS 27-first HealthKit framework for authorization, querying, live synchronization, analytics, and specialized clinical workflows.

---


## ✨ Features

- 🏃 **Activity** — Steps, workouts, active energy, cycling, running, swimming & more
- ❤️ **Heart** — Heart rate, HRV (SDNN and RMSSD), AFib, blood pressure, cardio fitness
- 🧘 **Mental Wellbeing** — Mindfulness, state of mind, GAD-7, PHQ-9, sleep, daylight
- 🫁 **Respiratory** — Blood oxygen, respiratory rate, forced vital capacity
- 🍎 **Nutrition** — Macronutrients, vitamins, minerals, hydration, caffeine
- 🏋️ **Body** — Weight, BMI, body fat, height, temperature
- 🩺 **Vitals** — Blood glucose, blood pressure, body temperature
- 🔬 **Other Data** — Alcohol, hand washing, UV exposure, insulin & more
- 🧬 **Characteristics** — Biological sex, blood type, DOB, skin type, activity move mode
- 🚴 **Mobility** — Walking steadiness, stair speed, stride length
- 🩸 **Cycle Tracking** — Menstruation, ovulation, contraceptives, pregnancy, menopause, lactation, cycle notifications
- 🤒 **Symptoms** — 35+ symptom types
- 👂 **Hearing** — Environmental audio, headphone audio, audiograms
- 📋 **Clinical Records** — Allergies, conditions, immunizations, lab results, medications, procedures, vitals, coverage, clinical notes (FHIR-backed)
- 📄 **CDA Documents** — Legacy clinical document (`HKCDADocumentSample`) support
- 💓 **Electrocardiogram** — Watch ECG classification & voltage waveform measurements
- 📈 **Heartbeat Series** — Beat-to-beat irregular rhythm precursor data (read + write)
- ✅ **Verifiable Clinical Records** — Vaccination & lab "card" records (SMART Health Cards)
- 📎 **Attachments** — Attach files/images to any HealthKit sample or workout
- 💊 **Medications** — User-annotated medication schedules & dose events
- 👓 **Vision Prescriptions** — Glasses & contact lens prescriptions (full read + write)
- 🍽️ **Food Correlation** — Group nutrition samples into meals via `HKCorrelationTypeIdentifier.food`
- 🏊 **Multi-Activity Workouts** — Composite workouts (e.g. triathlons) and workout effort score linking
- ⚡ **Client-First Core** — Actor-backed, injectable HealthKit client with authorization plans, uniform queries, writes, deletes, statistics, and provenance
- 🔄 **Reliable Sync** — Observer streams, persisted query anchors, incremental updates, and background delivery
- 📊 **Dashboard Summaries** — Steps, active energy, heart rate, workouts, and sleep in one query

---

## 📦 Installation

### Swift Package Manager

Add HealthHub to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/matybrennan/HealthHub", from: "4.0.0")
]
```

Or add it via Xcode: **File → Add Package Dependencies** → paste the URL above.

> ⚠️ **Requires iOS 27+ and Swift 6.4** (Xcode 27.2 or later).

---

## 🚀 Getting Started

### Modern API

`HealthHubClient` is the iOS 27-first entry point for authorization and cross-domain summaries:

```swift
let health = HealthHubClient()

try await health.requestAuthorization(scopes: [.activity, .heart, .sleep])

let dashboard = try await health.dashboard()
print(dashboard.stepCount ?? 0)
```

`requestAuthorization` only shows the HealthKit prompt when something new needs to be requested, so it is safe to call on every launch. Use `HealthAuthorizationPlan` when you need write access or a custom set of types.

For data pipelines and background sync, use the injectable store directly:

```swift
let store = HealthStoreClient()
let query = HealthQuery(dateRange: .lastNDays(30), limit: 100)

let samples = try await store.sampleSummaries(
    for: [.stepCount],
    query: query,
    unit: .count()
)

let anchors = HealthQueryAnchorStore()
let change = try await store.synchronize(
    for: .stepCount,
    anchorKey: "steps",
    anchorStore: anchors,
    query: query,
    unit: .count()
)
```

The existing domain services remain available during the 4.0 migration. See [Migrating to 4.0](MIGRATING_TO_4.0.md) for the new client-first architecture.

### Upgrading from 3.x

4.0 is a major release that raises the deployment target to iOS 27 and removes the package-wide MainActor default isolation. Use `HealthHubClient` for new authorization, synchronization, analytics, and cross-domain code. Existing specialized `HealthHubManager` services remain available once your app targets iOS 27. See [MIGRATING_TO_4.0.md](MIGRATING_TO_4.0.md) for the migration path.

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

let health = HealthHubClient()
let plan = HealthAuthorizationPlan(
    scopes: [.activity, .heart, .sleep],
    toShare: [.workout]
)

try await health.requestAuthorization(plan: plan)
```

---

## 🏗️ Architecture

HealthHub 4.0 uses a **client-first, actor-backed architecture** for cross-domain HealthKit workflows. The specialized services remain available for focused features that HealthKit represents with dedicated types.

```
HealthHubClient (actor)
├── HealthStoreClientProtocol (injectable)
│   ├── Authorization plans and request status
│   ├── Sample summaries and statistics
│   ├── Save and delete operations
│   ├── Anchored synchronization and observer streams
│   └── Background delivery
├── HealthDashboardService
├── HealthDataCatalog
└── Legacy HealthHubManager
    ├── Activity, heart, body, mobility, nutrition, sleep, and vitals
    ├── ECG, heartbeat series, workouts, routes, and attachments
    └── Clinical records, medications, hearing, and vision prescriptions
```

Inject a conforming store for deterministic tests and previews:

```swift
func makeHealthClient(store: some HealthStoreClientProtocol) -> HealthHubClient {
    HealthHubClient(store: store)
}
```

---

## 📖 Usage

### Using the 4.0 Client

```swift
let health = HealthHubClient()
let dashboard = try await health.dashboard(for: .today)

print(dashboard.stepCount ?? 0)
print(dashboard.activeEnergyKilocalories ?? 0)
print(dashboard.averageHeartRate ?? 0)
```

### Using Specialized Services

Use `HealthHubManager` or an individual service for workflows that have rich domain models, such as workouts, ECGs, clinical records, or prescriptions:

```swift
let workoutManager = WorkoutManager(
    readService: WorkoutReadService(),
    writeService: WorkoutWriteService()
)
let todayWorkouts = try await workoutManager.workouts(fromWorkoutType: .today)
```

---

## 📚 API Reference

### Authorization

| Method / Property | Description |
|--------|-------------|
| `HealthAuthorizationPlan` | Least-privilege read scopes and explicit write types |
| `authorizationRequestStatus(for:)` | Whether HealthKit would display a permission prompt |
| `requestAuthorization(plan:)` | Request the plan and return whether a request was needed |
| `HealthAuthorizationScope` | Activity, heart, body, mobility, nutrition, sleep, mental wellbeing, reproductive health, vitals, and hearing |
| `HealthHubManager.configuration` | Legacy configuration service for existing manager-based code |

```swift
let plan = HealthAuthorizationPlan(
    scopes: [.activity, .heart],
    toShare: [.workout]
)
let status = try await health.authorizationRequestStatus(for: plan)
```

HealthKit does not expose whether a user granted read access to an individual type. Request completion means the authorization sheet completed; an empty query can still mean the user declined read access.

### HealthStoreClient

`HealthStoreClient` is an actor and the complete low-level API behind `HealthHubClient`. It can be injected through `HealthHubClient(store:)`.

| API | Description |
|-----|-------------|
| `sampleSummaries(for:query:unit:)` | Fetch value-safe samples with UUID, source, device, dates, and optional quantity/category/workout value |
| `statistics(for:unit:query:)` | Sum, average, minimum, and maximum for a quantity type |
| `save(_:)` / `delete(_:)` | Save or delete HealthKit objects |
| `anchoredChanges(for:from:query:unit:)` | Fetch added/deleted records since an anchor |
| `synchronize(for:anchorKey:anchorStore:query:unit:)` | Fetch changes and persist the replacement anchor |
| `updates(for:query:)` | `AsyncThrowingStream` of observer events |
| `enableBackgroundUpdates(for:frequency:)` | Enable HealthKit background delivery |

#### Uniform Queries and Provenance

```swift
let store = HealthStoreClient()
let query = HealthQuery(dateRange: .lastNDays(30), limit: 100)

let samples = try await store.sampleSummaries(
    for: [.stepCount],
    query: query,
    unit: .count()
)

for sample in samples {
    print(sample.typeIdentifier, sample.sourceBundleIdentifier, sample.deviceName ?? "Unknown device")
}
```

Use the correct `HKUnit` for each requested quantity type. `HealthSampleSummary` carries a numeric value only when a unit is supplied for a quantity sample.

`HealthQuery` supports `.today`, `.thisWeek`, `.thisMonth`, `.lastNDays(_)`, `.betweenDates(start:end:)`, and `.allTime`, plus a per-type limit and newest- or oldest-first sorting.

#### Statistics and Dashboards

```swift
let store = HealthStoreClient()
let steps = try await store.statistics(
    for: .stepCount,
    unit: .count(),
    query: .init(dateRange: .today)
)
print(steps.sum ?? 0)

let dashboard = try await HealthHubClient().dashboard()
print(dashboard.workoutCount)
```

`HealthDashboard` includes total steps, active energy, average heart rate, workout count, and sleep duration.

#### Anchored Sync, Observer Streams, and Background Delivery

```swift
let store = HealthStoreClient()
let anchors = HealthQueryAnchorStore()

let change = try await store.synchronize(
    for: .stepCount,
    anchorKey: "steps",
    anchorStore: anchors,
    query: .init(dateRange: .lastNDays(30)),
    unit: .count()
)
print(change.addedSamples.count, change.deletedObjectIDs.count)

try await store.enableBackgroundUpdates(for: [.stepCount], frequency: .hourly)
let updates = try await store.updates(for: [.stepCount])
for try await update in updates {
    print("HealthKit changed: \(update.typeIdentifier)")
}
```

Persist anchors with `HealthQueryAnchorStore` or provide your own `HealthQueryAnchorStoring` implementation. Use observer events to trigger another anchored synchronization; do not treat an observer event as the data itself.

#### Writes, Deletions, and Idempotency

```swift
let metadata = HealthWriteMetadata.idempotency("workout-upload-42")
// Pass metadata to a domain write API, for example saveWorkout(..., extra: metadata).

try await store.delete(objects)
```

`HealthSampleSummary` includes source and device provenance. HealthKit only lets an app delete objects it created, so retain object UUIDs and use an idempotency key in your own retry/deduplication strategy.

#### Data Catalog

```swift
let descriptor = HealthDataCatalog.descriptor(for: .heartRate)
print(descriptor.displayName)
print(descriptor.category)
print(descriptor.isWritable)

let activityTypes = HealthDataCatalog.types(in: .activity)
```

`HealthDataCatalog` is the centralized source for type availability, HealthKit identifier, write capability, category, and display name. Use it to build authorization screens and diagnostics instead of maintaining separate type lists.

---

#### Errors and Availability

```swift
do {
    let statistics = try await store.statistics(
        for: .stepCount,
        unit: .count(),
        query: .init(dateRange: .today)
    )
    print(statistics.sum ?? 0)
} catch let error as HealthHubError {
    print(error.localizedDescription)
}
```

`HealthHubError` distinguishes unavailable HealthKit data, unsupported types, invalid queries, invalid anchors, and missing sharing authorization. Platform availability is also exposed through `HealthDataCatalog` and `HealthObjectType.isAvailable`.

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

Retrieve per-sample active energy burned by time period.

```swift
let energy = try await hub.activityManager.activeEnergy.activeEnergy(from: .today)
print("Total burned: \(energy.totalCalories) kcal")
print("Most recent: \(energy.mostRecent?.calories ?? 0) kcal")
```

| Query Type | Description |
|-----------|-------------|
| `.today` | Today's active energy |
| `.thisWeek` | This week's active energy |
| `.thisMonth` | This month's active energy |
| `.betweenDates(start:end:)` | Custom date range |

#### Steps

Retrieve step counts with observable state and async/await.

```swift
try await hub.activityManager.steps.steps(fromStepsType: .today())
// Access results via published properties
let todaySteps = hub.activityManager.steps.today
print("Total: \(todaySteps.total) steps")
print("Peak interval: \(todaySteps.peakInterval?.count ?? 0) steps")
```

| Query Type | Interval Unit | Description |
|-----------|---------------|-------------|
| `.lastHour` | — | Steps in the last hour |
| `.today(timeInterval:)` | Hours (default: 1) | Today's steps in hourly batches |
| `.thisWeek(timeInterval:)` | Hours (default: 24) | This week's steps |
| `.thisMonth(timeInterval:)` | Days (default: 1) | This month's steps |
| `.betweenDates(start:end:)` | Auto | Custom date range |

#### Workouts

Read and save workouts with full detail support including routes, heart rate, and events.

```swift
// Fetch workouts
let workouts = try await hub.activityManager.workout.workouts(fromWorkoutType: .thisWeek)
print("Total distance: \(workouts.totalDistance / 1000) km")
print("Most recent: \(workouts.mostRecent?.durationFormatted ?? "")")

// Fetch detailed workout info (route, HR, events)
let detail = try await hub.activityManager.workout.workoutDetail(
    for: workout.startDate,
    endDate: workout.endDate
)
print("Avg HR: \(detail.averageHeartRate ?? 0) BPM")
print("Laps: \(detail.lapCount)")

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
| `.thisMonth` | This month's workouts |
| `.all` | All workouts |
| `.betweenDates(start:end:)` | Custom date range |
| `.byActivityType(HKWorkoutActivityType)` | Filter by sport |

| Detail Methods | Description |
|---------------|-------------|
| `workoutRoute(for:endDate:)` | GPS route data with elevation/distance |
| `workoutHeartRate(for:endDate:)` | Heart rate during workout |
| `workoutEvents(for:endDate:)` | Laps, pauses, segments |
| `workoutDetail(for:endDate:)` | Combined rich detail |
| `workoutActivities(for:endDate:)` | Sub-activity segments for composite workouts (e.g. triathlons) |
| `workoutEffortRelationships(for:endDate:)` | Links a workout to its linked effort score sample |

#### Activity Service

All Apple Health activity data types — cycling, running, swimming, skiing, underwater, and more.

```swift
let speed = try await hub.activityManager.activity.runningSpeed()
print("Avg pace: \(speed.mostRecent?.paceMinPerKm ?? 0) min/km")

let cycling = try await hub.activityManager.activity.cyclingDistance()
print("Total: \(cycling.totalKilometers) km")
```

<details>
<summary>View all activity data types</summary>

**Distance** — cyclingDistance, walkingRunningDistance, swimmingDistance, wheelchairDistance, downhillSnowSportsDistance, crossCountrySkiingDistance, distanceRowing, distancePaddleSports, distanceSkatingSports

**Speed** — cyclingSpeed, runningSpeed (with pace), crossCountrySkiingSpeed, rowingSpeed, paddleSportsSpeed

**Cycling** — cyclingCadence, cyclingPower, cyclingFunctionalThresholdPower

**Running** — runningPower, runningStrideLength, runningVerticalOscillation, runningGroundContactTime

**Swimming** — swimmingStrokeCount

**Underwater** — underwaterDepth, waterTemperature

**Exercise & Energy** — exerciseMinutes, restingEnergy, standTime, moveTime, workoutEffortScore (user-entered RPE), estimatedWorkoutEffortScore (Apple-calculated)

**Miscellaneous** — flightsClimbed, pushCount, nikeFuel, physicalEffort (with intensity levels), appleStandHour

All distance/speed/cycling/running/swimming types support save.

</details>

---

### Heart Manager

Access via `hub.heartManager` or use `HeartManager()` directly.

```swift
let afib = try await hub.heartManager.atrialFibrillation()
print("AFib burden: \(afib.averageBurden)%")

let bp = try await hub.heartManager.bloodPressure()
print("Latest: \(bp.mostRecent?.value ?? "")")

let hrv = try await hub.heartManager.heartRateVariability()
print("Average SDNN: \(hrv.averageSDNN) ms")

let rmssd = try await hub.heartManager.heartRateVariabilityRMSSD()
print("Average RMSSD: \(rmssd.averageRMSSD) ms")

let resting = try await hub.heartManager.restingHeartRate()
print("Resting HR: \(resting.mostRecent?.bpm ?? 0) BPM")
```

| Data | Saveable |
|------|----------|
| Heart Rate (async, observable) | — |
| Atrial Fibrillation History | — |
| Blood Pressure | ✅ |
| Cardio Fitness (VO₂ Max) | ✅ |
| Cardio Recovery | ✅ |
| Heart Rate Variability (SDNN) | — |
| Heart Rate Variability (RMSSD) | — |
| High Heart Rate Events | — |
| Irregular Heart Rhythm Events | — |
| Low Cardio Fitness Event Notifications | — |
| Hypertension Event Notifications | — |
| Low Heart Rate Events | — |
| Peripheral Perfusion Index | ✅ |
| Resting Heart Rate | — |
| Walking Heart Rate Average | — |

#### Heart Rate Service (Observable)

The `HeartRateService` uses `@Observable` for reactive UI updates and modern `async/await` for fetching:

```swift
// Fetch heart rate with flexible time ranges
try await hub.heartManager.heartRate.heartRate(fromHeartRateType: .current)
try await hub.heartManager.heartRate.heartRate(fromHeartRateType: .today(timeInterval: 60))
try await hub.heartManager.heartRate.heartRate(fromHeartRateType: .thisWeek(timeInterval: 1))
try await hub.heartManager.heartRate.heartRate(fromHeartRateType: .thisMonth(timeInterval: 1))
try await hub.heartManager.heartRate.heartRate(fromHeartRateType: .allTime(timeInterval: 7))
try await hub.heartManager.heartRate.heartRate(fromHeartRateType: .betweenDates(start: startDate, end: endDate))

// Access published properties (updates SwiftUI views automatically)
let current = hub.heartManager.heartRate.current       // HeartRate.Item?
let today = hub.heartManager.heartRate.today           // HeartRate
let week = hub.heartManager.heartRate.thisWeek         // HeartRate

// Rich computed properties
print("Today avg: \(today.average) BPM")
print("Max: \(today.overallMax ?? 0) BPM")
print("Min: \(today.overallMin ?? 0) BPM")
```

**HeartRateType options:**

| Type | Interval Unit | Description |
|------|---------------|-------------|
| `.current` | — | Most recent single reading |
| `.today(timeInterval:)` | Minutes | Today's data in batches (default: 60 min) |
| `.thisWeek(timeInterval:)` | Days | This week in batches (default: 1 day) |
| `.thisMonth(timeInterval:)` | Days | This month in batches (default: 1 day) |
| `.allTime(timeInterval:)` | Days | All data in batches (default: 1 day) |
| `.betweenDates(start:end:timeInterval:)` | Minutes | Custom range (auto-calculated if nil) |

---

### Body Measurements

Full body composition and measurement tracking with clinical classification:

```swift
let weight = try await hub.bodyMeasurements.weight()
print("\(weight.mostRecent?.kg ?? 0) kg")

let bmi = try await hub.bodyMeasurements.bodyMassIndex()
print("BMI: \(bmi.mostRecent?.value ?? 0) — \(bmi.mostRecent?.classification.rawValue ?? "")")

let height = try await hub.bodyMeasurements.height()
print("Height: \(height.mostRecent?.feetAndInches ?? "")")

// Save
try await hub.bodyMeasurements.saveWeight(model: weightModel, extra: nil)
```

Results are sorted by date (most recent first) with `mostRecent` on all models.

| Data | Unit | Saveable |
|------|------|----------|
| Basal Body Temperature | °C / °F | ✅ |
| Body Fat Percentage | % | ✅ |
| Body Mass Index | kg/m² | ✅ |
| Body Temperature | °C / °F | ✅ |
| Electrodermal Activity | μS | ✅ |
| Height | cm / in | ✅ |
| Lean Body Mass | kg / lbs | ✅ |
| Waist Circumference | cm / in | ✅ |
| Weight | kg / lbs | ✅ |
| Wrist Temperature | °C / °F | — (read-only) |

**Features:**
- `BodyMassIndex.Classification` — WHO categories (Underweight, Normal, Overweight, Obese)
- `BodyHeight.Item.feetAndInches` — formatted height string (e.g. 5'11")
- `mostRecent` on all models
- Dual-unit support (metric + imperial) on height, weight, lean body mass, waist

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

**Food Correlation**

Group multiple nutrition samples into a single meal entry using `HKCorrelationTypeIdentifier.food`:

```swift
let meal = try await hub.nutrition.food()
print("Latest meal: \(meal.mostRecent?.foodType ?? "")")
print("Calories: \(meal.mostRecent?.nutrients[.energyConsumed] ?? 0)")

// Save a meal grouping multiple nutrients together
let item = Food.Item(
    foodType: "Grilled Chicken Salad",
    nutrients: [.energyConsumed: 350, .protein: 40, .carbohydrates: 12],
    startDate: mealStart,
    endDate: mealEnd
)
try await hub.nutrition.saveFood(model: item, extra: nil)
```

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

Full cycle tracking with contraceptive logging, pregnancy and menopause tracking, lactation, and Apple cycle notifications:

```swift
let menstruation = try await hub.cycleTracking.menstruation()
print("Flow: \(menstruation.mostRecent?.type.name ?? "")")
print("Cycle starts: \(menstruation.cycleStarts.count)")

let contraceptive = try await hub.cycleTracking.contraceptive()
print("Method: \(contraceptive.mostRecent?.type.name ?? "")")

let menopause = try await hub.cycleTracking.menopausalState()
print("State: \(menopause.mostRecent?.state.name ?? "")")

let bleeding = try await hub.cycleTracking.bleedingAfterMenopause()
print("Most recent bleeding: \(bleeding.mostRecent?.type.name ?? "")")

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
| Bleeding After Menopause (iOS 27+) | ✅ |
| Bleeding After Pregnancy | ✅ |
| Bleeding During Pregnancy | ✅ |
| Cervical Mucus Quality | ✅ |
| Contraceptive | ✅ |
| Lactation | ✅ |
| Menstruation | ✅ |
| Menopausal State (iOS 27+) | ✅ |
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

Comprehensive "Other Data" tracking with clinical helpers:

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

### Hearing

Dedicated hearing health tracking with audio exposure monitoring and audiogram support:

```swift
let environmental = try await hub.hearing.environmentalAudioExposure()
print("Avg: \(environmental.averageLevel ?? 0) dB")
print("Exceeds damage threshold: \(environmental.mostRecent?.exceedsDamageThreshold ?? false)")

let headphone = try await hub.hearing.headphoneAudioExposure()
print("Total listening: \(headphone.totalListeningDuration / 60) min")

let audiogram = try await hub.hearing.audiogram()
if let recent = audiogram.mostRecent {
    print("Left ear: \(recent.leftEarClassification?.rawValue ?? "N/A")")
    print("Right ear: \(recent.rightEarClassification?.rawValue ?? "N/A")")
}
```

| Data | Unit | Saveable |
|------|------|----------|
| Environmental Audio Exposure | dBASPL | — (read-only) |
| Headphone Audio Exposure | dBASPL | — (read-only) |
| Audiogram | dBHL | — (read-only) |

**Features:**
- `EnvironmentalAudioExposureEvent` — WHO 70 dB and NIOSH 85 dB threshold checks
- `HeadphoneAudioExposureEvent` — 85 dB headphone limit check, total listening duration
- `AudiogramEntry` — per-frequency hearing sensitivity with Pure Tone Average (PTA)
- `HearingLossClassification` — WHO categories (Normal, Mild, Moderate, Moderately Severe, Severe, Profound)
- `mostRecent` and `averageLevel` on audio exposure models

---

### Clinical Records

Read-only access to all 9 `HKClinicalType` health records, with automatic FHIR resource passthrough when a provider supplies structured data.

```swift
let allergies = try await hub.clinicalRecords.allergyRecord()
print("Latest: \(allergies.mostRecent?.displayName ?? "")")
print("Records with FHIR data: \(allergies.recordsWithFHIRDataCount)")

let labs = try await hub.clinicalRecords.labResultRecord()
if let fhirData = labs.mostRecent?.fhirData {
    // Parse fhirData (JSON) using your own FHIR model of choice
}
```

| Method | Description |
|--------|-------------|
| `allergyRecord()` | Allergy records |
| `conditionRecord()` | Condition/diagnosis records |
| `immunizationRecord()` | Immunization records |
| `labResultRecord()` | Lab result records |
| `medicationRecord()` | Prescribed medication records |
| `procedureRecord()` | Procedure records |
| `vitalSignRecord()` | Vital sign records |
| `coverageRecord()` | Insurance coverage records |
| `clinicalNoteRecord()` | Clinical note records |

Each returns a `ClinicalRecord` with `items: [ClinicalRecord.Item]` containing `displayName`, `providerName`, `startDate`, and optional `fhirResourceType`/`fhirData`/`fhirVersion`/`sourceURL`.

---

### CDA Documents

Legacy Continuity of Care Document (`HKCDADocumentSample`) support, still present in the HealthKit SDK for older provider integrations.

```swift
let documents = try await hub.cdaDocuments.cdaDocuments()
print("Latest: \(documents.mostRecent?.title ?? "")")
print("Documents with raw data: \(documents.documentsWithDataCount)")
```

Returns a `CDADocument` with `items: [CDADocument.Item]` containing `title`, `patientName`, `authorName`, `custodianName`, optional `documentData`, and `startDate`/`endDate`.

---

### Electrocardiogram

Read-only access to Apple Watch ECG classifications and their underlying voltage waveform.

```swift
let ecg = try await hub.electrocardiogram.electrocardiogram()
print("Classification: \(ecg.mostRecent?.classification ?? "")")
print("Average heart rate: \(ecg.averageHeartRate ?? 0) BPM")
print("Total voltage measurements: \(ecg.totalVoltageMeasurements)")
```

| Method | Description |
|--------|-------------|
| `electrocardiogram()` | All ECG samples (classification, average heart rate, symptoms status) |
| `voltageMeasurements(for:)` | Raw voltage waveform (mV) for a given `HKElectrocardiogram` sample |

---

### Heartbeat Series

Beat-to-beat interval data collected around irregular rhythm notifications, with full read and write support.

```swift
let series = try await hub.heartbeatSeries.heartbeatSeries()
print("Latest series started: \(series.mostRecent?.startDate ?? Date())")

// Save a new heartbeat series
try await hub.heartbeatSeries.saveHeartbeatSeries(model: record, extra: nil)
```

| Method | Description |
|--------|-------------|
| `heartbeatSeries()` | All recorded heartbeat series sessions |
| `heartbeats(for:)` | Individual beat-to-beat timing for a given `HKHeartbeatSeriesSample` |
| `saveHeartbeatSeries(model:extra:)` | Save a new heartbeat series recording |

---

### Verifiable Clinical Records

Read-only access to SMART Health Card style vaccination and lab records (`HKVerifiableClinicalRecord`).

```swift
let records = try await hub.verifiableClinicalRecords.verifiableClinicalRecords()
print("Latest record: \(records.mostRecent?.displayName ?? "")")
```

---

### Attachments

Cross-cutting support for attaching files (photos, PDFs, etc.) to any `HKObject` — samples, workouts, or clinical records.

```swift
let attachment = try await hub.attachments.addAttachment(
    data: imageData,
    name: "wound-photo.jpg",
    contentType: "image/jpeg",
    to: workoutSample
)

let all = try await hub.attachments.attachments(for: workoutSample)
let content = try await hub.attachments.attachmentContent(for: attachment, from: workoutSample)
try await hub.attachments.deleteAttachment(attachment, from: workoutSample)
```

| Method | Description |
|--------|-------------|
| `addAttachment(data:name:contentType:to:)` | Attach a file to any `HKObject` |
| `attachments(for:)` | List attachments on an `HKObject` |
| `attachmentContent(for:from:)` | Download the raw `Data` for an attachment |
| `deleteAttachment(_:from:)` | Remove an attachment |

---

### Medications

Read-only access to `HKUserAnnotatedMedication` — user-managed medication schedules and dose events.

```swift
let medications = try await hub.medications.medications()
print("Latest: \(medications.mostRecent?.displayName ?? "")")
print("Total dose events: \(medications.totalDoseEvents)")
```

Returns a `Medications` model with `items: [Medications.Item]`, each with a `doseEvents: [Medications.DoseEvent]` (`.taken`, `.skipped`, `.snoozed`, `.notInteracted`).

---

### Vision Prescriptions

Full read and write support for glasses and contact lens prescriptions.

```swift
let glasses = try await hub.visionPrescriptions.glassesPrescriptions()
print("Right eye sphere: \(glasses.mostRecent?.rightEye?.lens.sphere ?? 0)")

let contacts = try await hub.visionPrescriptions.contactsPrescriptions()
print("Brand: \(contacts.mostRecent?.brand ?? "")")

// Save a new glasses prescription
let item = GlassesPrescription.Item(
    rightEye: .init(lens: .init(sphere: -1.5, cylinder: -0.5, axis: 90)),
    leftEye: .init(lens: .init(sphere: -1.75)),
    dateIssued: Date()
)
try await hub.visionPrescriptions.saveGlassesPrescription(model: item, extra: nil)
```

| Method | Description |
|--------|-------------|
| `glassesPrescriptions()` | All glasses prescriptions (lens spec, prism, vertex/pupillary distance) |
| `contactsPrescriptions()` | All contact lens prescriptions (lens spec, base curve, diameter, brand) |
| `saveGlassesPrescription(model:extra:)` | Save a new glasses prescription |
| `saveContactsPrescription(model:extra:)` | Save a new contact lens prescription |

`VisionPrism` supports both polar (`amount`/`angle`) and rectangular (`verticalAmount`/`horizontalAmount`) coordinate systems.

---

## 📅 Date Range Filtering

`HealthQuery` and specialized services support flexible `DateRangeType` filtering:

```swift
// Filter body measurements to this month
let weight = try await hub.bodyMeasurements.weight(from: .thisMonth)

// Vitals from the last 7 days
let bp = try await hub.vitals.bloodPressure(from: .lastNDays(7))

// Mobility data for a custom range
let speed = try await hub.mobility.walkingSpeed(from: .betweenDates(start: startDate, end: endDate))

// All data (default behavior, backwards compatible)
let oxygen = try await hub.respiratory.bloodOxygen()  // same as .allTime

// Use the same ranges in a client-first query
let samples = try await HealthStoreClient().sampleSummaries(
    for: [.stepCount],
    query: .init(dateRange: .lastNDays(7)),
    unit: .count()
)
```

| Range | Description |
|-------|-------------|
| `.today` | Today only |
| `.thisWeek` | Current week |
| `.thisMonth` | Current month |
| `.lastNDays(N)` | Last N days |
| `.betweenDates(start:end:)` | Custom date range |
| `.allTime` | No filtering (default) |

---

## 🧪 Testing

HealthHub is designed for testability. Client-first code injects an `HealthStoreClientProtocol` test double; specialized services keep their focused protocols and mocks:

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

For cross-domain tests, implement `HealthStoreClientProtocol` with fixture summaries and statistics, then inject it with `HealthHubClient(store:)`. This avoids requiring a HealthKit entitlement or user health data in unit tests.

---

## 📱 Example App

The `HealthHubExample/` project demonstrates:

- Requesting HealthKit authorization
- Using the 4.0 client-first dashboard
- Fetching steps, active energy, workouts, heart rate, RMSSD heart-rate variability, menopause data, weight, and sleep
- Using `HealthAuthorizationPlan`, `HealthQuery`, and `DateRangeType`
- `@Observable` integration with SwiftUI
- Dependency injection with `HealthHubClient` and `HealthHubManager`

Open `HealthHubExample/HealthHubExample.xcodeproj` in Xcode to run it on an iOS 27+ device or simulator.

---

## 🤝 Contributing

Have a question or found a bug? Create an [issue](https://github.com/matybrennan/HealthHub/issues/new)!

Want to contribute? See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📱 Apps Using HealthHub

- [FitnessKit](https://apps.apple.com/us/app/gym-log-custom-workout-plan/id1445516231)

*Using HealthHub in your app? Open a PR to add it here!*

---

## 📄 License

HealthHub is available under the [MIT License](LICENSE).
