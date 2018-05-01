//
//  HeartRateService.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/7/18.
//

import Foundation
import HealthKit

public class HeartRateService {
    
    struct Unit {
        static let heartRateCountMin = "count/min"
    }
    
}

extension HeartRateService: HeartRateServiceProtocol {
    
    public func getHeartRate(fromHeartRateType type: HeartRateType, completionHandler: @escaping (AsyncCallResult<HeartRateVM>) -> Void) throws {
        
        // Confirm that the type and device works
        let heartRate = try MBHealthParser.unbox(quantityIdentifier: .heartRate)
        try authorizationStatusSuccessful(for: heartRate)
        
        var query: HKQuery!
        
        switch type {
        case .current:
            
            // Get last item in healthStore for heartRate
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            // create query for heartRate
            query = HKSampleQuery(sampleType: heartRate, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor], resultsHandler: { (query, samples, error) in
                
                guard error == nil else {
                    completionHandler(.failed(error!))
                    return
                }
                
                guard let quantitySample = samples?.first as? HKQuantitySample else {
                    completionHandler(AsyncCallResult.failed(HeartRateParsingError.unableToParse("current heartRate or no heart rate samples")))
                    return
                }
                let hr = quantitySample.quantity.doubleValue(for: HKUnit(from: Unit.heartRateCountMin))
                let item = HeartRateVM.HeartRateItem(max: hr, min: hr, average: hr)
                let vm = HeartRateVM(items: [item])
                completionHandler(.success(vm))
            })
            
        case let .today(interval):
            
            // create predicate for start and end of day
            let predicate = try NSPredicate.today()
            
            // set timeInterval for grabbing data batches (in mins)
            // If no interval is set create it for 1 hour batches
            var component = DateComponents()
            component.minute = interval ?? 60
        
            // create query
            query = HKStatisticsCollectionQuery(quantityType: heartRate, quantitySamplePredicate: predicate, options: [.discreteAverage, .discreteMax, .discreteMin], anchorDate: Date().startOfDay, intervalComponents: component)
            
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                self.configure(query: query, collection: collection, error: error, completionHandler: completionHandler)
            }
        case let .thisWeek(interval):
            
            // create predicate for start and end of day
            let predicate = try NSPredicate.thisWeek()
            
            var component = DateComponents()
            component.day = interval ?? 1
            
            // create query
            query = HKStatisticsCollectionQuery(quantityType: heartRate, quantitySamplePredicate: predicate, options: [.discreteAverage, .discreteMax, .discreteMin], anchorDate: Date().startOfDay, intervalComponents: component)
            
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                self.configure(query: query, collection: collection, error: error, completionHandler: completionHandler)
            }
        case let .all(interval):
                
            var component = DateComponents()
            component.day = interval ?? 1
            
            // create query
            query = HKStatisticsCollectionQuery(quantityType: heartRate, quantitySamplePredicate: nil, options: [.discreteAverage, .discreteMax, .discreteMin], anchorDate: Date().startOfDay, intervalComponents: component)
            
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                self.configure(query: query, collection: collection, error: error, completionHandler: completionHandler)
            }
        }
        
        healthStore.execute(query)
    }
    
}

private extension HeartRateService {
    
    func configure(query: HKStatisticsCollectionQuery, collection: HKStatisticsCollection?, error: Error?, completionHandler: @escaping (AsyncCallResult<HeartRateVM>) -> Void) {
        guard error == nil else {
            completionHandler(.failed(error!))
            return
        }
        
        guard let quantitySamples = collection?.statistics() else {
            completionHandler(.failed(HeartRateParsingError.unableToParse("HeartRate log")))
            return
        }
        
        let items = quantitySamples.map {
            HeartRateVM.HeartRateItem(max: $0.maximumQuantity()?.doubleValue(for: HKUnit(from: Unit.heartRateCountMin)),
                                      min: $0.minimumQuantity()?.doubleValue(for: HKUnit(from: Unit.heartRateCountMin)),
                                      average: $0.averageQuantity()?.doubleValue(for: HKUnit(from: Unit.heartRateCountMin)))
        }
        
        let vm = HeartRateVM(items: items)
        completionHandler(.success(vm))
    }
    
}
