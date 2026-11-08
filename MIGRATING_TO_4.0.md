# Migrating to HealthHub 4.0

HealthHub 4.0 requires iOS 27 and Swift 6.4. It introduces `HealthHubClient` as the client-first API for cross-domain HealthKit workflows.

## Use `HealthHubClient` for new code

```swift
let health = HealthHubClient()
let plan = HealthAuthorizationPlan(scopes: [.activity, .heart])

try await health.requestAuthorization(plan: plan)

let dashboard = try await health.dashboard()
let samples = try await health.store.sampleSummaries(
    for: [.stepCount],
    query: .init(dateRange: .today),
    unit: .count()
)
```

`HealthStoreClient` is injectable through `HealthHubClient(store:)`. Use it for deterministic tests, uniform queries, writes and deletes, background updates, and anchored synchronization.

`HealthDataCatalog` exposes availability, identifiers, display names, categories, and write support for every `HealthObjectType`, so authorization screens and diagnostics do not need independent type lists.

Use `HealthWriteMetadata.idempotency(_:)` in the metadata passed to domain write APIs to make retries traceable and deduplicate them in your application.

## Authorization

Use `HealthAuthorizationPlan` instead of assembling unscoped lists throughout an app. `authorizationRequestStatus(for:)` only reports whether HealthKit would prompt. HealthKit does not reveal whether read access was granted for an individual type.

## Synchronization

Use `synchronize(for:anchorKey:anchorStore:query:unit:)` with `HealthQueryAnchorStore` to persist anchors between launches. Use `updates(for:query:)` to trigger incremental sync after HealthKit reports a change.

## Existing services

`HealthHubManager` and domain services remain available for focused workflows such as ECG parsing, medications, clinical records, and prescription handling. Move cross-domain dashboards and data pipelines to `HealthHubClient` first.
