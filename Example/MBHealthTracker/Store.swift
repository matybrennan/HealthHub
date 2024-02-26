//
//  ViewInteractor.swift
//  MBHealthTracker_Example
//
//  Created by Maty Brennan on 2/17/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import MBHealthTracker
import Combine

final class Store: ObservableObject {
    
    private let healthTracker: MBHealthTracker
    private var cancellables = [AnyCancellable]()
    
    init(healthTracker: MBHealthTracker = MBHealthTracker()) {
        self.healthTracker = healthTracker
        
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
            let model = SixMinuteWalk(items: [SixMinuteWalk.Item(distance: 200, startDate: Date(), endDate: Date().addingTimeInterval(100))])
            try await healthTracker.mobility.saveSixMinuteWalk(model: model)
            print("6done")
            let down = try await healthTracker.mobility.cardioFitness()
            //print("up: \(up)")
            print("down: \(down)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
