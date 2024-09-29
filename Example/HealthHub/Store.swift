//
//  ViewInteractor.swift
//  HealthHub_Example
//
//  Created by Maty Brennan on 2/17/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import HealthHub
import Combine

@MainActor
final class Store {
    
    private let hub: HealthHub
    private var cancellables = [AnyCancellable]()

    init(healthTracker: HealthHub) {
        self.healthTracker = healthTracker
        
        configure()
    }

    func configure() {
        healthTracker.mbHealthHandler.$state.sink { state in
            switch state {
            case .idle:
                print("idle")
            case .hasRequestedHealthKitInfo(let value):
                print("value: \(value)")
            }
        }.store(in: &cancellables)
    }

    func configurePermissions() async {
        try? await healthTracker.configuration.requestAuthorization(toShare: MBObjectType.allCases, toRead: MBObjectType.allCases)
    }

    func runTest() async {
        do {
            let down = try await healthTracker.heartManager.atrialFibrillation()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
