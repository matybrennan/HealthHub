//
//  ActiveEnergyService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/11/18.
//

import Foundation
import HealthKit

class ActiveEnergyService {
    
    //
}

// MARK: - ActiveEnergyServiceProtocol
extension ActiveEnergyService: ActiveEnergyServiceProtocol {
    
    func getActiveEnergy(from type: ActiveEnergyType, completionHandler: @escaping (AsyncCallResult<ActiveEnergy>) -> Void) throws {
        
        // Confirm that the type and device works
        let activeEnergyType = try MBHealthParser.unbox(quantityIdentifier: .activeEnergyBurned)
        try isDataStoreAvailable()
        
        var pred: NSPredicate
        
        switch type {
        case .today:
            pred = try NSPredicate.today()
        case .thisWeek:
            pred = try NSPredicate.thisWeek()
        case let .betweenTimePref(startDate, endDate):
            pred = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        }
        
        let query = HKSampleQuery(sampleType: activeEnergyType, predicate: pred, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            self.configure(query: sampleQuery, samples: samples, error: error, completionHandler: completionHandler)
        })
        
        healthStore.execute(query)
    }
}

// MARK: - Private methods
private extension ActiveEnergyService {
    
    func configure(query: HKSampleQuery, samples: [HKSample]?, error: Error?, completionHandler: @escaping (AsyncCallResult<ActiveEnergy>) -> Void) {
        
        guard error == nil else {
            completionHandler(.failed(error!))
            return
        }
        
        guard let quantitySamples = samples as? [HKQuantitySample] else {
            completionHandler(.failed(MBAsyncParsingError.unableToParse("ActiveEnergy log")))
            return
        }
        
        let calories = quantitySamples.reduce(Double(), { (result, sample) -> Double in
            return result + sample.quantity.doubleValue(for: HKUnit.kilocalorie())
        })
        
        let viewModel = ActiveEnergy(calories: calories)
        completionHandler(.success(viewModel))
    }
}
