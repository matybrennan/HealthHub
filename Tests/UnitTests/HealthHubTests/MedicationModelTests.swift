import Testing
import Foundation
@testable import HealthHub

@Suite("Medication Model Suite")
struct MedicationModelTests {

    @Test("Taken and skipped doses are treated differently")
    func doseStatusLogging() {
        #expect(Medications.DoseEvent.Status.taken.isLogged == true)
        #expect(Medications.DoseEvent.Status.skipped.isLogged == true)
        #expect(Medications.DoseEvent.Status.snoozed.isLogged == false)
    }

    @Test("Medication counts taken doses and total events")
    func medicationCounts() {
        let now = Date()
        let doseEvents: [Medications.DoseEvent] = [
            .init(scheduledDate: now, takenDate: now, status: .taken),
            .init(scheduledDate: now.addingTimeInterval(-3600), takenDate: nil, status: .skipped),
            .init(scheduledDate: now.addingTimeInterval(-7200), takenDate: nil, status: .notInteracted)
        ]
        let item = Medications.Item(displayName: "Ibuprofen", rxNormCode: "5640", doseEvents: doseEvents)
        let model = Medications(items: [item])

        #expect(item.takenDoseCount == 1)
        #expect(item.mostRecentDoseEvent?.status == .taken)
        #expect(model.totalDoseEvents == 3)
        #expect(model.mostRecent?.displayName == "Ibuprofen")
    }
}
