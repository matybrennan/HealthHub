//
//  NutritionService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 5/24/18.
//

import Foundation
import HealthKit

public class NutritionService {
    
    public init() { }
    
    public func getNutrition(fromType type: HKObjectType?, completionHandler: @escaping (AsyncCallResult<Bool>) -> Void) {
        
        let type = HKQuantityType.quantityType(forIdentifier: .dietaryIron)!
        
        let query = HKSampleQuery(sampleType: type, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            
            let value = (samples?.first as? HKQuantitySample)?.quantity.doubleValue(for: HKUnit(from: MassFormatter.Unit.gram))
            print(value)
            
        }
        
        
        healthStore.execute(query)
    }
    
}
