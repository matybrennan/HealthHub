//
//  WorkoutReadService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation
import HealthKit

public class WorkoutReadService {
    
    struct Unit {
        static let workoutEnergy = HKUnit.calorie()
        static let workoutDistance = HKUnit.meter()
    }
}

extension WorkoutReadService: WorkoutReadServiceProtocol {
    
    public func getWorkouts(fromWorkoutType type: WorkoutType, completionHandler: @escaping (AsyncCallResult<Workout>) -> Void) throws {
        
        // Confirm that the type and device works
        let workout = HKWorkoutType.workoutType()
        try isDataStoreAvailable()
        
        var pred: NSPredicate?
        
        switch type {
        case .today:
            pred = try NSPredicate.today()
        case .thisWeek:
            pred = try NSPredicate.thisWeek()
        case .all:
            pred = nil
        }
        
        let query = HKSampleQuery(sampleType: workout, predicate: pred, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (query, samples, error) in
            self.configure(query: query, samples: samples, error: error, completionHandler: completionHandler)
        })
        
        healthStore.execute(query)
    }
}

private extension WorkoutReadService {
    
    func configure(query: HKSampleQuery, samples: [HKSample]?, error: Error?, completionHandler: @escaping (AsyncCallResult<Workout>) -> Void) {
        
        guard error == nil else {
            completionHandler(.failed(error!))
            return
        }
        
        guard let workoutSamples = samples as? [HKWorkout] else {
            completionHandler(.failed(MBAsyncParsingError.unableToParse("Workout log")))
            return
        }
        
        let workoutItems = workoutSamples.map { Workout.Item(duration: $0.duration, energyBurned: $0.totalEnergyBurned?.doubleValue(for: Unit.workoutEnergy) ?? 0, distance: $0.totalDistance?.doubleValue(for: Unit.workoutDistance) ?? 0, startDate: $0.startDate, endDate: $0.endDate, activityType: $0.workoutActivityType)  }
        
        let workout = Workout(items: workoutItems)
        completionHandler(.success(workout))
    }
}
