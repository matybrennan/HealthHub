//
//  WorkoutWriteService.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation
import HealthKit

public final class WorkoutWriteService {
    
    public init() { }
}

extension WorkoutWriteService: WorkoutWriteServiceProtocol {
    
    public func saveWorkout(workout: Workout.Item, extra: [String: Sendable]?) async throws {
        
        let workoutType = try HealthParser.workoutTypeAndCheckIfAvailable()
        try HealthParser.checkSharingAuthorizationStatus(for: workoutType)
        
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
