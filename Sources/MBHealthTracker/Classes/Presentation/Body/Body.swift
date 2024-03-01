//
//  Body.swift
//  MBHealthTracker
//
//  Created by matybrennan on 20/9/19.
//

import Foundation

public struct BasalBodyTemperature {

    public struct Item {
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

public struct BodyWeight {
    
    public struct Item {
        public let kg: Double
        public let lbs: Double
        public let date: Date

        public init(kg: Double, lbs: Double, date: Date) {
            self.kg = kg
            self.lbs = lbs
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct LeanBodyMass {
    
    public struct Item {
        public let kg: Double
        public let lbs: Double
        public let date: Date

        public init(kg: Double, lbs: Double, date: Date) {
            self.kg = kg
            self.lbs = lbs
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct BodyHeight {
    
    public struct Item {
        public let inches: Int
        public let cm: Int
        public let date: Date

        public init(inches: Int, cm: Int, date: Date) {
            self.inches = inches
            self.cm = cm
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct BodyFatPercentage {

    public struct Item {
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

public struct BodyMassIndex {
    
    public struct Item {
        public let value: Double
        public let date: Date

        public init(value: Double, date: Date) {
            self.value = value
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WaistCircumference {
    
    public struct Item {
        public let inches: Int
        public let cm: Int
        public let date: Date

        public init(inches: Int, cm: Int, date: Date) {
            self.inches = inches
            self.cm = cm
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct ElectrodermalActivity {
    
    public struct Item {
        public let value: Double
        public let date: Date

        public init(value: Double, date: Date) {
            self.value = value
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WristTemperature {

    public struct Item {
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
