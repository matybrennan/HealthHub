//
//  CDADocumentModels.swift
//  HealthHub
//
//  Created by Copilot on 7/8/2026.
//

import Foundation

public struct CDADocument: Sendable {

    public struct Item: Sendable {
        public let title: String?
        public let patientName: String?
        public let authorName: String?
        public let custodianName: String?
        public let documentData: Data?
        public let startDate: Date
        public let endDate: Date

        public init(title: String?, patientName: String?, authorName: String?, custodianName: String?, documentData: Data?, startDate: Date, endDate: Date) {
            self.title = title
            self.patientName = patientName
            self.authorName = authorName
            self.custodianName = custodianName
            self.documentData = documentData
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.endDate < $1.endDate })
    }

    public var documentsWithDataCount: Int {
        items.count { $0.documentData != nil }
    }
}
