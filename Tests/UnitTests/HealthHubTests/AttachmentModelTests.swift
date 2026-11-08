import Testing
import Foundation
@testable import HealthHub

@Suite("Attachment Model Suite")
struct AttachmentModelTests {

    @Test("Attachment is empty when size is zero")
    func emptyAttachment() {
        let attachment = Attachment(identifier: "1", name: nil, contentType: "public.data", size: 0)
        #expect(attachment.isEmpty == true)
    }

    @Test("Attachment preserves metadata")
    func attachmentMetadata() {
        let attachment = Attachment(identifier: "2", name: "scan.pdf", contentType: "com.adobe.pdf", size: 2_048)

        #expect(attachment.identifier == "2")
        #expect(attachment.name == "scan.pdf")
        #expect(attachment.contentType == "com.adobe.pdf")
        #expect(attachment.size == 2_048)
        #expect(attachment.isEmpty == false)
    }
}
