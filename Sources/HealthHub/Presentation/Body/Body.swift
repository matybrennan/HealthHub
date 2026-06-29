//
//  Body.swift
//  HealthHub
//
//  Created by matybrennan on 20/9/19.
//

import Foundation

public struct BasalBodyTemperature: Sendable {

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

    /// Most recent reading
    public var mostRecent: Item? { items.first }
}

public struct BodyWeight: Sendable {

    public struct Item: Sendable {
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

    /// Most recent reading
    public var mostRecent: Item? { items.first }
}

public struct LeanBodyMass: Sendable {

    public struct Item: Sendable {
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

    /// Most recent reading
    public var mostRecent: Item? { items.first }
}

public struct BodyHeight: Sendable {

    public struct Item: Sendable {
        public let cm: Double
        public let inches: Double
        public let date: Date

        public init(cm: Double, inches: Double, date: Date) {
            self.cm = cm
            self.inches = inches
            self.date = date
        }

        /// Height in feet and inches (e.g. 5'11")
        public var feetAndInches: String {
            let totalInches = Int(inches)
            let feet = totalInches / 12
            let remainingInches = totalInches % 12
            return "\(feet)'\(remainingInches)\""
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent reading
    public var mostRecent: Item? { items.first }
}

public struct BodyFatPercentage: Sendable {

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

    /// Most recent reading
    public var mostRecent: Item? { items.first }
}

public struct BodyMassIndex: Sendable {

    public enum Classification: String, Sendable {
        case underweight = "Underweight"
        case normal = "Normal"
        case overweight = "Overweight"
        case obese = "Obese"

        public init(bmi: Double) {
            switch bmi {
            case ..<18.5: self = .underweight
            case 18.5..<25.0: self = .normal
            case 25.0..<30.0: self = .overweight
            default: self = .obese
            }
        }
    }

    public struct Item: Sendable {
        public let value: Double
        public let date: Date

        public init(value: Double, date: Date) {
            self.value = value
            self.date = date
        }

        /// WHO BMI classification
        public var classification: Classification {
            Classification(bmi: value)
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent reading
    public var mostRecent: Item? { items.first }
}

public struct WaistCircumference: Sendable {

    public struct Item: Sendable {
        public let cm: Double
        public let inches: Double
        public let date: Date

        public init(cm: Double, inches: Double, date: Date) {
            self.cm = cm
            self.inches = inches
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent reading
    public var mostRecent: Item? { items.first }
}

public struct ElectrodermalActivity: Sendable {

    public struct Item: Sendable {
        /// Value in microsiemens (μS)
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

    /// Most recent reading
    public var mostRecent: Item? { items.first }
}

public struct WristTemperature: Sendable {

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

    /// Most recent reading
    public var mostRecent: Item? { items.first }
}
