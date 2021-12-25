//
//  Body.swift
//  MBHealthTracker
//
//  Created by matybrennan on 20/9/19.
//

import Foundation

public struct BasalBodyTemperature {
    
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

public struct BodyWeight {
    public let kg: Double
    public let lbs: Double
}

public struct LeanBodyMass {
    public let kg: Double
    public let lbs: Double
}

public struct BodyHeight {
    public let inches: Int
    public let cm: Int
}

public struct BodyFatPercentage {
    public let value: Double
}

public struct BodyMassIndex {
    public let value: Double
}

public struct WaistCircumference {
    public let inches: Int
    public let cm: Int
}

