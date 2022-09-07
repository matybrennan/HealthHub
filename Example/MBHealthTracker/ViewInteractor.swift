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
        healthTracker.configuration.requestAuthorization(toShare: [MBObjectType.respiratoryRate]
                                                        ,toRead: [MBObjectType.respiratoryRate]) { _ in }
    }
    
    func runTest() {
        
        Task {
            do {
                let respiratoryRate = try await healthTracker.respiratory.respiratoryRate()
                print("respiratoryRate: \(respiratoryRate)")
                let bodyMassIndex = try await healthTracker.body.bodyMassIndex()
                print("bodyMassIndex: \(bodyMassIndex)")
                let res = try await healthTracker.body.basalBodyTemperature()
                print("res: \(res)")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
