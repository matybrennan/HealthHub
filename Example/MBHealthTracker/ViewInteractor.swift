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
    
    init(healthTracker: MBHealthTrackerProtocol = MBHealthTracker()) {
        self.healthTracker = healthTracker
    }
}

// MARK: - ViewInteractorProtocol
extension ViewInteractor: ViewInteractorProtocol {
    
    func configurePermissions() {
        Task {
            try await healthTracker.configuration.requestAuthorization(toShare: [MBObjectType.carbohydrates], toRead: [MBObjectType.pregancyTestResult, MBObjectType.progesteroneTestResult])
        }
    }
    
    func runTest() {
        
        Task {
            do {
                let progesteroneTestResult = try await healthTracker.cycleTracking.progesteroneTestResult()
                print("res1: \(progesteroneTestResult)")
                let pregnancyTestResult = try await healthTracker.cycleTracking.pregnancyTestResult()
                print("res2: \(pregnancyTestResult)")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
