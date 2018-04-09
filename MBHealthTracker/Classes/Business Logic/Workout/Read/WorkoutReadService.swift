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
    
    public func getWorkouts(fromWorkoutType type: WorkoutType, completionHandler: @escaping (AsyncCallResult<WorkoutVM>) -> Void) throws {
        
        // Confirm that the type and device works
        let workout = HKWorkoutType.workoutType()
        try authorizationStatusSuccessful(for: workout)
        
        var query: HKQuery!
        
        switch type {
        case .today:
            
            let predicate = try NSPredicate.today()
            
            query = HKSampleQuery(sampleType: workout, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (query, samples, error) in
                self.configure(query: query, samples: samples, error: error, completionHandler: completionHandler)
            })
            
        case .thisWeek:
            
            let predicate = try NSPredicate.thisWeek()
            query = HKSampleQuery(sampleType: workout, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (query, samples, error) in
                self.configure(query: query, samples: samples, error: error, completionHandler: completionHandler)
            })
            
            
        case .all:
            
            query = HKSampleQuery(sampleType: workout, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (query, samples, error) in
                self.configure(query: query, samples: samples, error: error, completionHandler: completionHandler)
            })
        }
        
        healthStore.execute(query)
    }
}

private extension WorkoutReadService {
    
    func configure(query: HKSampleQuery, samples: [HKSample]?, error: Error?, completionHandler: @escaping (AsyncCallResult<WorkoutVM>) -> Void) {
        
        guard error == nil else {
            completionHandler(.failed(error!))
            return
        }
        
        guard let workoutSamples = samples as? [HKWorkout] else {
            completionHandler(.failed(WorkoutReadParsingError.unableToParse("Workout log")))
            return
        }
        
        let workoutItems = workoutSamples.map { WorkoutVM.Item(duration: $0.duration, energyBurned: $0.totalEnergyBurned?.doubleValue(for: Unit.workoutEnergy) ?? 0, distance: $0.totalDistance?.doubleValue(for: Unit.workoutDistance) ?? 0, startDate: $0.startDate, endDate: $0.endDate, activityType: $0.workoutActivityType)  }
        
        let workout = WorkoutVM(items: workoutItems)
        completionHandler(.success(workout))
    }
}
