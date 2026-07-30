import Foundation
import HealthKit
@testable import HealthHub

final class MockCycleTracking: CycleTrackingProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0
    var saveCallCount = 0

    var stubbedSymptom = GenericSymptomModel(items: [], type: HKCategoryType(.abdominalCramps))
    var stubbedCervicalMucusQuality = CervicalMucusQuality(items: [])
    var stubbedContraceptive = Contraceptive(items: [])
    var stubbedLactation = Lactation(items: [])
    var stubbedMenstruation = Menstruation(items: [])
    var stubbedOvulation = Ovulation(items: [])
    var stubbedPregnancy = Pregnancy(items: [])
    var stubbedPregnancyTestResult = PregnancyTestResult(items: [])
    var stubbedProgesteroneTestResult = ProgesteroneTestResult(items: [])
    var stubbedSexualActivity = SexualActivity(items: [])
    var stubbedSpotting = Spotting(items: [])
    var stubbedInfrequentCycles = CycleNotification(notificationType: .infrequentMenstrualCycles, items: [])
    var stubbedIrregularCycles = CycleNotification(notificationType: .irregularMenstrualCycles, items: [])
    var stubbedPersistentBleeding = CycleNotification(notificationType: .persistentIntermenstrualBleeding, items: [])
    var stubbedProlongedPeriods = CycleNotification(notificationType: .prolongedMenstrualPeriods, items: [])

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    private func save() async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }

    // MARK: - Fetch

    func abdominalCramps() async throws -> GenericSymptomModel { try await fetch(stubbedSymptom) }
    func bloating() async throws -> GenericSymptomModel { try await fetch(stubbedSymptom) }
    func breastPain() async throws -> GenericSymptomModel { try await fetch(stubbedSymptom) }
    func cervicalMucusQuality() async throws -> CervicalMucusQuality { try await fetch(stubbedCervicalMucusQuality) }
    func contraceptive() async throws -> Contraceptive { try await fetch(stubbedContraceptive) }
    func lactation() async throws -> Lactation { try await fetch(stubbedLactation) }
    func menstruation() async throws -> Menstruation { try await fetch(stubbedMenstruation) }
    func moodChanges() async throws -> GenericSymptomModel { try await fetch(stubbedSymptom) }
    func ovulation() async throws -> Ovulation { try await fetch(stubbedOvulation) }
    func pregnancy() async throws -> Pregnancy { try await fetch(stubbedPregnancy) }
    func pregnancyTestResult() async throws -> PregnancyTestResult { try await fetch(stubbedPregnancyTestResult) }
    func progesteroneTestResult() async throws -> ProgesteroneTestResult { try await fetch(stubbedProgesteroneTestResult) }
    func sexualActivity() async throws -> SexualActivity { try await fetch(stubbedSexualActivity) }
    func spotting() async throws -> Spotting { try await fetch(stubbedSpotting) }
    func vaginalDryness() async throws -> GenericSymptomModel { try await fetch(stubbedSymptom) }
    func infrequentMenstrualCycles() async throws -> CycleNotification { try await fetch(stubbedInfrequentCycles) }
    func irregularMenstrualCycles() async throws -> CycleNotification { try await fetch(stubbedIrregularCycles) }
    func persistentIntermenstrualBleeding() async throws -> CycleNotification { try await fetch(stubbedPersistentBleeding) }
    func prolongedMenstrualPeriods() async throws -> CycleNotification { try await fetch(stubbedProlongedPeriods) }

    // MARK: - Save

    func saveAbdominalCramps(model: GenericSymptomModel, extra: [String: Sendable]?) async throws { try await save() }
    func saveBloating(model: GenericSymptomModel, extra: [String: Sendable]?) async throws { try await save() }
    func saveBreastPain(model: GenericSymptomModel, extra: [String: Sendable]?) async throws { try await save() }
    func saveCervicalMucusQuality(model: CervicalMucusQuality, extra: [String: Sendable]?) async throws { try await save() }
    func saveContraceptive(model: Contraceptive, extra: [String: Sendable]?) async throws { try await save() }
    func saveLactation(model: Lactation, extra: [String: Sendable]?) async throws { try await save() }
    func saveMenstruation(model: Menstruation, extra: [String: Sendable]?) async throws { try await save() }
    func saveMoodChanges(model: GenericSymptomModel, extra: [String: Sendable]?) async throws { try await save() }
    func saveOvulation(model: Ovulation, extra: [String: Sendable]?) async throws { try await save() }
    func savePregnancy(model: Pregnancy, extra: [String: Sendable]?) async throws { try await save() }
    func savePregnancyTestResult(model: PregnancyTestResult, extra: [String: Sendable]?) async throws { try await save() }
    func saveProgesteroneTestResult(model: ProgesteroneTestResult, extra: [String: Sendable]?) async throws { try await save() }
    func saveSexualActivity(model: SexualActivity, extra: [String: Sendable]?) async throws { try await save() }
    func saveSpotting(model: Spotting, extra: [String: Sendable]?) async throws { try await save() }
    func saveVaginalDryness(model: GenericSymptomModel, extra: [String: Sendable]?) async throws { try await save() }
}
