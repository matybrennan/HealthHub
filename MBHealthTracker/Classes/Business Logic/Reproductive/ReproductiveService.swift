//
//  ReproductiveService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation
import HealthKit

public class ReproductiveService {
    
    public init() { }
}

// MARK: - ReproductiveServiceProtocol
extension ReproductiveService: ReproductiveServiceProtocol {
    
    // Basal body temp, cervical mucus quality, menstrualFlow, ovulation, sexual activity, spotting
    
    public func basalBodyTemperature(completionHandler: @escaping (MBAsyncCallResult<BasalBodyTemperature>) -> Void) throws {
        
        // Confirm that the type and device works
        let basalBodyTempType = try MBHealthParser.unbox(quantityIdentifier: .basalBodyTemperature)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: basalBodyTempType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("BasalBodyTemperature log")))
                return
            }
            
            let items = quantitySamples.map { item -> BasalBodyTemperature.Info in
                let celsius = item.quantity.doubleValue(for: .degreeCelsius())
                let fahrenheit = item.quantity.doubleValue(for: .degreeFahrenheit())
                return BasalBodyTemperature.Info(celsius: celsius, fahrenheit: fahrenheit, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = BasalBodyTemperature(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
        
    }
}
