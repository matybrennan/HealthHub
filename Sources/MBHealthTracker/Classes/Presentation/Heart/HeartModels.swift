//
//  HeartModels.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/12/18.
//

import Foundation

public struct HeartRate: Sendable {

    public struct Item: Sendable {
        let max: Double
        let min: Double
        let average: Double

        public init(max: Double, min: Double, average: Double) {
            self.max = max
            self.min = min
            self.average = average
        }
    }
    
    // Computed from timeIntervals and if One item
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

extension HeartRate {

    public var total: Double {
        items.reduce(0.0, { (res, item) -> Double in
            res + item.average
        })
    }
    
    public var average: Double {
        items.isEmpty ? 0.0 : total / Double(count)
    }
    
    public var first: Item? {
        items.first
    }
    
    public var last: Item? {
        items.last
    }
    
    public var count: Int {
        items.count
    }
}

public struct CardioRecovery: Sendable {

    public struct Item: Sendable {
        let bpm: Int
        let date: Date

        public init(bpm: Int, date: Date) {
            self.bpm = bpm
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct AtrialFibrillationHistory: Sendable {

    public struct Item: Sendable {
        
        let percentage: Double
        let startDate: Date
        let endDate: Date

        public init(percentage: Double, startDate: Date, endDate: Date) {
            self.percentage = percentage
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct PeripheralPerfusionIndex: Sendable {

    public struct Item: Sendable {
        public let percentage: Double
        public let date: Date

        public init(percentage: Double, date: Date) {
            self.percentage = percentage
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}
