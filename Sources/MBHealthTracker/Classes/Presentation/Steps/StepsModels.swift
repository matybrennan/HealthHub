//
//  StepsModels.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation

public struct Steps: Sendable {

    public struct Item: Sendable {
        
        public let count: Double!
    }
    
    // can get one item from hour or mutliple from timeIntervals
    public let items: [Item]!
}
