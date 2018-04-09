//
//  ViewInteractor.swift
//  MBHealthTracker_Example
//
//  Created by Maty Brennan on 2/17/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import MBHealthTracker
import HealthKit

class ViewInteractor {
    
    fileprivate var healthTracker: MBHealthTrackerProtocol!
    
    init(healthTracker: MBHealthTrackerProtocol) {
        self.healthTracker = healthTracker
    }
}

extension ViewInteractor: ViewInteractorProtocol {
    
    func getHeartRate(completionHandler: @escaping (AsyncCallResult<HeartRateVM>) -> Void) throws {
        try healthTracker.heartRate.getHeartRate(fromHeartRateType: .all(TimeInterval: nil), completionHandler: completionHandler)
    }
    
    func configurePermissions() {
        healthTracker.configuration.requestAuthorization(toShare: [HKQuantityType.quantityType(forIdentifier: .heartRate)!, HKQuantityType.quantityType(forIdentifier: .stepCount)!, HKWorkoutType.workoutType()], toRead: [HKQuantityType.quantityType(forIdentifier: .heartRate)!, HKQuantityType.quantityType(forIdentifier: .stepCount)!, HKWorkoutType.workoutType()]) { _ in
            //
        }
    }
    
    
    func runTest() {
        do {
            try healthTracker.workout.getWorkouts(fromWorkoutType: .today, completionHandler: { result in
                //
            })
        } catch {
            print("Uable to get: \(error.localizedDescription)")
        }
        
    }
    
    
}
