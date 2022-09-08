//
//  RespiratoryModels.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 8/9/2022.
//

import Foundation

public struct RespiratoryRate {
    
    public struct Item {
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
}

public struct ForcedExpiratoryVolume {
    
    public struct Item {
        public let liters: Double
        public let date: Date
        
        public init(liters: Double, date: Date) {
            self.liters = liters
            self.date = date
        }
    }
    
    public let items: [Item]
}

public struct ForcedVitalCapacity {
    
    public struct Item {
        public let liters: Double
        public let date: Date
        
        public init(liters: Double, date: Date) {
            self.liters = liters
            self.date = date
        }
    }
    
    public let items: [Item]
}

public struct PeakExpiratoryFlowRate {
    
    public struct Item {
        public let litersPerMinute: Double
        public let date: Date
        
        public init(litersPerMinute: Double, date: Date) {
            self.litersPerMinute = litersPerMinute
            self.date = date
        }
    }
    
    public let items: [Item]
}
