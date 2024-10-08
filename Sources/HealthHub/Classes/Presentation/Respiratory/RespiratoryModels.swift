//
//  RespiratoryModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/9/2022.
//

import Foundation

public struct RespiratoryRate: Sendable {

    public struct Item: Sendable {
        public let value: Double // counts per min
        public let startDate: Date
        public let endDate: Date
        
        public init(value: Double, startDate: Date, endDate: Date) {
            self.value = value
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct ForcedExpiratoryVolume: Sendable {

    public struct Item: Sendable {
        public let liters: Double
        public let date: Date
        
        public init(liters: Double, date: Date) {
            self.liters = liters
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct ForcedVitalCapacity: Sendable {

    public struct Item: Sendable {
        public let liters: Double
        public let date: Date
        
        public init(liters: Double, date: Date) {
            self.liters = liters
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct PeakExpiratoryFlowRate: Sendable {

    public struct Item: Sendable {
        public let litersPerMinute: Double
        public let date: Date
        
        public init(litersPerMinute: Double, date: Date) {
            self.litersPerMinute = litersPerMinute
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct SixMinuteWalk: Sendable {

    public struct Item: Sendable {
        public let distance: Double // mtrs
        public let startDate: Date
        public let endDate: Date

        public init(distance: Double, startDate: Date, endDate: Date) {
            self.distance = distance
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}
