//
//  VerifiableClinicalRecordsService.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/8/2026.
//

import Foundation
import HealthKit

public final class VerifiableClinicalRecordsService {

    private static let sourceTypes: [HKVerifiableClinicalRecordSourceType] = [.smartHealthCard, .euDigitalCOVIDCertificate]
    private static let recordTypes: [HKVerifiableClinicalRecordCredentialType] = [.covid19, .immunization, .laboratory, .recovery]

    public init() { }
}

// MARK: - VerifiableClinicalRecordsServiceProtocol
extension VerifiableClinicalRecordsService: VerifiableClinicalRecordsServiceProtocol {

    public func verifiableClinicalRecords() async throws -> VerifiableClinicalRecords {
        try ensureHealthDataAvailable()

        var recordsByIdentifier: [UUID: VerifiableClinicalRecords.Item] = [:]

        for recordType in Self.recordTypes {
            let descriptor = HKVerifiableClinicalRecordQueryDescriptor(recordTypes: [recordType], sourceTypes: Self.sourceTypes)
            let records = try await descriptor.result(for: HealthStoreProvider.shared)

            for record in records {
                recordsByIdentifier[record.uuid] = VerifiableClinicalRecords.Item(
                    subject: VerifiableClinicalRecords.Subject(
                        fullName: record.subject.fullName,
                        dateOfBirth: record.subject.dateOfBirthComponents
                    ),
                    sourceOrganization: record.issuerIdentifier,
                    relevantDate: record.relevantDate,
                    recordTypes: record.recordTypes,
                    signedPayloadData: record.dataRepresentation
                )
            }
        }

        let items = recordsByIdentifier.values.sorted { $0.relevantDate > $1.relevantDate }
        return VerifiableClinicalRecords(items: items)
    }
}
