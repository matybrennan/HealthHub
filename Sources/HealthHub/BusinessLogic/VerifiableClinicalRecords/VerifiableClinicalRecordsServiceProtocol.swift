//
//  VerifiableClinicalRecordsServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/8/2026.
//

import Foundation

public protocol VerifiableClinicalRecordsServiceProtocol {

    // Fetch
    func verifiableClinicalRecords() async throws -> VerifiableClinicalRecords
}
