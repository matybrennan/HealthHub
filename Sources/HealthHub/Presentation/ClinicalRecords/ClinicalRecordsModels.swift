//
//  ClinicalRecordsModels.swift
//  HealthHub
//
//  Created by Copilot on 7/8/2026.
//

import Foundation

public struct ClinicalRecord: Sendable {

    public struct Item: Sendable {
        public let displayName: String
        public let providerName: String?
        public let startDate: Date
        public let fhirResourceType: String?
        public let fhirData: Data?
        public let fhirVersion: String?
        public let sourceURL: URL?

        public init(displayName: String, providerName: String?, startDate: Date, fhirResourceType: String?, fhirData: Data?, fhirVersion: String?, sourceURL: URL?) {
            self.displayName = displayName
            self.providerName = providerName
            self.startDate = startDate
            self.fhirResourceType = fhirResourceType
            self.fhirData = fhirData
            self.fhirVersion = fhirVersion
            self.sourceURL = sourceURL
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.startDate < $1.startDate })
    }

    public var recordsWithFHIRDataCount: Int {
        items.count { $0.fhirData != nil }
    }
}
