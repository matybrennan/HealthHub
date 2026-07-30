import Foundation
@testable import HealthHub

final class MockVitalsService: VitalsServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0
    var saveCallCount = 0

    var stubbedBloodGlucose = BloodGlucose(items: [])
    var stubbedBloodOxygen = BloodOxygen(items: [])
    var stubbedBloodPressure = BloodPressure(items: [])
    var stubbedBodyTemperature = BodyTemperature(items: [])
    var stubbedMenstruation = Menstruation(items: [])
    var stubbedRespiratoryRate = RespiratoryRate(items: [])

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    private func save() async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }

    func bloodGlucose(from dateRange: DateRangeType) async throws -> BloodGlucose { try await fetch(stubbedBloodGlucose) }
    func bloodOxygen(from dateRange: DateRangeType) async throws -> BloodOxygen { try await fetch(stubbedBloodOxygen) }
    func bloodPressure(from dateRange: DateRangeType) async throws -> BloodPressure { try await fetch(stubbedBloodPressure) }
    func bodyTemperature(from dateRange: DateRangeType) async throws -> BodyTemperature { try await fetch(stubbedBodyTemperature) }
    func menstruation(from dateRange: DateRangeType) async throws -> Menstruation { try await fetch(stubbedMenstruation) }
    func respiratoryRate(from dateRange: DateRangeType) async throws -> RespiratoryRate { try await fetch(stubbedRespiratoryRate) }

    func saveBloodGlucose(model: BloodGlucose, extra: [String: Sendable]?) async throws { try await save() }
    func saveBloodOxygen(model: BloodOxygen, extra: [String: Sendable]?) async throws { try await save() }
    func saveBloodPressure(model: BloodPressure, extra: [String: Sendable]?) async throws { try await save() }
    func saveBodyTemperature(model: BodyTemperature, extra: [String: Sendable]?) async throws { try await save() }
    func saveMenstruation(model: Menstruation, extra: [String: Sendable]?) async throws { try await save() }
    func saveRespiratoryRate(model: RespiratoryRate, extra: [String: Sendable]?) async throws { try await save() }
}
