//
//  VerifiableClinicalRecordModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/8/2026.
//

import Foundation

public struct VerifiableClinicalRecords: Sendable {

    public struct Subject: Sendable {
        public let fullName: String
        public let dateOfBirth: DateComponents?

        public init(fullName: String, dateOfBirth: DateComponents?) {
            self.fullName = fullName
            self.dateOfBirth = dateOfBirth
        }
    }

    public struct Item: Sendable {
        public let subject: Subject
        public let sourceOrganization: String
        public let relevantDate: Date
        public let recordTypes: [String]
        public let signedPayloadData: Data

        public init(subject: Subject, sourceOrganization: String, relevantDate: Date, recordTypes: [String], signedPayloadData: Data) {
            self.subject = subject
            self.sourceOrganization = sourceOrganization
            self.relevantDate = relevantDate
            self.recordTypes = recordTypes
            self.signedPayloadData = signedPayloadData
        }

        public var payloadSize: Int {
            signedPayloadData.count
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? { items.first }

    public var totalPayloadSize: Int {
        items.reduce(0) { $0 + $1.payloadSize }
    }

    public var allRecordTypes: [String] {
        Array(Set(items.flatMap(\.recordTypes))).sorted()
    }
}
