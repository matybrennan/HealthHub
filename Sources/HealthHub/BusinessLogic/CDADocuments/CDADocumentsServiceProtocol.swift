//
//  CDADocumentsServiceProtocol.swift
//  HealthHub
//
//  Created by Copilot on 7/8/2026.
//

import Foundation

public protocol CDADocumentsServiceProtocol {

    // Fetch
    func cdaDocuments() async throws -> CDADocument
}
