//
//  WorkoutWriteService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation
import HealthKit

public class WorkoutWriteService {
    
    //
    
}

extension WorkoutWriteService: WorkoutWriteServiceProtocol {
    
    public func saveWorkout(workout: Workout.Item, extra: [String : Any]?, completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws {
        
        try checkSharingAuthorizationStatus(for: HKWorkoutType.workoutType())
        try isDataStoreAvailable()
        
        var energyBurned: HKQuantity?
        if let energy = workout.energyBurned {
            energyBurned = HKQuantity(unit: HKUnit.calorie(), doubleValue: energy)
        }
        var distance: HKQuantity?
        if let dist = workout.energyBurned {
            distance = HKQuantity(unit: HKUnit.meter(), doubleValue: dist)
        }
        
        let workoutObj = HKWorkout(activityType: workout.activityType, start: workout.startDate, end: workout.endDate, duration: workout.duration, totalEnergyBurned: energyBurned, totalDistance: distance, device: HKDevice.local(), metadata: extra)
        
        healthStore.save(workoutObj) { (status, error) in
            if let error = error {
                completionHandler(.failed(error))
            } else {
                completionHandler(.success(status))
            }
        }
    }
}
