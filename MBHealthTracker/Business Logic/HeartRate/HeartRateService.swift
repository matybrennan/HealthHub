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
        let heartRate = try HealthType.unbox(quantityIdentifier: .heartRate)
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
                    completionHandler(AsyncCallResult.failed(HeartRateParsingError.unableToParse("current heartRate")))
                    return
                }
                let hr = quantitySample.quantity.doubleValue(for: HKUnit(from: Unit.heartRateCountMin))
                let item = HeartRateVM.HeartRateItem(max: hr, min: hr, average: hr)
                let vm = HeartRateVM(items: [item])
                completionHandler(.success(vm))
            })
            
        case let .today(interval):
            
            // create predicate for start and end of day
            let calendar = Calendar.current
            let now = Date()
            let components = calendar.dateComponents([.year, .month, .day], from: now)
            guard let startDate = calendar.date(from: components) else { return }
            let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
            
            // set timeInterval for grabbing data batches (in mins)
            // If no interval is set create it for 1 hour batches
            var component = DateComponents()
            component.minute = interval ?? 60
        
            // create query
            query = HKStatisticsCollectionQuery(quantityType: heartRate, quantitySamplePredicate: predicate, options: [.discreteAverage, .discreteMax, .discreteMin], anchorDate: startDate, intervalComponents: component)
            
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                
                guard error == nil else {
                    completionHandler(.failed(error!))
                    return
                }
                
                guard let quantitySamples = collection?.statistics() else {
                    completionHandler(.failed(HeartRateParsingError.unableToParse("Today heartRate")))
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
            
        case .thisWeek: break
        case .thisYear: break
        case .all: break
        }
        
        healthStore.execute(query)
    }
    
}
