//
//  OtherDataModels.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation

public struct AlcoholConsumption: Sendable {

    public struct Item: Sendable {
        public let drinks: Double
        public let date: Date

        public init(drinks: Double, date: Date) {
            self.drinks = drinks
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct AlcoholContent: Sendable {

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

public struct HandWashing: Sendable {

    public struct Item: Sendable {
        public let startDate: Date
        public let endDate: Date

        public init(startDate: Date, endDate: Date) {
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct InhalerUsage: Sendable {

    public struct Item: Sendable {
        public let value: Int
        public let date: Date

        public init(value: Int, date: Date) {
            self.value = value
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct InsulinDelivery: Sendable {

    public struct Item: Sendable {

        public enum Purpose: Int, Sendable {
            case basal = 1
            case bolus
        }
        
        public let value: Double
        public let purpose: Purpose
        public let startDate: Date
        public let endDate: Date

        public init(value: Double, purpose: Purpose, startDate: Date, endDate: Date) {
            self.value = value
            self.purpose = purpose
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct NumberOfTimesFallen: Sendable {

    public struct Item: Sendable {
        public let value: Int
        public let date: Date

        public init(value: Int, date: Date) {
            self.value = value
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct ToothBrushing: Sendable {

    public struct Item: Sendable {
        public let startDate: Date
        public let endDate: Date

        public init(startDate: Date, endDate: Date) {
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]
    
    public init(items: [Item]) {
        self.items = items
    }
}

public struct UVExposure: Sendable {

    public struct Item: Sendable {
        public let value: Int
        public let startDate: Date
        public let endDate: Date

        public init(value: Int, startDate: Date, endDate: Date) {
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

public struct TimeInDaylight: Sendable {

    public struct Item: Sendable {
        public let startDate: Date
        public let endDate: Date

        public init(startDate: Date, endDate: Date) {
            self.startDate = startDate
            self.endDate = endDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WaterTemperature: Sendable {

    public struct Item: Sendable {
        public let celsius: Double
        public let fahrenheit: Double
        public let date: Date
        
        public init(celsius: Double, fahrenheit: Double, date: Date) {
            self.celsius = celsius
            self.fahrenheit = fahrenheit
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}


