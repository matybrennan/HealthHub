//
//  File.swift
//  
//
//  Created by Maty Brennan on 24/2/2024.
//

import Foundation

public struct CardioFitness: Sendable {

    public struct Item: Sendable {
        public let vo2Max: Double
        public let date: Date

        public init(vo2Max: Double, date: Date) {
            self.vo2Max = vo2Max
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct DoubleSupportTime: Sendable {

    public struct Item: Sendable {
        public let percentage: Double
        public let date: Date

        public init(percentage: Double, date: Date) {
            self.percentage = percentage
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct GroundContactTime: Sendable {

    public struct Item: Sendable {
        public let duration: Double // ms
        public let date: Date

        public init(duration: Double, date: Date) {
            self.duration = duration
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct RunningStrideLength: Sendable {

    public struct Item: Sendable {
        public let distance: Double // m
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct StairSpeedDown: Sendable {

    public struct Item: Sendable {
        public let velocity: Double // m/s
        public let date: Date

        public init(velocity: Double, date: Date) {
            self.velocity = velocity
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct StairSpeedUp: Sendable {

    public struct Item: Sendable {
        public let velocity: Double // m/s
        public let date: Date

        public init(velocity: Double, date: Date) {
            self.velocity = velocity
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct VerticalOscillation: Sendable {

    public struct Item: Sendable {
        public let distance: Double // cm
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WalkingAsymmetry: Sendable {

    public struct Item: Sendable {
        public let percentage: Double
        public let date: Date

        public init(percentage: Double, date: Date) {
            self.percentage = percentage
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WalkingSpeed: Sendable {

    public struct Item: Sendable {
        public let velocity: Double // km/h
        public let date: Date

        public init(velocity: Double, date: Date) {
            self.velocity = velocity
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WalkingSteadiness: Sendable {

    public struct Item: Sendable {
        public let percentage: Double
        public let date: Date

        public init(percentage: Double, date: Date) {
            self.percentage = percentage
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

public struct WalkingStepLength: Sendable {

    public struct Item: Sendable {
        public let distance: Double // cm
        public let date: Date

        public init(distance: Double, date: Date) {
            self.distance = distance
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}
