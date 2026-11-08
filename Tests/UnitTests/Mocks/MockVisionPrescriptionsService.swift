import Foundation
@testable import HealthHub

final class MockVisionPrescriptionsService: VisionPrescriptionsServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0
    var saveCallCount = 0

    var stubbedGlassesPrescription = GlassesPrescription(items: [])
    var stubbedContactsPrescription = ContactsPrescription(items: [])

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    private func save() async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }

    func glassesPrescriptions() async throws -> GlassesPrescription { try await fetch(stubbedGlassesPrescription) }
    func contactsPrescriptions() async throws -> ContactsPrescription { try await fetch(stubbedContactsPrescription) }

    func saveGlassesPrescription(model: GlassesPrescription.Item, extra: [String: Sendable]?) async throws { try await save() }
    func saveContactsPrescription(model: ContactsPrescription.Item, extra: [String: Sendable]?) async throws { try await save() }
}
