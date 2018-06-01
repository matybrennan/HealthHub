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
    
    func getHeartRate(completionHandler: @escaping (AsyncCallResult<HeartRateVM>) -> Void) throws {
        try healthTracker.heartRate.getHeartRate(fromHeartRateType: .all(TimeInterval: nil), completionHandler: completionHandler)
    }
    
    func configurePermissions() {
        healthTracker.configuration.requestAuthorization(toShare: [MBShareType.heartRate, .stepCount, .workout],toRead: [MBReadType.heartRate, .stepCount, .workout, .iron, .energyConsumed]) { _ in }
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
