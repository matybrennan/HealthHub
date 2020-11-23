//
//  WorkoutModels.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/18/18.
//

import Foundation
import HealthKit

public struct MBWorkout {
    
    public struct Item {
        
        public var duration: Double! // secs
        public var energyBurned: Double? // cals/kilocals
        public var distance: Double? // mi/km
        public var startDate: Date!
        public var endDate: Date!
        
        // TODO: Create some helper to get name of sport/activityType used as string and not healthKit type
        // let activityName: String
        public var activityType: HKWorkoutActivityType!
    }
    
    public let items: [Item]!
    
    
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
