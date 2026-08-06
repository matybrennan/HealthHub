import Testing
import Foundation
@testable import HealthHub

@Suite("Clinical Records Model Suite")
struct ClinicalRecordsModelTests {

    @Test("Most recent clinical record uses the latest start date")
    func mostRecentClinicalRecord() {
        let olderDate = Date(timeIntervalSince1970: 100)
        let newerDate = Date(timeIntervalSince1970: 200)
        let model = ClinicalRecord(items: [
            ClinicalRecord.Item(
                displayName: "Peanut Allergy",
                providerName: "Clinic A",
                startDate: olderDate,
                fhirResourceType: "AllergyIntolerance",
                fhirData: Data("older".utf8),
                fhirVersion: "4.0.1",
                sourceURL: URL(string: "https://example.com/allergy")
            ),
            ClinicalRecord.Item(
                displayName: "Seasonal Allergy",
                providerName: "Clinic B",
                startDate: newerDate,
                fhirResourceType: "AllergyIntolerance",
                fhirData: Data("newer".utf8),
                fhirVersion: "4.0.1",
                sourceURL: URL(string: "https://example.com/allergy/new")
            )
        ])

        #expect(model.mostRecent?.displayName == "Seasonal Allergy")
        #expect(model.mostRecent?.providerName == "Clinic B")
    }

    @Test("FHIR-backed record count ignores records without raw data")
    func recordsWithFHIRDataCount() {
        let date = Date(timeIntervalSince1970: 100)
        let model = ClinicalRecord(items: [
            ClinicalRecord.Item(displayName: "Condition", providerName: nil, startDate: date, fhirResourceType: "Condition", fhirData: Data("condition".utf8), fhirVersion: "4.0.1", sourceURL: nil),
            ClinicalRecord.Item(displayName: "Medication", providerName: nil, startDate: date, fhirResourceType: "MedicationRequest", fhirData: nil, fhirVersion: nil, sourceURL: nil)
        ])

        #expect(model.recordsWithFHIRDataCount == 1)
    }

    @Test("Clinical record preserves optional FHIR metadata")
    func clinicalRecordItemPreservesMetadata() {
        let startDate = Date(timeIntervalSince1970: 300)
        let data = Data("lab-result".utf8)
        let url = URL(string: "https://example.com/labs/1")
        let item = ClinicalRecord.Item(
            displayName: "Lab Result",
            providerName: "Hospital",
            startDate: startDate,
            fhirResourceType: "Observation",
            fhirData: data,
            fhirVersion: "4.0.1",
            sourceURL: url
        )

        #expect(item.displayName == "Lab Result")
        #expect(item.providerName == "Hospital")
        #expect(item.startDate == startDate)
        #expect(item.fhirResourceType == "Observation")
        #expect(item.fhirData == data)
        #expect(item.fhirVersion == "4.0.1")
        #expect(item.sourceURL == url)
    }
}
