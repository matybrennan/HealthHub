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
}

public struct BodyWeight {
    
    public struct Item {
        public let kg: Double
        public let lbs: Double
        public let date: Date
    }
    
    public let items: [Item]
}

public struct LeanBodyMass {
    
    public struct Item {
        public let kg: Double
        public let lbs: Double
        public let date: Date
    }
    
    public let items: [Item]
}

public struct BodyHeight {
    
    public struct Item {
        public let inches: Int
        public let cm: Int
        public let date: Date
    }
    
    public let items: [Item]
}

public struct BodyFatPercentage {
    
    public struct Item {
        public let value: Double
        public let date: Date
    }
    
    public let items: [Item]
}

public struct BodyMassIndex {
    
    public struct Item {
        public let value: Double
        public let date: Date
    }
    
    public let items: [Item]
}

public struct WaistCircumference {
    
    public struct Item {
        public let inches: Int
        public let cm: Int
        public let date: Date
    }
    
    public let items: [Item]
}

public struct ElectrodermalActivity {
    
    public struct Item {
        public let value: Double
        public let date: Date
    }
    
    public let items: [Item]
}

