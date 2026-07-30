import Foundation
@testable import HealthHub

final class MockMentalWellbeingService: MentalWellbeingServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0
    var saveCallCount = 0

    var stubbedMindful = Mindful(items: [])
    var stubbedStateOfMind = StateOfMindEntry(items: [])
    var stubbedGAD7 = GAD7Assessment(items: [])
    var stubbedPHQ9 = PHQ9Assessment(items: [])
    var stubbedSleep = Sleep(items: [])
    var stubbedTimeInDaylight = TimeInDaylight(items: [])

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    private func save() async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }

    func mindfulActivity() async throws -> Mindful { try await fetch(stubbedMindful) }
    func stateOfMind() async throws -> StateOfMindEntry { try await fetch(stubbedStateOfMind) }
    func gad7() async throws -> GAD7Assessment { try await fetch(stubbedGAD7) }
    func phq9() async throws -> PHQ9Assessment { try await fetch(stubbedPHQ9) }
    func sleep() async throws -> Sleep { try await fetch(stubbedSleep) }
    func timeInDaylight() async throws -> TimeInDaylight { try await fetch(stubbedTimeInDaylight) }

    func save(mindful: Mindful, extra: [String: Sendable]?) async throws { try await save() }
    func save(stateOfMind: StateOfMindEntry, extra: [String: Sendable]?) async throws { try await save() }
    func save(gad7: GAD7Assessment, extra: [String: Sendable]?) async throws { try await save() }
    func save(phq9: PHQ9Assessment, extra: [String: Sendable]?) async throws { try await save() }
    func save(model: Sleep, extra: [String: Sendable]?) async throws { try await save() }
    func saveTimeInDaylight(model: TimeInDaylight, extra: [String: Sendable]?) async throws { try await save() }
}
