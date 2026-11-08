import Testing
import Foundation
@testable import HealthHub

@Suite("CDA Document Model Suite")
struct CDADocumentModelTests {

    @Test("Most recent CDA document uses the latest end date")
    func mostRecentCDADocument() {
        let olderDate = Date(timeIntervalSince1970: 100)
        let newerDate = Date(timeIntervalSince1970: 200)
        let model = CDADocument(items: [
            CDADocument.Item(
                title: "Discharge Summary",
                patientName: "Taylor Jones",
                authorName: "Dr. Smith",
                custodianName: "HealthHub Hospital",
                documentData: Data("older".utf8),
                startDate: olderDate,
                endDate: olderDate
            ),
            CDADocument.Item(
                title: "Visit Summary",
                patientName: "Taylor Jones",
                authorName: "Dr. Patel",
                custodianName: "HealthHub Clinic",
                documentData: Data("newer".utf8),
                startDate: newerDate,
                endDate: newerDate
            )
        ])

        #expect(model.mostRecent?.title == "Visit Summary")
        #expect(model.mostRecent?.authorName == "Dr. Patel")
    }

    @Test("Document count with XML data ignores missing payloads")
    func documentsWithDataCount() {
        let date = Date(timeIntervalSince1970: 100)
        let model = CDADocument(items: [
            CDADocument.Item(title: "One", patientName: "Patient", authorName: nil, custodianName: nil, documentData: Data("xml".utf8), startDate: date, endDate: date),
            CDADocument.Item(title: "Two", patientName: "Patient", authorName: nil, custodianName: nil, documentData: nil, startDate: date, endDate: date)
        ])

        #expect(model.documentsWithDataCount == 1)
    }

    @Test("CDA document item preserves parsed properties")
    func cdaDocumentItemPreservesMetadata() {
        let startDate = Date(timeIntervalSince1970: 300)
        let endDate = Date(timeIntervalSince1970: 360)
        let data = Data("<ClinicalDocument />".utf8)
        let item = CDADocument.Item(
            title: "Clinical Document",
            patientName: "Jordan Doe",
            authorName: "Dr. Lee",
            custodianName: "Regional Medical Center",
            documentData: data,
            startDate: startDate,
            endDate: endDate
        )

        #expect(item.title == "Clinical Document")
        #expect(item.patientName == "Jordan Doe")
        #expect(item.authorName == "Dr. Lee")
        #expect(item.custodianName == "Regional Medical Center")
        #expect(item.documentData == data)
        #expect(item.startDate == startDate)
        #expect(item.endDate == endDate)
    }
}
