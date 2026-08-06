//
//  AttachmentsServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/8/2026.
//

import Foundation
import HealthKit

public protocol AttachmentsServiceProtocol {

    // Read / Write
    func addAttachment(data: Data, name: String, contentType: String, to object: HKObject) async throws -> Attachment
    func attachments(for object: HKObject) async throws -> [Attachment]
    func attachmentContent(for attachment: Attachment, from object: HKObject) async throws -> Data
    func deleteAttachment(_ attachment: Attachment, from object: HKObject) async throws
}
