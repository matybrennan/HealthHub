//
//  Mindful.swift
//  MBHealthTracker
//
//  Created by matybrennan on 24/9/19.
//

import Foundation

public struct Mindful {
    
    public struct Info {
        public let value: Int
        public let startDate: Date
        public let endDate: Date
        
        public var minutes: Int {
            return Date().getDateDiff(start: startDate, end: endDate)
        }
        
        public init(value: Int, startDate: Date, endDate: Date) {
            self.value = value
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]
}

extension Mindful.Info {
    
    public init(startDate: Date) {
        value = 0
        self.startDate = startDate
        self.endDate = Date()
    }
}
