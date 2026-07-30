import Foundation
@testable import HealthHub

final class MockOtherDataService: OtherDataServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0
    var saveCallCount = 0

    var stubbedAlcoholConsumption = AlcoholConsumption(items: [])
    var stubbedBloodAlcoholContent = AlcoholContent(items: [])
    var stubbedBloodGlucose = BloodGlucose(items: [])
    var stubbedEnvironmentalAudioExposure = EnvironmentalAudioExposure(items: [])
    var stubbedHandWashing = HandWashing(items: [])
    var stubbedHeadphoneAudioExposure = HeadphoneAudioExposure(items: [])
    var stubbedInhalerUsage = InhalerUsage(items: [])
    var stubbedInsulinDelivery = InsulinDelivery(items: [])
    var stubbedNumberOfTimesFallen = NumberOfTimesFallen(items: [])
    var stubbedSexualActivity = SexualActivity(items: [])
    var stubbedToothBrushing = ToothBrushing(items: [])
    var stubbedTimeInDaylight = TimeInDaylight(items: [])
    var stubbedUVExposure = UVExposure(items: [])
    var stubbedWaterTemperature = WaterTemperature(items: [])

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    private func save() async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }

    func alcoholConsumption() async throws -> AlcoholConsumption { try await fetch(stubbedAlcoholConsumption) }
    func bloodAlcoholContent() async throws -> AlcoholContent { try await fetch(stubbedBloodAlcoholContent) }
    func bloodGlucose() async throws -> BloodGlucose { try await fetch(stubbedBloodGlucose) }
    func environmentalAudioExposure() async throws -> EnvironmentalAudioExposure { try await fetch(stubbedEnvironmentalAudioExposure) }
    func handWashing() async throws -> HandWashing { try await fetch(stubbedHandWashing) }
    func headphoneAudioExposure() async throws -> HeadphoneAudioExposure { try await fetch(stubbedHeadphoneAudioExposure) }
    func inhalerUsage() async throws -> InhalerUsage { try await fetch(stubbedInhalerUsage) }
    func insulinDelivery() async throws -> InsulinDelivery { try await fetch(stubbedInsulinDelivery) }
    func numberOfTimesFallen() async throws -> NumberOfTimesFallen { try await fetch(stubbedNumberOfTimesFallen) }
    func sexualActivity() async throws -> SexualActivity { try await fetch(stubbedSexualActivity) }
    func toothBrushing() async throws -> ToothBrushing { try await fetch(stubbedToothBrushing) }
    func timeInDaylight() async throws -> TimeInDaylight { try await fetch(stubbedTimeInDaylight) }
    func uvExposure() async throws -> UVExposure { try await fetch(stubbedUVExposure) }
    func waterTemperature() async throws -> WaterTemperature { try await fetch(stubbedWaterTemperature) }

    func saveAlcoholConsumption(model: AlcoholConsumption, extra: [String: Sendable]?) async throws { try await save() }
    func saveBloodAlcoholContent(model: AlcoholContent, extra: [String: Sendable]?) async throws { try await save() }
    func saveBloodGlucose(model: BloodGlucose, extra: [String: Sendable]?) async throws { try await save() }
    func saveHandWashing(model: HandWashing, extra: [String: Sendable]?) async throws { try await save() }
    func saveInhalerUsage(model: InhalerUsage, extra: [String: Sendable]?) async throws { try await save() }
    func saveInsulinDelivery(model: InsulinDelivery, extra: [String: Sendable]?) async throws { try await save() }
    func saveNumberOfTimesFallen(model: NumberOfTimesFallen, extra: [String: Sendable]?) async throws { try await save() }
    func saveSexualActivity(model: SexualActivity, extra: [String: Sendable]?) async throws { try await save() }
    func saveToothBrushing(model: ToothBrushing, extra: [String: Sendable]?) async throws { try await save() }
    func saveTimeInDaylight(model: TimeInDaylight, extra: [String: Sendable]?) async throws { try await save() }
    func saveUvExposure(model: UVExposure, extra: [String: Sendable]?) async throws { try await save() }
    func saveWaterTemperature(model: WaterTemperature, extra: [String: Sendable]?) async throws { try await save() }
}
