import Foundation
import HealthKit
@testable import HealthHub

final class MockAttachmentsService: AttachmentsServiceProtocol {

    var shouldThrowError: Error?
    var addCallCount = 0
    var fetchCallCount = 0
    var contentCallCount = 0
    var deleteCallCount = 0

    var stubbedAttachment = Attachment(identifier: UUID().uuidString, name: "receipt.pdf", contentType: "com.adobe.pdf", size: 128)
    var stubbedAttachments: [Attachment] = []
    var stubbedContent = Data()

    func addAttachment(data: Data, name: String, contentType: String, to object: HKObject) async throws -> Attachment {
        addCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedAttachment
    }

    func attachments(for object: HKObject) async throws -> [Attachment] {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedAttachments
    }

    func attachmentContent(for attachment: Attachment, from object: HKObject) async throws -> Data {
        contentCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedContent
    }

    func deleteAttachment(_ attachment: Attachment, from object: HKObject) async throws {
        deleteCallCount += 1
        if let error = shouldThrowError { throw error }
    }
}
