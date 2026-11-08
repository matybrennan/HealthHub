# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [4.0.0] - 2026-11-08

See [MIGRATING_TO_4.0.md](MIGRATING_TO_4.0.md) for upgrade guidance.

### Added
- `HealthAuthorizationPlan` and domain-based `HealthAuthorizationScope` presets for least-privilege authorization requests
- `authorizationRequestStatus(for:)` and `requestAuthorization(plan:)` APIs that accurately report request necessity without implying read authorization visibility
- iOS 27-first `HealthHubClient` and injectable `HealthStoreClient` architecture
- Unified `HealthQuery`, sample summaries with provenance, quantity statistics, save/delete operations, idempotency metadata, anchored synchronization, observer streams, and background update delivery
- `HealthDashboardService` for daily activity, heart, workout, and sleep summaries
- `HealthDataCatalog` and `HealthQueryAnchorStore` for centralized type metadata and persisted incremental sync
- `HealthHubClient.requestAuthorization(scopes:toShare:)` one-line shortcut for requesting authorization from health domains

### Changed
- **Breaking:** minimum deployment target raised to iOS 27 and Swift 6.4
- **Breaking:** removed package-wide `MainActor` default isolation; HealthKit I/O now runs in actor-based clients
- **Breaking:** `ConfigurationServiceProtocol.navigateToHealthSettings()` is now `@MainActor`
- `requestAuthorization(plan:)` results are `@discardableResult`
- Workout, steps, heart rate, and audiogram reads use current HealthKit APIs (statistics-based workout totals, `HKStatisticsCollectionQueryDescriptor`, `HKWorkoutRouteQueryDescriptor`, `HKWorkoutEffortRelationshipQueryDescriptor`, and audiogram `tests`) instead of deprecated or callback-based ones
- Existing `HealthHubManager` and domain services remain available; new cross-domain code should use `HealthHubClient`
- Example app dashboard now uses `HealthHubClient`

### Fixed
- Authorization status no longer implies per-type read visibility, which HealthKit does not expose
- Removed all Swift 6.4 compiler warnings, including unsafe captured-variable mutation in workout route and effort queries

## [3.4.0]

### Added
- Swift 6.4 package manifest support and Xcode 27.2 CI coverage
- iOS 27 HealthKit support for RMSSD heart-rate variability, menopausal state, and bleeding after menopause
- Example views for RMSSD heart-rate variability and menopause tracking, with availability messaging
- Availability filtering for dynamic `HealthObjectType` authorization requests
- `HeartType` enum with `displayName`, `unit`, and `isSaveable` properties
- `BodyMeasurementType` enum with `displayName`, `unit`, and `isSaveable` properties
- `CycleTrackingType` enum with `displayName`, `isSaveable`, and category grouping
- `DateRangeType` for flexible date filtering across all services (`.today`, `.thisWeek`, `.thisMonth`, `.lastNDays(_)`, `.betweenDates(start:end:)`, `.allTime`)
- Date range filtering on Body, Vitals, Respiratory, Mobility services
- Improved example app demonstrating all major features
- CONTRIBUTING.md, CHANGELOG.md for repo visibility
- 9 missing `HKQuantityTypeIdentifier` types: rowing/paddle sports distance & speed, skating distance, environmental sound reduction, workout effort score, estimated workout effort score, sleeping breathing disturbances
- 9 missing `HKCategoryTypeIdentifier` types: Apple Stand Hour, walking steadiness events, pregnancy bleeding events, environmental/headphone audio exposure events, hypertension events, low cardio fitness events, sleep apnea events
- Multi-activity workout support (`Workout.Activity`) for composite workouts (e.g. triathlons) via `workoutActivities(for:endDate:)`
- Workout effort relationship linking (`Workout.EffortRelationship`) via `workoutEffortRelationships(for:endDate:)`
- Clinical Records module covering all 9 `HKClinicalType` records with FHIR resource passthrough
- CDA Documents module for legacy `HKCDADocumentSample` clinical document support
- Electrocardiogram module wrapping Watch ECG classification and voltage waveform measurements
- Heartbeat Series module with full read and write support for beat-to-beat irregular rhythm precursor data
- Verifiable Clinical Records module for vaccination/lab "card" records
- Attachments module — cross-cutting support for attaching files to any `HKObject`
- Medications module wrapping `HKUserAnnotatedMedication`
- Vision Prescriptions module with full read/write support for glasses and contact lens prescriptions, including prism, vertex/pupillary distance, base curve, and diameter
- Food correlation support (`HKCorrelationTypeIdentifier.food`) grouping nutrition samples into meals

### Fixed
- Corrected several `HealthObjectType` cases that incorrectly reported `sharable: nil` when the underlying HealthKit type is writable (e.g. `heartRateVariability`, `restingHeartRate`, `underwaterDepth`)

### Changed
- The example app now builds in Swift 6 language mode and reports HealthKit authorization errors
- Generated build artifacts are ignored and no longer tracked
- Body, Vitals, Respiratory, and Mobility service protocols now accept `DateRangeType` parameter
- All shared "Case" protocols (BloodPressureCase, CardioFitnessCase, etc.) support date range filtering
- Backwards compatible — existing code without date range parameters continues to work via protocol extensions

## [3.3.0]

### Added
- Hearing module with Environmental Audio Exposure, Headphone Audio Exposure, and Audiogram
- `HearingLossClassification` with WHO categories
- Audio exposure threshold checks (NIOSH 85 dB, WHO 70 dB)

## [3.2.0]

### Added
- iOS 26+ support
- Swift 6.3 toolchain
- `@MainActor` default isolation
- `NonisolatedNonsendingByDefault` and `InferIsolatedConformances` upcoming features

### Changed
- Minimum deployment target raised to iOS 26+

## [3.1.0]

### Added
- Activity Service with cycling, running, swimming, underwater, and miscellaneous data types
- Physical Effort with intensity level classification
- Running Speed with pace calculation (min/km)

## [3.0.0]

### Added
- Full protocol-driven architecture with dependency injection
- `HealthHubManager` facade pattern
- Mobility module (12 data types)
- Cycle Tracking module with notifications
- Mental Wellbeing module (State of Mind, GAD-7, PHQ-9)
- Sleep sessions with stage analysis
- Body measurements with clinical classification (BMI, Walking Steadiness)

### Changed
- Complete rewrite using modern Swift concurrency
- All types conform to `Sendable`
