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

protocol ViewInteractorProtocol {
    func configurePermissions()
    func runTest()
}

class ViewInteractor {
    
    private let healthTracker: MBHealthTrackerProtocol
    
    init(healthTracker: MBHealthTrackerProtocol) {
        self.healthTracker = healthTracker
    }
}

// MARK: - ViewInteractorProtocol
extension ViewInteractor: ViewInteractorProtocol {
    
    func configurePermissions() {
        healthTracker.configuration.requestAuthorization(toShare: [MBObjectType.water, MBObjectType.sleep, MBObjectType.workout, MBObjectType.mindful]
        
        ,toRead: [MBReadType.gender, MBObjectType.bodyMassIndex, MBObjectType.bloodPressureSystolic, MBObjectType.bloodPressureDiastolic, MBObjectType.respiratoryRate, MBObjectType.bodyTemperature]) { _ in }
    }
    
    func runTest() {
        do {
            try healthTracker.vitalsService.bodyTemperature(completionHandler: { (result) in
                print(result)
            })
        } catch {
            print("Unable to get: \(error.localizedDescription)")
        }
    }
}
