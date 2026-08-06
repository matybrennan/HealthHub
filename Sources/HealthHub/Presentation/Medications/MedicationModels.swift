//
//  MedicationModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/8/2026.
//

import Foundation

public struct Medications: Sendable {

    public struct DoseEvent: Sendable {

        public enum Status: String, Sendable {
            case notInteracted = "Not Interacted"
            case notificationNotSent = "Notification Not Sent"
            case snoozed = "Snoozed"
            case taken = "Taken"
            case skipped = "Skipped"
            case notLogged = "Not Logged"

            public var isLogged: Bool {
                switch self {
                case .taken, .skipped:
                    true
                case .notInteracted, .notificationNotSent, .snoozed, .notLogged:
                    false
                }
            }
        }

        public let scheduledDate: Date?
        public let takenDate: Date?
        public let status: Status

        public init(scheduledDate: Date?, takenDate: Date?, status: Status) {
            self.scheduledDate = scheduledDate
            self.takenDate = takenDate
            self.status = status
        }
    }

    public struct Item: Sendable {
        public let displayName: String
        public let rxNormCode: String?
        public let doseEvents: [DoseEvent]

        public init(displayName: String, rxNormCode: String?, doseEvents: [DoseEvent]) {
            self.displayName = displayName
            self.rxNormCode = rxNormCode
            self.doseEvents = doseEvents
        }

        public var mostRecentDoseEvent: DoseEvent? {
            doseEvents.first
        }

        public var takenDoseCount: Int {
            doseEvents.filter { $0.status == .taken }.count
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var totalDoseEvents: Int {
        items.reduce(0) { $0 + $1.doseEvents.count }
    }

    public var mostRecent: Item? { items.first }
}
