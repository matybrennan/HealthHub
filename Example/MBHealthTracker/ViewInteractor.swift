//
//  ViewInteractor.swift
//  MBHealthTracker_Example
//
//  Created by Maty Brennan on 2/17/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import MBHealthTracker

class ViewInteractor {
    
    private let healthTracker: MBHealthTrackerProtocol
    
    init(healthTracker: MBHealthTrackerProtocol) {
        self.healthTracker = healthTracker
    }
}

extension ViewInteractor: ViewInteractorProtocol {
    
    func getActivEenergy(completionHandler: @escaping (AsyncCallResult<ActiveEnergy>) -> Void) throws {
        try healthTracker.activeEnergy.getActiveEnergy(from: .today, completionHandler: completionHandler)
    }
    
    
    func getHeartRate(completionHandler: @escaping (AsyncCallResult<HeartRate>) -> Void) throws {
        try healthTracker.heartRate.getHeartRate(fromHeartRateType: .all(TimeInterval: nil), completionHandler: completionHandler)
    }
    
    func configurePermissions() {
        healthTracker.configuration.requestAuthorization(toShare: [MBObjectType.heartRate, MBObjectType.stepCount, MBObjectType.workout],toRead: [MBObjectType.heartRate, MBObjectType.stepCount, MBObjectType.workout, MBObjectType.iron, MBObjectType.activeEnergy]) { _ in }
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
