//
//  RespiratoryModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/9/2022.
//

import Foundation

public struct RespiratoryRate: Sendable {

    public struct Item: Sendable {
        public let value: Double
        public let unit: String
        public let startDate: Date
        public let endDate: Date
        
        public init(value: Double, unit: String = "breaths/min", startDate: Date, endDate: Date) {
            self.value = value
            self.unit = unit
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

public struct ForcedExpiratoryVolume: Sendable {

    public struct Item: Sendable {
        public let liters: Double
        public let startDate: Date
        public let endDate: Date
        
        public init(liters: Double, startDate: Date, endDate: Date) {
            self.liters = liters
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

public struct ForcedVitalCapacity: Sendable {

    public struct Item: Sendable {
        public let liters: Double
        public let startDate: Date
        public let endDate: Date
        
        public init(liters: Double, startDate: Date, endDate: Date) {
            self.liters = liters
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

public struct PeakExpiratoryFlowRate: Sendable {

    public struct Item: Sendable {
        public let litersPerMinute: Double
        public let startDate: Date
        public let endDate: Date
        
        public init(litersPerMinute: Double, startDate: Date, endDate: Date) {
            self.litersPerMinute = litersPerMinute
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

public struct SixMinuteWalk: Sendable {

    public struct Item: Sendable {
        public let distance: Double
        public let unit: String
        public let startDate: Date
        public let endDate: Date

        public init(distance: Double, unit: String = "m", startDate: Date, endDate: Date) {
            self.distance = distance
            self.unit = unit
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

// MARK: - FEV1/FVC Ratio

/// Computes the FEV1/FVC ratio from the most recent readings of each.
/// A normal ratio is typically ≥ 0.70 (70%). Values below may indicate obstructive lung disease.
public struct FEV1FVCRatio: Sendable {

    public enum Classification: String, Sendable {
        case normal = "Normal"
        case mildObstruction = "Mild Obstruction"
        case moderateObstruction = "Moderate Obstruction"
        case severeObstruction = "Severe Obstruction"
    }

    public let fev1: Double
    public let fvc: Double

    public init(fev1: Double, fvc: Double) {
        self.fev1 = fev1
        self.fvc = fvc
    }

    /// The ratio value (0.0–1.0+)
    public var ratio: Double {
        guard fvc > 0 else { return 0 }
        return fev1 / fvc
    }

    /// Percentage representation
    public var percentage: Double {
        ratio * 100
    }

    /// Clinical classification based on ATS/ERS guidelines
    public var classification: Classification {
        if ratio >= 0.70 {
            return .normal
        } else if ratio >= 0.60 {
            return .mildObstruction
        } else if ratio >= 0.50 {
            return .moderateObstruction
        } else {
            return .severeObstruction
        }
    }
}
