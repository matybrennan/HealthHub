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
        
        let duration: Double // secs
        let energyBurned: Double // cals/kilocals
        let distance: Double // mi/km
        let startDate: Date
        let endDate: Date
        
        // TODO: Create some helper to get name of sport/activityType used as string and not healthKit type
        // let activityName: String
        let activityType: HKWorkoutActivityType
    }
    
    let items: [Item]!
}
