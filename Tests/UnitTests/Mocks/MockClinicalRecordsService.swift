import Foundation
@testable import HealthHub

final class MockClinicalRecordsService: ClinicalRecordsServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0

    var stubbedAllergyRecord = ClinicalRecord(items: [])
    var stubbedClinicalNoteRecord = ClinicalRecord(items: [])
    var stubbedConditionRecord = ClinicalRecord(items: [])
    var stubbedImmunizationRecord = ClinicalRecord(items: [])
    var stubbedLabResultRecord = ClinicalRecord(items: [])
    var stubbedMedicationRecord = ClinicalRecord(items: [])
    var stubbedProcedureRecord = ClinicalRecord(items: [])
    var stubbedVitalSignRecord = ClinicalRecord(items: [])
    var stubbedCoverageRecord = ClinicalRecord(items: [])

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    func allergyRecord() async throws -> ClinicalRecord { try await fetch(stubbedAllergyRecord) }
    func clinicalNoteRecord() async throws -> ClinicalRecord { try await fetch(stubbedClinicalNoteRecord) }
    func conditionRecord() async throws -> ClinicalRecord { try await fetch(stubbedConditionRecord) }
    func immunizationRecord() async throws -> ClinicalRecord { try await fetch(stubbedImmunizationRecord) }
    func labResultRecord() async throws -> ClinicalRecord { try await fetch(stubbedLabResultRecord) }
    func medicationRecord() async throws -> ClinicalRecord { try await fetch(stubbedMedicationRecord) }
    func procedureRecord() async throws -> ClinicalRecord { try await fetch(stubbedProcedureRecord) }
    func vitalSignRecord() async throws -> ClinicalRecord { try await fetch(stubbedVitalSignRecord) }
    func coverageRecord() async throws -> ClinicalRecord { try await fetch(stubbedCoverageRecord) }
}
