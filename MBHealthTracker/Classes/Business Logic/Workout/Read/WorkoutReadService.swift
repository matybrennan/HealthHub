//
//  WorkoutReadService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation
import HealthKit

public class WorkoutReadService {
    
    //
    
}

extension WorkoutReadService: WorkoutReadServiceProtocol {
    
    public func getWorkouts(fromWorkoutType type: WorkoutType, completionHandler: (AsyncCallResult<WorkoutVM>) -> Void) throws {
        
        // Confirm that the type and device works
        let workout = HKWorkoutType.workoutType()
        try authorizationStatusSuccessful(for: workout)
        
        var query: HKQuery!
        
        query = HKSampleQuery(sampleType: workout, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (query, samples, error) in
            //
        })
        
        healthStore.execute(query)
    }
    
}
