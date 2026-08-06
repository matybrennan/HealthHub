//
//  VisionPrescriptionsServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/7/2026.
//

import Foundation

public protocol VisionPrescriptionsServiceProtocol {

    // MARK: - Read

    func glassesPrescriptions() async throws -> GlassesPrescription
    func contactsPrescriptions() async throws -> ContactsPrescription

    // MARK: - Save

    func saveGlassesPrescription(model: GlassesPrescription.Item, extra: [String: Sendable]?) async throws
    func saveContactsPrescription(model: ContactsPrescription.Item, extra: [String: Sendable]?) async throws
}
