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
                                                        ,toRead: [MBObjectType.numberOfTimesFallen, MBObjectType.nightSweats, MBObjectType.nausea, MBObjectType.bloodOxygen, MBObjectType.lowerBackPain, MBObjectType.menstruation, MBObjectType.insulinDelivery]) { _ in }
    }
    
    func runTest() {
        try? healthTracker.otherData.numberOfTimesFallen(handler: { res in
            print(res)
        })
    }
}
