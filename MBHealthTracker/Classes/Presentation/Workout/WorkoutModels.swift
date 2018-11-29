//
//  WorkoutModels.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/18/18.
//

import Foundation
import HealthKit

public struct Workout {
    
    public struct Item {
        
        public let duration: Double // secs
        public let energyBurned: Double // cals/kilocals
        public let distance: Double // mi/km
        public let startDate: Date
        public let endDate: Date
        
        // TODO: Create some helper to get name of sport/activityType used as string and not healthKit type
        // let activityName: String
        public let activityType: HKWorkoutActivityType
    }
    
    public let items: [Item]!
}

extension Workout.Item {
    
    public init(duration: Double, energyBurned: Double, distance: Double, startDate: Date, activityType: HKWorkoutActivityType) {
        self.duration = duration
        self.energyBurned = energyBurned
        self.distance = distance
        self.startDate = startDate
        self.endDate = Date()
        self.activityType = activityType
    }
    
}
