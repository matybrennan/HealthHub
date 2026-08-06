//
//  ClinicalRecordsService.swift
//  HealthHub
//
//  Created by Copilot on 7/8/2026.
//

import Foundation
import HealthKit

public final class ClinicalRecordsService {

    public init() { }
}

private protocol FetchClinicalSample {
    func fetchClinicalSamples(clinicalIdentifier: HKClinicalTypeIdentifier, predicate: NSPredicate?, sortDescriptors: [SortDescriptor<HKClinicalRecord>], limit: Int?) async throws -> [HKClinicalRecord]
}

extension FetchClinicalSample {
    func fetchClinicalSamples(clinicalIdentifier: HKClinicalTypeIdentifier, predicate: NSPredicate? = nil, sortDescriptors: [SortDescriptor<HKClinicalRecord>] = [], limit: Int? = nil) async throws -> [HKClinicalRecord] {
        try ensureHealthDataAvailable()
        let type = HKClinicalType(clinicalIdentifier)
        let descriptor = HKSampleQueryDescriptor(predicates: [.clinicalRecord(type: type, predicate: predicate)], sortDescriptors: sortDescriptors, limit: limit)
        return try await descriptor.result(for: HealthStoreProvider.shared)
    }
}

// MARK: - FetchClinicalSample
extension ClinicalRecordsService: FetchClinicalSample { }

// MARK: - Private methods
private extension ClinicalRecordsService {

    func fetchClinicalRecord(identifier: HKClinicalTypeIdentifier) async throws -> ClinicalRecord {
        let sortDescriptor = SortDescriptor(\HKClinicalRecord.endDate, order: .reverse)
        let samples = try await fetchClinicalSamples(clinicalIdentifier: identifier, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> ClinicalRecord.Item in
            let fhirResource = item.fhirResource
            let providerName = item.sourceRevision.source.name
            return ClinicalRecord.Item(
                displayName: item.displayName,
                providerName: providerName.isEmpty ? nil : providerName,
                startDate: item.startDate,
                fhirResourceType: fhirResource?.resourceType.rawValue,
                fhirData: fhirResource?.data,
                fhirVersion: fhirResource?.fhirVersion.stringRepresentation,
                sourceURL: fhirResource?.sourceURL
            )
        }

        return ClinicalRecord(items: items)
    }
}

// MARK: - ClinicalRecordsServiceProtocol
extension ClinicalRecordsService: ClinicalRecordsServiceProtocol {

    public func allergyRecord() async throws -> ClinicalRecord {
        try await fetchClinicalRecord(identifier: .allergyRecord)
    }

    public func clinicalNoteRecord() async throws -> ClinicalRecord {
        try await fetchClinicalRecord(identifier: .clinicalNoteRecord)
    }

    public func conditionRecord() async throws -> ClinicalRecord {
        try await fetchClinicalRecord(identifier: .conditionRecord)
    }

    public func immunizationRecord() async throws -> ClinicalRecord {
        try await fetchClinicalRecord(identifier: .immunizationRecord)
    }

    public func labResultRecord() async throws -> ClinicalRecord {
        try await fetchClinicalRecord(identifier: .labResultRecord)
    }

    public func medicationRecord() async throws -> ClinicalRecord {
        try await fetchClinicalRecord(identifier: .medicationRecord)
    }

    public func procedureRecord() async throws -> ClinicalRecord {
        try await fetchClinicalRecord(identifier: .procedureRecord)
    }

    public func vitalSignRecord() async throws -> ClinicalRecord {
        try await fetchClinicalRecord(identifier: .vitalSignRecord)
    }

    public func coverageRecord() async throws -> ClinicalRecord {
        try await fetchClinicalRecord(identifier: .coverageRecord)
    }
}
