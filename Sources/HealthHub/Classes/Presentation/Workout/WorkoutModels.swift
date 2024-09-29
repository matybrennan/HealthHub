//
//  WorkoutModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/18/18.
//

import Foundation
import HealthKit

public struct MBWorkout: Sendable {

    public struct Item: Sendable {

        public var duration: Double! // secs
        public var energyBurned: Double? // cals/kilocals
        public var distance: Double? // mi/km
        public var startDate: Date!
        public var endDate: Date!
        
        // TODO: Create some helper to get name of sport/activityType used as string and not healthKit type
        // let activityName: String
        public var activityType: HKWorkoutActivityType!

        public init(duration: Double!, energyBurned: Double? = nil, distance: Double? = nil, startDate: Date!, endDate: Date!, activityType: HKWorkoutActivityType!) {
            self.duration = duration
            self.energyBurned = energyBurned
            self.distance = distance
            self.startDate = startDate
            self.endDate = endDate
            self.activityType = activityType
        }
    }
    
    public let items: [Item]!
    
    public init(items: [Item]!) {
        self.items = items
    }
}

extension MBWorkout.Item {
    
    public init(duration: Double, energyBurned: Double?, distance: Double?, startDate: Date, endDate: Date, activityType: HKWorkoutActivityType) {
        self.duration = duration
        self.energyBurned = energyBurned
        self.distance = distance
        self.startDate = startDate
        self.endDate = endDate
        self.activityType = activityType
    }
    
    public init(duration: Double, energyBurned: Double?, distance: Double?, startDate: Date, endDate: Date) {
        self.duration = duration
        self.energyBurned = energyBurned
        self.distance = distance
        self.startDate = startDate
        self.endDate = endDate
        self.activityType = .other
    }
}
