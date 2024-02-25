//
//  File.swift
//  
//
//  Created by Maty Brennan on 24/2/2024.
//

import Foundation

public struct CardioFitness {

    public struct Item {
        public let vo2Max: Double
        public let date: Date
    }

    public let items: [Item]
}

public struct DoubleSupportTime {

    public struct Item {
        public let percentage: Double
        public let date: Date
    }

    public let items: [Item]
}

public struct GroundContactTime {

    public struct Item {
        public let duration: Double //ms
        public let date: Date
    }

    public let items: [Item]
}

public struct RunningStrideLength {

    public struct Item {
        public let distance: Double //m
        public let date: Date
    }

    public let items: [Item]
}
