//
//  MedicationsServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/8/2026.
//

import Foundation

public protocol MedicationsServiceProtocol {

    // Fetch
    func medications() async throws -> Medications
}
