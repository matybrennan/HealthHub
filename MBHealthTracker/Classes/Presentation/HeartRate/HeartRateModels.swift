//
//  HeartRateModels.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/12/18.
//

import Foundation

public struct HeartRate {
    
    public struct HeartRateItem {
        let max: Double!
        let min: Double!
        let average: Double!
    }
    
    // Computed from timeIntervals and if One item
    let items: [HeartRateItem]!
}

extension HeartRate {
    
    public var first: HeartRateItem {
        return items.first!
    }
    
    public var last: HeartRateItem {
        return items.last!
    }
    
    public var count: Int {
        return items.count
    }
    
}
