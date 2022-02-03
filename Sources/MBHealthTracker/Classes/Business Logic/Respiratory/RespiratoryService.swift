//
//  RespiratoryService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation
import HealthKit

public class RespiratoryService {
    
    public init() { }
}

// MARK: - RespiratoryServiceProtocol
extension RespiratoryService: RespiratoryServiceProtocol {
    
    public func respiratoryRate(completionHandler: @escaping (MBAsyncCallResult<RespiratoryRate>) -> Void) throws {
        
        // Confirm that the type and device works
        let respiratoryRateType = try MBHealthParser.unbox(quantityIdentifier: .respiratoryRate)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: respiratoryRateType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("respiratoryRate log")))
                return
            }
            
            let items = quantitySamples.map { item -> RespiratoryRate.Info in
                let value = item.quantity.doubleValue(for: HKUnit(from: "count/min"))
                
                return RespiratoryRate.Info(value: value, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = RespiratoryRate(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
}
