//
//  MedicationsService.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/8/2026.
//

import Foundation
import HealthKit

public final class MedicationsService {

    private static let rxNormSystem = "http://www.nlm.nih.gov/research/umls/rxnorm"

    public init() { }
}

// MARK: - MedicationsServiceProtocol
extension MedicationsService: MedicationsServiceProtocol {

    public func medications() async throws -> Medications {
        try ensureHealthDataAvailable()

        let medications = try await HKUserAnnotatedMedicationQueryDescriptor().result(for: HealthStoreProvider.shared)
        var items: [Medications.Item] = []
        items.reserveCapacity(medications.count)

        for medication in medications {
            let doseEvents = try await doseEvents(for: medication)
            let item = Medications.Item(
                displayName: medication.medication.displayText,
                rxNormCode: rxNormCode(for: medication.medication),
                doseEvents: doseEvents
            )
            items.append(item)
        }

        items.sort { $0.displayName.localizedCaseInsensitiveCompare($1.displayName) == .orderedAscending }
        return Medications(items: items)
    }
}

private extension MedicationsService {

    func doseEvents(for medication: HKUserAnnotatedMedication) async throws -> [Medications.DoseEvent] {
        let predicate = HKQuery.predicateForMedicationDoseEvent(medicationConceptIdentifier: medication.medication.identifier)
        let samplePredicate = HKSamplePredicate<HKMedicationDoseEvent>.sample(type: HKObjectType.medicationDoseEventType(), predicate: predicate)
        let sortDescriptor = SortDescriptor(\HKSample.endDate, order: .reverse)
        let descriptor = HKSampleQueryDescriptor(predicates: [samplePredicate], sortDescriptors: [sortDescriptor])
        let results = try await descriptor.result(for: HealthStoreProvider.shared)

        return results.compactMap { sample -> Medications.DoseEvent? in
            guard let event = sample as? HKMedicationDoseEvent else { return nil }
            return Medications.DoseEvent(
                scheduledDate: event.scheduledDate,
                takenDate: event.logStatus == HKMedicationDoseEvent.LogStatus.taken ? event.startDate : nil,
                status: doseEventStatus(for: event.logStatus)
            )
        }
    }

    func rxNormCode(for medication: HKMedicationConcept) -> String? {
        medication.relatedCodings.first {
            $0.system.caseInsensitiveCompare(Self.rxNormSystem) == .orderedSame
        }?.code
    }

    func doseEventStatus(for status: HKMedicationDoseEvent.LogStatus) -> Medications.DoseEvent.Status {
        switch status {
        case .notInteracted:
            .notInteracted
        case .notificationNotSent:
            .notificationNotSent
        case .snoozed:
            .snoozed
        case .taken:
            .taken
        case .skipped:
            .skipped
        case .notLogged:
            .notLogged
        @unknown default:
            .notLogged
        }
    }
}
