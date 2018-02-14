//
//  HeartRateModels.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/12/18.
//

import Foundation

public struct HeartRateVM {
    
    public struct HeartRateItem {
        let max: Double!
        let min: Double!
        let average: Double!
    }
    
    // Computed from timeIntervals and if One item
    public var items: [HeartRateItem]!
}

extension HeartRateVM {
    
    var first: HeartRateItem {
        return items.first!
    }
    
    var last: HeartRateItem {
        return items.last!
    }
    
    var count: Int {
        return items.count
    }
    
}
