//
//  Reproductive.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
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

public struct CervicalMucusQuality {
    public init() { }
}

public struct MenstrualFlow {
    public init() { }
}

public struct Ovulation {
    public init() { }
}

public struct SexualActivity {
    public init() { }
}

public struct Spotting {
    public init() { }
}

