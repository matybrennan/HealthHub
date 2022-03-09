//
//  OtherDataService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation
import HealthKit

public class OtherDataService {
    
    public init() { }
}

// MARK: OtherDataServiceProtocol
extension OtherDataService: OtherDataServiceProtocol {
    
    public func alcoholConsumption(handler: @escaping (MBAsyncCallResult<AlcoholConsumption>) -> Void) throws {
        // Confirm that the type and device works
        let alcoholConsumptionType = try MBHealthParser.unbox(quantityIdentifier: .numberOfAlcoholicBeverages)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: alcoholConsumptionType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("alcoholConsumption log")))
                return
            }
            
            let items = quantitySamples.map { item -> AlcoholConsumption.Item in
                let drinks = item.quantity.doubleValue(for: HKUnit.count())
                return AlcoholConsumption.Item(drinks: drinks, date: item.startDate)
            }
            
            let model = AlcoholConsumption(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
}
