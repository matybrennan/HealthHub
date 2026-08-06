//
//  AttachmentModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/8/2026.
//

import Foundation

public struct Attachment: Sendable {
    public let identifier: String
    public let name: String?
    public let contentType: String
    public let size: Int64

    public init(identifier: String, name: String?, contentType: String, size: Int64) {
        self.identifier = identifier
        self.name = name
        self.contentType = contentType
        self.size = size
    }

    public var isEmpty: Bool {
        size == 0
    }
}
