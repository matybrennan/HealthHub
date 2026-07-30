import Testing
import Foundation
@testable import HealthHub

@Suite("ActivityManager Suite")
struct ActivityManagerTests {

    let mockActiveEnergy: MockActiveEnergyService
    let mockSteps: MockStepsService
    let mockWorkout: MockWorkoutManager
    let mockActivity: MockActivityService
    let sut: ActivityManager

    init() {
        mockActiveEnergy = MockActiveEnergyService()
        mockSteps = MockStepsService()
        mockWorkout = MockWorkoutManager()
        mockActivity = MockActivityService()
        sut = ActivityManager(
            activeEnergy: mockActiveEnergy,
            steps: mockSteps,
            workout: mockWorkout,
            activity: mockActivity
        )
    }

    // MARK: - Active Energy

    @Test("Active energy fetch delegates to service")
    func activeEnergyFetch() async throws {
        let expected = ActiveEnergy(items: [
            ActiveEnergy.Item(calories: 350, startDate: Date(), endDate: Date())
        ])
        mockActiveEnergy.stubbedActiveEnergy = expected

        let result = try await sut.activeEnergy.activeEnergy(from: .today)

        #expect(mockActiveEnergy.activeEnergyCallCount == 1)
        #expect(result.items.count == 1)
        #expect(result.items[0].calories == 350)
    }

    @Test("Active energy tracks last received type")
    func activeEnergyType() async throws {
        _ = try await sut.activeEnergy.activeEnergy(from: .thisWeek)
        if case .thisWeek = mockActiveEnergy.lastReceivedType! {
        } else {
            Issue.record("Expected .thisWeek type")
        }
    }

    @Test("Active energy propagates errors from service")
    func activeEnergyError() async {
        mockActiveEnergy.shouldThrowError = NSError(domain: "test", code: 1)
        await #expect(throws: Error.self) {
            _ = try await sut.activeEnergy.activeEnergy(from: .today)
        }
    }

    // MARK: - Steps

    @Test("Steps fetch delegates to service")
    func stepsFetch() async throws {
        try await sut.steps.steps(fromStepsType: .lastHour)
        #expect(mockSteps.stepsCallCount == 1)
    }

    @Test("Steps reset delegates to service")
    func stepsReset() {
        sut.steps.reset(type: .today())
        #expect(mockSteps.resetCallCount == 1)
    }

    @Test("Steps propagates errors from service")
    func stepsError() async {
        mockSteps.shouldThrowError = NSError(domain: "test", code: 2)
        await #expect(throws: Error.self) {
            try await sut.steps.steps(fromStepsType: .lastHour)
        }
    }

    // MARK: - Activity

    @Test("Cycling distance fetch delegates to activity service")
    func cyclingDistance() async throws {
        let expected = CyclingDistance(items: [
            CyclingDistance.Item(distance: 10000, date: Date())
        ])
        mockActivity.stubbedCyclingDistance = expected

        let result = try await sut.activity.cyclingDistance()

        #expect(mockActivity.fetchCallCount == 1)
        #expect(result.items.count == 1)
        #expect(result.totalKilometers == 10.0)
    }

    @Test("Walking running distance fetch delegates to activity service")
    func walkingRunningDistance() async throws {
        _ = try await sut.activity.walkingRunningDistance()
        #expect(mockActivity.fetchCallCount == 1)
    }

    @Test("Physical effort fetch delegates to activity service")
    func physicalEffort() async throws {
        _ = try await sut.activity.physicalEffort()
        #expect(mockActivity.fetchCallCount == 1)
    }

    @Test("Activity service propagates errors")
    func activityServiceError() async {
        mockActivity.shouldThrowError = NSError(domain: "test", code: 3)
        await #expect(throws: Error.self) {
            _ = try await sut.activity.cyclingDistance()
        }
    }

    // MARK: - Workout

    @Test("Workout fetch delegates to workout service")
    func workoutFetch() async throws {
        _ = try await sut.workout.workouts(fromWorkoutType: .today)
        // Verifies delegation without error
    }
}
