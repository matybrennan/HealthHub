//
//  OtherDataModels.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation

public struct AlcoholConsumption {
    
    public struct Item {
        public let drinks: Double
        public let date: Date
    }
    
    public let items: [Item]
}

public struct AlcoholContent {
    
    public struct Item {
        public let percentage: Double
        public let date: Date
    }
    
    public let items: [Item]
}

public struct HandWashing {
    
    public struct Item {
        public let startDate: Date
        public let endDate: Date
    }
    
    public let items: [Item]
}

public struct InhalerUsage {
    
    public struct Item {
        public let value: Int
        public let date: Date
    }
    
    public let items: [Item]
}

public struct InsulinDelivery {
    
    public struct Item {
        
        public enum Purpose: Int {
            case basal = 1
            case bolus
        }
        
        public let value: Double
        public let purpose: Purpose
        public let startDate: Date
        public let endDate: Date
    }
    
    public let items: [Item]
}

public struct NumberOfTimesFallen {
    
    public struct Item {
        public let value: Int
        public let date: Date
    }
    
    public let items: [Item]
}

public struct ToothBrushing {
    
    public struct Item {
        public let startDate: Date
        public let endDate: Date
    }
    
    public let items: [Item]
}

public struct UVExposure {
    
    public struct Item {
        public let value: Int
        public let startDate: Date
        public let endDate: Date
    }
    
    public let items: [Item]
}

public struct TimeInDaylight {

    public struct Item {
        public let startDate: Date
        public let endDate: Date
    }

    public let items: [Item]
}

public struct WaterTemperature {
    
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
}


