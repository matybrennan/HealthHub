//
//  WorkoutWriteService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation
@preconcurrency import HealthKit

public final class WorkoutWriteService {
    
    public init() { }
    
}

extension WorkoutWriteService: WorkoutWriteServiceProtocol {
    
    public func saveWorkout(workout: MBWorkout.Item, extra: [String: Any]?) async throws {
        
        let workoutType = try MBHealthParser.workoutTypeAndCheckIfAvailable()
        try MBHealthParser.checkSharingAuthorizationStatus(for: workoutType)
        
        var energyBurned: HKQuantity?
        if let energy = workout.energyBurned {
            energyBurned = HKQuantity(unit: HKUnit.smallCalorie(), doubleValue: energy)
        }
        var distance: HKQuantity?
        if let dist = workout.energyBurned {
            distance = HKQuantity(unit: HKUnit.meter(), doubleValue: dist)
        }
        
        let workoutObj = HKWorkout(activityType: workout.activityType, start: workout.startDate, end: workout.endDate, duration: workout.duration, totalEnergyBurned: energyBurned, totalDistance: distance, device: HKDevice.local(), metadata: extra)
        
        try await healthStore.save(workoutObj)
    }
}
