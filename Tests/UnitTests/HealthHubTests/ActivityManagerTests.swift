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

    @Test("Paddle sports distance fetch delegates to activity service")
    func paddleSportsDistance() async throws {
        let expected = PaddleSportsDistance(items: [
            PaddleSportsDistance.Item(distance: 3200, date: Date())
        ])
        mockActivity.stubbedPaddleSportsDistance = expected

        let result = try await sut.activity.paddleSportsDistance()

        #expect(mockActivity.fetchCallCount == 1)
        #expect(result.items.count == 1)
        #expect(result.totalKilometers == 3.2)
    }

    @Test("Physical effort fetch delegates to activity service")
    func physicalEffort() async throws {
        _ = try await sut.activity.physicalEffort()
        #expect(mockActivity.fetchCallCount == 1)
    }

    @Test("Estimated workout effort score fetch delegates to activity service")
    func estimatedWorkoutEffortScore() async throws {
        let expected = EstimatedWorkoutEffortScore(items: [
            EstimatedWorkoutEffortScore.Item(effort: 6, date: Date())
        ])
        mockActivity.stubbedEstimatedWorkoutEffortScore = expected

        let result = try await sut.activity.estimatedWorkoutEffortScore()

        #expect(mockActivity.fetchCallCount == 1)
        #expect(result.items.count == 1)
        #expect(result.average == 6)
    }

    @Test("Apple stand hour fetch delegates to activity service")
    func appleStandHour() async throws {
        let expected = StandHourEvent(items: [
            StandHourEvent.Item(isStood: true, startDate: Date(), endDate: Date())
        ])
        mockActivity.stubbedAppleStandHour = expected

        let result = try await sut.activity.appleStandHour()

        #expect(mockActivity.fetchCallCount == 1)
        #expect(result.items.count == 1)
        #expect(result.stoodHours == 1)
    }

    @Test("Workout effort score save delegates to activity service")
    func workoutEffortScoreSave() async throws {
        let model = WorkoutEffortScore(items: [
            WorkoutEffortScore.Item(effort: 7, date: Date())
        ])

        try await sut.activity.saveWorkoutEffortScore(model: model, extra: nil)

        #expect(mockActivity.saveCallCount == 1)
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
