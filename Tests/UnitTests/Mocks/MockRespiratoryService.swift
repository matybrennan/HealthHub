import Foundation
@testable import HealthHub

final class MockRespiratoryService: RespiratoryServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0
    var saveCallCount = 0

    var stubbedBloodOxygen = BloodOxygen(items: [])
    var stubbedForcedExpiratoryVolume = ForcedExpiratoryVolume(items: [])
    var stubbedForcedVitalCapacity = ForcedVitalCapacity(items: [])
    var stubbedInhalerUsage = InhalerUsage(items: [])
    var stubbedPeakExpiratoryFlowRate = PeakExpiratoryFlowRate(items: [])
    var stubbedRespiratoryRate = RespiratoryRate(items: [])
    var stubbedSixMinuteWalk = SixMinuteWalk(items: [])

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    private func save() async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }

    func bloodOxygen(from dateRange: DateRangeType) async throws -> BloodOxygen { try await fetch(stubbedBloodOxygen) }
    func forcedExpiratoryVolume(from dateRange: DateRangeType) async throws -> ForcedExpiratoryVolume { try await fetch(stubbedForcedExpiratoryVolume) }
    func forcedVitalCapacity(from dateRange: DateRangeType) async throws -> ForcedVitalCapacity { try await fetch(stubbedForcedVitalCapacity) }
    func inhalerUsage(from dateRange: DateRangeType) async throws -> InhalerUsage { try await fetch(stubbedInhalerUsage) }
    func peakExpiratoryFlowRate(from dateRange: DateRangeType) async throws -> PeakExpiratoryFlowRate { try await fetch(stubbedPeakExpiratoryFlowRate) }
    func respiratoryRate(from dateRange: DateRangeType) async throws -> RespiratoryRate { try await fetch(stubbedRespiratoryRate) }
    func sixMinuteWalk(from dateRange: DateRangeType) async throws -> SixMinuteWalk { try await fetch(stubbedSixMinuteWalk) }

    func saveBloodOxygen(model: BloodOxygen, extra: [String: Sendable]?) async throws { try await save() }
    func saveForcedExpiratoryVolume(model: ForcedExpiratoryVolume, extra: [String: Sendable]?) async throws { try await save() }
    func saveForcedVitalCapacity(model: ForcedVitalCapacity, extra: [String: Sendable]?) async throws { try await save() }
    func saveInhalerUsage(model: InhalerUsage, extra: [String: Sendable]?) async throws { try await save() }
    func savePeakExpiratoryFlowRate(model: PeakExpiratoryFlowRate, extra: [String: Sendable]?) async throws { try await save() }
    func saveRespiratoryRate(model: RespiratoryRate, extra: [String: Sendable]?) async throws { try await save() }
    func saveSixMinuteWalk(model: SixMinuteWalk, extra: [String: Sendable]?) async throws { try await save() }
}
