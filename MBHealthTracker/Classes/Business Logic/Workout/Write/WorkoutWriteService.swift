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
    
    public func saveWorkout(workout: WorkoutVM.Item, extra: [String : Any]?, completionHandler: @escaping (AsyncCallResult<Bool>) -> Void) {
        
        let energyBurned = HKQuantity(unit: HKUnit.calorie(), doubleValue: workout.energyBurned)
        let distance = HKQuantity(unit: HKUnit.meter(), doubleValue: workout.energyBurned)
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
