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
        healthTracker.configuration.requestAuthorization(toShare: []
                                                        ,toRead: [MBObjectType.ovulationTestResult, MBObjectType.nightSweats, MBObjectType.nausea, MBObjectType.moodChanges, MBObjectType.lowerBackPain, MBObjectType.menstruation, MBObjectType.alcoholConsumption]) { _ in }
    }
    
    func runTest() {
        try? healthTracker.otherData.alcoholConsumption(handler: { res in
            print(res)
        })
    }
}
