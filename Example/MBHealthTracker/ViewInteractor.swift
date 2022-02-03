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
                                                        ,toRead: [MBReadType.gender, MBObjectType.headache, MBObjectType.hairLoss, MBObjectType.hotFlashes, MBObjectType.electrodermalActivity, MBObjectType.fatigue, MBObjectType.diarrhea]) { _ in }
    }
    
    func runTest() {
        try? healthTracker.body.electrodermalActivity(completionHandler: { res in
            print(res)
        })
    }
}
