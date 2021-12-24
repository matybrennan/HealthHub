//
//  ViewInteractor.swift
//  MBHealthTracker_Example
//
//  Created by Maty Brennan on 2/17/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import MBHealthTracker

protocol ViewInteractorProtocol {
    func configurePermissions()
    func runTest()
}

final class ViewInteractor {
    
    private let healthTracker: MBHealthTrackerProtocol
    
    init(healthTracker: MBHealthTrackerProtocol) {
        self.healthTracker = healthTracker
    }
}

// MARK: - ViewInteractorProtocol
extension ViewInteractor: ViewInteractorProtocol {
    
    func configurePermissions() {
        healthTracker.configuration.requestAuthorization(toShare: [MBObjectType.water, MBObjectType.sleep, MBObjectType.workout, MBObjectType.mindful]
        
        ,toRead: [MBReadType.gender, MBObjectType.basalBodyTemperature, MBObjectType.cervicalMucusQuality, MBObjectType.menstruation, MBObjectType.ovulationTestResult, MBObjectType.spotting, MBObjectType.sexualActivity]) { _ in }
    }
    
    func runTest() {
        try? healthTracker.cycleTracking.basalBodyTemperature { res in
            print(res)
        }
    }
}
