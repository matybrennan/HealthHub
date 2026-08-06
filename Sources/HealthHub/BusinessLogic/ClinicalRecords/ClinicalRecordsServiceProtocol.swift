//
//  ClinicalRecordsServiceProtocol.swift
//  HealthHub
//
//  Created by Copilot on 7/8/2026.
//

import Foundation

public protocol ClinicalRecordsServiceProtocol {

    // Fetch
    func allergyRecord() async throws -> ClinicalRecord
    func clinicalNoteRecord() async throws -> ClinicalRecord
    func conditionRecord() async throws -> ClinicalRecord
    func immunizationRecord() async throws -> ClinicalRecord
    func labResultRecord() async throws -> ClinicalRecord
    func medicationRecord() async throws -> ClinicalRecord
    func procedureRecord() async throws -> ClinicalRecord
    func vitalSignRecord() async throws -> ClinicalRecord
    func coverageRecord() async throws -> ClinicalRecord
}
