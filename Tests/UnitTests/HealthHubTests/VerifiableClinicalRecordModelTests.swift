import Testing
import Foundation
@testable import HealthHub

@Suite("Verifiable Clinical Record Model Suite")
struct VerifiableClinicalRecordModelTests {

    @Test("Payload size reflects raw signed payload bytes")
    func payloadSize() {
        let item = VerifiableClinicalRecords.Item(
            subject: VerifiableClinicalRecords.Subject(fullName: "Taylor Smith", dateOfBirth: nil),
            sourceOrganization: "Example Issuer",
            relevantDate: Date(),
            recordTypes: ["immunization"],
            signedPayloadData: Data([0x01, 0x02, 0x03])
        )

        #expect(item.payloadSize == 3)
    }

    @Test("All record types are deduplicated and sorted")
    func allRecordTypes() {
        let now = Date()
        let model = VerifiableClinicalRecords(items: [
            .init(
                subject: .init(fullName: "Taylor Smith", dateOfBirth: nil),
                sourceOrganization: "Issuer A",
                relevantDate: now,
                recordTypes: ["laboratory", "immunization"],
                signedPayloadData: Data([0x01])
            ),
            .init(
                subject: .init(fullName: "Jordan Smith", dateOfBirth: nil),
                sourceOrganization: "Issuer B",
                relevantDate: now.addingTimeInterval(-60),
                recordTypes: ["covid19", "laboratory"],
                signedPayloadData: Data([0x02, 0x03])
            )
        ])

        #expect(model.allRecordTypes == ["covid19", "immunization", "laboratory"])
        #expect(model.totalPayloadSize == 3)
        #expect(model.mostRecent?.sourceOrganization == "Issuer A")
    }
}
