//
//  BodyService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 20/9/19.
//

import Foundation
import HealthKit

class BodyService {
    //
}

extension BodyService: BodyServiceProtocol {
    
    func bodyWeight(completionHandler: @escaping (MBAsyncCallResult<BodyWeight>) -> Void) throws {
        
        // Confirm that the type and device works
        let bodyWeight = try MBHealthParser.unbox(quantityIdentifier: .bodyMass)
        try isDataStoreAvailable()
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: bodyWeight, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let result = results?.first as? HKQuantitySample  else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("ActiveEnergy log")))
                return
            }
            
            let bodyMassKg = result.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            let bodyMasslbs = result.quantity.doubleValue(for: HKUnit.pound())
            let bodyWeight = BodyWeight(kg: bodyMassKg, lbs: bodyMasslbs)
            completionHandler(.success(bodyWeight))
        }
        
        healthStore.execute(query)
    }
    
    func bodyFatPercentage(completionHandler: @escaping (MBAsyncCallResult<BodyFatPercentage>) -> Void) throws {
        //
    }
}
