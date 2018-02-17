//
//  StepsModels.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation

public struct StepsVM {
    
    public struct StepsItem {
        
        let count: Double!
    }
    
    // can get one item from hour or mutliple from timeIntervals
    var items: [StepsItem]!
}
