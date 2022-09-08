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
            try await healthTracker.configuration.requestAuthorization(toShare: [MBObjectType.carbohydrates], toRead: [MBObjectType.carbohydrates])
        }
    }
    
    func runTest() {
        
        Task {
            do {
                
                let caffeine = try await healthTracker.nutrition.nutrition(type: .carbohydrates)
                print("caffeine but really carbs: \(caffeine)")
                
                let item = Nutrition.Info(value: 50, unit: NutritionType.carbohydrates.unitMeasure.unitStr, date: Date(), type: NutritionType.carbohydrates.quantityType)
                try await healthTracker.nutrition.save(nutrition: item, extra: nil)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
