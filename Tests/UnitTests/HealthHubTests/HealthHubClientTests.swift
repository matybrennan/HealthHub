import Testing
import HealthKit
@testable import HealthHub

@Suite("HealthHubClient Suite")
struct HealthHubClientTests {

    @Test("Delegates authorization plans to its injected client")
    func requestsAuthorization() async throws {
        let client = MockHealthStoreClient()
        let hub = HealthHubClient(store: client)

        let result = try await hub.requestAuthorization(plan: HealthAuthorizationPlan(scopes: [.activity]))

        #expect(result == .requested)
    }

    @Test("Builds a dashboard from injected statistics and samples")
    func buildsDashboard() async throws {
        let now = Date()
        let stepIdentifier = HKQuantityType(.stepCount).identifier
        let energyIdentifier = HKQuantityType(.activeEnergyBurned).identifier
        let heartIdentifier = HKQuantityType(.heartRate).identifier
        let workoutIdentifier = HKWorkoutType.workoutType().identifier
        let sleepIdentifier = HKCategoryType(.sleepAnalysis).identifier
        let source = "com.example.healthhub"

        let client = MockHealthStoreClient(
            statisticsByIdentifier: [
                stepIdentifier: .init(typeIdentifier: stepIdentifier, unit: HKUnit.count().unitString, sum: 8_000, average: nil, minimum: nil, maximum: nil),
                energyIdentifier: .init(typeIdentifier: energyIdentifier, unit: HKUnit.kilocalorie().unitString, sum: 450, average: nil, minimum: nil, maximum: nil),
                heartIdentifier: .init(typeIdentifier: heartIdentifier, unit: "count/min", sum: nil, average: 68, minimum: nil, maximum: nil)
            ],
            summariesByIdentifier: [
                workoutIdentifier: [.init(id: UUID(), typeIdentifier: workoutIdentifier, startDate: now, endDate: now, sourceBundleIdentifier: source)],
                sleepIdentifier: [.init(id: UUID(), typeIdentifier: sleepIdentifier, startDate: now.addingTimeInterval(-28_800), endDate: now, sourceBundleIdentifier: source)]
            ]
        )
        let hub = HealthHubClient(store: client)

        let dashboard = try await hub.dashboard()

        #expect(dashboard.stepCount == 8_000)
        #expect(dashboard.activeEnergyKilocalories == 450)
        #expect(dashboard.averageHeartRate == 68)
        #expect(dashboard.workoutCount == 1)
        #expect(dashboard.sleepDuration == 28_800)
    }

    @Test("Catalog describes every supported data type")
    func catalogCoversHealthObjectTypes() {
        #expect(HealthDataCatalog.all.count == HealthObjectType.allCases.count)
        #expect(HealthDataCatalog.all.allSatisfy { !$0.displayName.isEmpty })
    }

    @Test("Anchor stores persist portable anchors")
    func persistsAnchors() async throws {
        let suiteName = "HealthHubTests.\(UUID().uuidString)"
        let store = HealthQueryAnchorStore(suiteName: suiteName)
        let anchor = HealthQueryAnchor(data: Data([1, 2, 3]))

        await store.save(anchor, for: "steps")

        let savedAnchor = await store.anchor(for: "steps")
        #expect(savedAnchor == anchor)
        await store.removeAnchor(for: "steps")
        let removedAnchor = await store.anchor(for: "steps")
        #expect(removedAnchor == nil)
        UserDefaults(suiteName: suiteName)?.removePersistentDomain(forName: suiteName)
    }
}
