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

    public init(items: [Item]) {
        self.items = items
    }
}

public struct DoubleSupportTime {

    public struct Item {
        public let percentage: Double
        public let date: Date
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct GroundContactTime {

    public struct Item {
        public let duration: Double // ms
        public let date: Date
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct RunningStrideLength {

    public struct Item {
        public let distance: Double // m
        public let date: Date
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct StairSpeedDown {

    public struct Item {
        public let velocity: Double // m/s
        public let date: Date
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct StairSpeedUp {

    public struct Item {
        public let velocity: Double // m/s
        public let date: Date
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct VerticalOscillation {

    public struct Item {
        public let distance: Double // cm
        public let date: Date
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WalkingAsymmetry {

    public struct Item {
        public let percentage: Double
        public let date: Date
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WalkingSpeed {

    public struct Item {
        public let velocity: Double // km/h
        public let date: Date
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WalkingSteadiness {

    public struct Item {
        public let percentage: Double
        public let date: Date
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WalkingStepLength {

    public struct Item {
        public let distance: Double // cm
        public let date: Date
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}
