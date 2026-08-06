import Foundation
@testable import HealthHub

final class MockHeartManager: HeartManagerProtocol {

    let mockHeartRate: MockHeartRateService
    var shouldThrowError: Error?
    var fetchCallCount = 0
    var saveCallCount = 0

    var stubbedAtrialFibrillation = AtrialFibrillationHistory(items: [])
    var stubbedBloodPressure = BloodPressure(items: [])
    var stubbedCardioFitness = CardioFitness(items: [])
    var stubbedCardioRecovery = CardioRecovery(items: [])
    var stubbedHeartRateVariability = HeartRateVariability(items: [])
    var stubbedHighHeartRateEvents = HighHeartRateEvent(items: [])
    var stubbedIrregularHeartRhythmEvents = IrregularHeartRhythmEvent(items: [])
    var stubbedLowHeartRateEvents = LowHeartRateEvent(items: [])
    var stubbedLowCardioFitnessEvents = LowCardioFitnessEvent(items: [])
    var stubbedHypertensionEvents = HypertensionEvent(items: [])
    var stubbedPeripheralPerfusionIndex = PeripheralPerfusionIndex(items: [])
    var stubbedRestingHeartRate = RestingHeartRate(items: [])
    var stubbedWalkingHeartRateAverage = WalkingHeartRateAverage(items: [])

    init(heartRate: MockHeartRateService = MockHeartRateService()) {
        self.mockHeartRate = heartRate
    }

    var heartRate: HeartRateServiceProtocol { mockHeartRate }

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    private func save() async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }

    func atrialFibrillation() async throws -> AtrialFibrillationHistory { try await fetch(stubbedAtrialFibrillation) }
    func bloodPressure() async throws -> BloodPressure { try await fetch(stubbedBloodPressure) }
    func cardioFitness() async throws -> CardioFitness { try await fetch(stubbedCardioFitness) }
    func cardioRecovery() async throws -> CardioRecovery { try await fetch(stubbedCardioRecovery) }
    func heartRateVariability() async throws -> HeartRateVariability { try await fetch(stubbedHeartRateVariability) }
    func highHeartRateEvents() async throws -> HighHeartRateEvent { try await fetch(stubbedHighHeartRateEvents) }
    func irregularHeartRhythmEvents() async throws -> IrregularHeartRhythmEvent { try await fetch(stubbedIrregularHeartRhythmEvents) }
    func lowHeartRateEvents() async throws -> LowHeartRateEvent { try await fetch(stubbedLowHeartRateEvents) }
    func lowCardioFitnessEvents() async throws -> LowCardioFitnessEvent { try await fetch(stubbedLowCardioFitnessEvents) }
    func hypertensionEvents() async throws -> HypertensionEvent { try await fetch(stubbedHypertensionEvents) }
    func peripheralPerfusionIndex() async throws -> PeripheralPerfusionIndex { try await fetch(stubbedPeripheralPerfusionIndex) }
    func restingHeartRate() async throws -> RestingHeartRate { try await fetch(stubbedRestingHeartRate) }
    func walkingHeartRateAverage() async throws -> WalkingHeartRateAverage { try await fetch(stubbedWalkingHeartRateAverage) }

    func saveBloodPressure(model: BloodPressure, extra: [String: Sendable]?) async throws { try await save() }
    func saveCardioFitness(model: CardioFitness, extra: [String: Sendable]?) async throws { try await save() }
    func saveCardioRecovery(model: CardioRecovery, extra: [String: Sendable]?) async throws { try await save() }
    func savePeripheralPerfusionIndex(model: PeripheralPerfusionIndex, extra: [String: Sendable]?) async throws { try await save() }
}
