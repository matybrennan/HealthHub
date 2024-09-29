//
//  Mindful.swift
//  HealthHub
//
//  Created by matybrennan on 24/9/19.
//

import Foundation

public struct Mindful: Sendable {

    public struct Info: Sendable {
        public let value: Int
        public let startDate: Date
        public let endDate: Date
        
        public var minutes: Int {
            Date().getDateDiff(start: startDate, end: endDate)
        }
        
        public init(value: Int, startDate: Date, endDate: Date) {
            self.value = value
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]

    public init(items: [Info]) {
        self.items = items
    }
}

extension Mindful.Info {
    
    public init(startDate: Date) {
        value = 0
        self.startDate = startDate
        self.endDate = Date()
    }
}
