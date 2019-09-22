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

class ViewInteractor {
    
    private let healthTracker: MBHealthTrackerProtocol
    
    init(healthTracker: MBHealthTrackerProtocol) {
        self.healthTracker = healthTracker
    }
}

extension ViewInteractor: ViewInteractorProtocol {
    
    func getActivEenergy(completionHandler: @escaping (MBAsyncCallResult<ActiveEnergy>) -> Void) throws {
        try healthTracker.activeEnergy.getActiveEnergy(from: .today, completionHandler: completionHandler)
    }
    
    func getPercentage() {
        try! healthTracker.body.bodyHeight(completionHandler: { (result) in
            //
        })
    }
    
    
    func getHeartRate(completionHandler: @escaping (MBAsyncCallResult<HeartRate>) -> Void) throws {
        try healthTracker.heartRate.getHeartRate(fromHeartRateType: .all(TimeInterval: nil), completionHandler: completionHandler)
    }
    
    func configurePermissions() {
        healthTracker.configuration.requestAuthorization(toShare: [MBObjectType.heartRate, MBObjectType.stepCount, MBObjectType.workout, MBObjectType.water, MBObjectType.sleep, MBObjectType.workout]
        
        
        ,toRead: [MBObjectType.heartRate, MBObjectType.stepCount, MBObjectType.workout, MBObjectType.iron, MBObjectType.activeEnergy, MBObjectType.energyConsumed, MBObjectType.carbohydrates, MBObjectType.fiber, MBObjectType.sugar, MBObjectType.fatTotal, MBObjectType.fatMono, MBObjectType.fatPoly, MBObjectType.fatSaturated, MBObjectType.cholesterol, MBObjectType.protein, MBObjectType.vitaminA, MBObjectType.thiamin, MBObjectType.riboflavin, MBObjectType.niacin, MBObjectType.pathothenicAcid, MBObjectType.vitaminB6, MBObjectType.biotin, MBObjectType.vitaminB12, MBObjectType.vitaminC, MBObjectType.vitaminD, MBObjectType.vitaminE, MBObjectType.vitaminK, MBObjectType.folate, MBObjectType.water, MBObjectType.caffeine, MBObjectType.sleep, MBObjectType.bodyMass, MBObjectType.bodyFatPercentage, MBReadType.dob, MBReadType.gender, MBObjectType.bodyMassIndex, MBObjectType.waistCircumference, MBObjectType.leanBodyMass, MBObjectType.height]) { _ in }
    }
    
    func runTest() {
        do {
            try healthTracker.workout.getWorkouts(fromWorkoutType: .today, completionHandler: { result in
                //
            })
        } catch {
            print("Uable to get: \(error.localizedDescription)")
        }
    }
    
    func getWorkouts(completionHandler: @escaping (MBAsyncCallResult<MBWorkout>) -> Void) throws {
        try healthTracker.workout.getWorkouts(fromWorkoutType: .all, completionHandler: completionHandler)
    }
    
    func saveWorkout(completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws {
        let item = MBWorkout.Item.init(duration: 10, energyBurned: nil, distance: nil, startDate: Date.init(timeIntervalSinceNow: -100), endDate: Date())
        try healthTracker.workout.saveWorkout(workout: item, extra: nil, completionHandler: completionHandler)
    }
    
    func saveSleep(completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws {
        let sleepInfo = Sleep.Info.init(style: MBSleepStyle.awake, startDate: Date(), type: MBObjectType.sleep.sharable as! HKCategoryType)
        try healthTracker.sleep.save(sleep: sleepInfo, extra: nil, completionHandler: completionHandler)
    }
    
    func getSleep(completionHandler: @escaping (MBAsyncCallResult<Sleep>) -> Void) throws {
        try healthTracker.sleep.getSleep(completionHandler: completionHandler)
    }
}
