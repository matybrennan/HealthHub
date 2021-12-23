//
//  Vitals.swift
//  MBHealthTracker
//
//  Created by matybrennan on 9/12/19.
//

import Foundation

public struct BloodPressure {
    
    public struct Info {
        public let systolic: Double
        public let diastolic: Double
        public let startDate: Date
        public let endDate: Date
        
        public var value: String {
            return "\(systolic) / \(diastolic)"
        }
        
        public init(systolic: Double, diastolic: Double, startDate: Date, endDate: Date) {
            self.systolic = systolic
            self.diastolic = diastolic
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]    
}

public struct RespiratoryRate {
    
    public struct Info {
        public let value: Double // counts per min
        public let startDate: Date
        public let endDate: Date
        
        public init(value: Double, startDate: Date, endDate: Date) {
            self.value = value
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]
}

public struct BodyTemperature {
    
    public struct Info {
        public let celsius: Double
        public let fahrenheit: Double
        public let startDate: Date
        public let endDate: Date
        
        public init(celsius: Double, fahrenheit: Double, startDate: Date, endDate: Date) {
            self.celsius = celsius
            self.fahrenheit = fahrenheit
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]
}

public struct BloodGlucose {
    
    public struct Item {
        
        public enum MealTime: Int {
            case unspecified
            case beforeMeal
            case afterMeal
        }
        
        public let date: Date
        public let bloodGlucose: Double
        public let mealTime: MealTime
        
        public init(date: Date, bloodGlucose: Double, mealTime: MealTime) {
            self.date = date
            self.bloodGlucose = bloodGlucose
            self.mealTime = mealTime
        }
    }
    
    public let items: [Item]
}

public struct BloodOxygen {
    
    public struct Item {
        
        public let date: Date
        public let oxygenSaturationPercentage: Double
        
        public init(date: Date, oxygenSaturationPercentage: Double) {
            self.date = date
            self.oxygenSaturationPercentage = oxygenSaturationPercentage
        }
    }
    
    public let items: [Item]
}
