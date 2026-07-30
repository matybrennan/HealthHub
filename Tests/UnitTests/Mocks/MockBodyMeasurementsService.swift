import Foundation
@testable import HealthHub

final class MockBodyMeasurementsService: BodyMeasurementsServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0
    var saveCallCount = 0

    var stubbedBasalBodyTemperature = BasalBodyTemperature(items: [])
    var stubbedBodyFatPercentage = BodyFatPercentage(items: [])
    var stubbedBodyMassIndex = BodyMassIndex(items: [])
    var stubbedBodyTemperature = BodyTemperature(items: [])
    var stubbedElectrodermalActivity = ElectrodermalActivity(items: [])
    var stubbedHeight = BodyHeight(items: [])
    var stubbedLeanBodyMass = LeanBodyMass(items: [])
    var stubbedWaistCircumference = WaistCircumference(items: [])
    var stubbedWeight = BodyWeight(items: [])
    var stubbedWristTemperature = WristTemperature(items: [])

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    private func save() async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }

    func basalBodyTemperature(from dateRange: DateRangeType) async throws -> BasalBodyTemperature { try await fetch(stubbedBasalBodyTemperature) }
    func bodyFatPercentage(from dateRange: DateRangeType) async throws -> BodyFatPercentage { try await fetch(stubbedBodyFatPercentage) }
    func bodyMassIndex(from dateRange: DateRangeType) async throws -> BodyMassIndex { try await fetch(stubbedBodyMassIndex) }
    func bodyTemperature(from dateRange: DateRangeType) async throws -> BodyTemperature { try await fetch(stubbedBodyTemperature) }
    func electrodermalActivity(from dateRange: DateRangeType) async throws -> ElectrodermalActivity { try await fetch(stubbedElectrodermalActivity) }
    func height(from dateRange: DateRangeType) async throws -> BodyHeight { try await fetch(stubbedHeight) }
    func leanBodyMass(from dateRange: DateRangeType) async throws -> LeanBodyMass { try await fetch(stubbedLeanBodyMass) }
    func waistCircumference(from dateRange: DateRangeType) async throws -> WaistCircumference { try await fetch(stubbedWaistCircumference) }
    func weight(from dateRange: DateRangeType) async throws -> BodyWeight { try await fetch(stubbedWeight) }
    func wristTemperature(from dateRange: DateRangeType) async throws -> WristTemperature { try await fetch(stubbedWristTemperature) }

    func saveBasalBodyTemperature(model: BasalBodyTemperature, extra: [String: Sendable]?) async throws { try await save() }
    func saveBodyFatPercentage(model: BodyFatPercentage, extra: [String: Sendable]?) async throws { try await save() }
    func saveBodyMassIndex(model: BodyMassIndex, extra: [String: Sendable]?) async throws { try await save() }
    func saveBodyTemperature(model: BodyTemperature, extra: [String: Sendable]?) async throws { try await save() }
    func saveElectrodermalActivity(model: ElectrodermalActivity, extra: [String: Sendable]?) async throws { try await save() }
    func saveHeight(model: BodyHeight, extra: [String: Sendable]?) async throws { try await save() }
    func saveLeanBodyMass(model: LeanBodyMass, extra: [String: Sendable]?) async throws { try await save() }
    func saveWaistCircumference(model: WaistCircumference, extra: [String: Sendable]?) async throws { try await save() }
    func saveWeight(model: BodyWeight, extra: [String: Sendable]?) async throws { try await save() }
}
