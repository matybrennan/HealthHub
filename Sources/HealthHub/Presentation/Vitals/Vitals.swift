//
//  Vitals.swift
//  HealthHub
//
//  Created by matybrennan on 9/12/19.
//

import Foundation

public struct BloodPressure: Sendable {

    public enum Classification: String, Sendable {
        case normal = "Normal"
        case elevated = "Elevated"
        case highStage1 = "High (Stage 1)"
        case highStage2 = "High (Stage 2)"
        case hypertensiveCrisis = "Hypertensive Crisis"
    }

    public struct Info: Sendable {
        public let systolic: Double
        public let diastolic: Double
        public let unit: String
        public let startDate: Date
        public let endDate: Date
        
        public var value: String {
            "\(Int(systolic))/\(Int(diastolic)) \(unit)"
        }

        /// AHA blood pressure classification
        public var classification: Classification {
            if systolic >= 180 || diastolic >= 120 {
                return .hypertensiveCrisis
            } else if systolic >= 140 || diastolic >= 90 {
                return .highStage2
            } else if systolic >= 130 || diastolic >= 80 {
                return .highStage1
            } else if systolic >= 120 && diastolic < 80 {
                return .elevated
            } else {
                return .normal
            }
        }
        
        public init(systolic: Double, diastolic: Double, unit: String = "mmHg", startDate: Date, endDate: Date) {
            self.systolic = systolic
            self.diastolic = diastolic
            self.unit = unit
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]

    public init(items: [Info]) {
        self.items = items
    }

    /// Most recent reading
    public var mostRecent: Info? { items.first }
}

public struct BodyTemperature: Sendable {

    public struct Item: Sendable {
        public let celsius: Double
        public let fahrenheit: Double
        public let startDate: Date
        public let endDate: Date

        /// Whether this reading indicates a fever (≥38.0°C / 100.4°F)
        public var isFever: Bool {
            celsius >= 38.0
        }
        
        public init(celsius: Double, fahrenheit: Double, startDate: Date, endDate: Date) {
            self.celsius = celsius
            self.fahrenheit = fahrenheit
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent reading
    public var mostRecent: Item? { items.first }
}

public struct BloodGlucose: Sendable {

    public enum Classification: String, Sendable {
        case normal = "Normal"
        case prediabetes = "Prediabetes"
        case diabetes = "Diabetes"
    }

    public struct Item: Sendable {

        public enum MealTime: Int, Sendable {
            case unspecified
            case beforeMeal
            case afterMeal

            public var name: String {
                switch self {
                case .unspecified: return "Unspecified"
                case .beforeMeal: return "Before Meal"
                case .afterMeal: return "After Meal"
                }
            }
        }
        
        public let bloodGlucose: Double
        public let unit: String
        public let mealTime: MealTime
        public let startDate: Date
        public let endDate: Date

        /// Fasting glucose classification (most meaningful for beforeMeal readings)
        public var fastingClassification: Classification {
            if bloodGlucose >= 126 {
                return .diabetes
            } else if bloodGlucose >= 100 {
                return .prediabetes
            } else {
                return .normal
            }
        }
        
        public init(bloodGlucose: Double, unit: String = "mg/dL", mealTime: MealTime, startDate: Date, endDate: Date) {
            self.bloodGlucose = bloodGlucose
            self.unit = unit
            self.mealTime = mealTime
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent reading
    public var mostRecent: Item? { items.first }
}

public struct BloodOxygen: Sendable {

    public enum Classification: String, Sendable {
        case normal = "Normal"
        case low = "Low"
    }

    public struct Item: Sendable {
        public let oxygenSaturationPercentage: Double
        public let startDate: Date
        public let endDate: Date

        /// SpO2 classification (normal ≥ 95%)
        public var classification: Classification {
            oxygenSaturationPercentage >= 95 ? .normal : .low
        }
        
        public init(oxygenSaturationPercentage: Double, startDate: Date, endDate: Date) {
            self.oxygenSaturationPercentage = oxygenSaturationPercentage
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent reading
    public var mostRecent: Item? { items.first }
}
