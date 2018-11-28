//
//  StepsService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

public class StepsService {
    
    struct StepsConfig {
        static let oneHour: TimeInterval = 3600
        static let stepsCount = "count"
    }
    
}

extension StepsService: StepsServiceProtocol {
    
    public func getSteps(fromStepsType type: StepsType, completionHandler: @escaping (AsyncCallResult<Steps>) -> Void) throws {
        
        // Confirm that the type and device works
        let steps = try MBHealthParser.unbox(quantityIdentifier: .stepCount)
        try isDataStoreAvailable()
        
        var query: HKQuery!
        
        switch type {
        
        // Get the sum of the last hour of steps
        case .lastHour:
            
            let now = Date()
            let oneHourAgo = Date(timeIntervalSinceNow: -StepsConfig.oneHour)
            
            // set timeInterval for grabbing data from hour period
            var component = DateComponents()
            component.hour = 1
            
            let predicate = HKQuery.predicateForSamples(withStart: oneHourAgo, end: now, options: [])
            
            query = HKStatisticsCollectionQuery(quantityType: steps, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: now, intervalComponents: component)
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = { [unowned self] query, collection, error in
                
                self.configure(query: query, collectionStats: collection, error: error, completionHandler: completionHandler)
            }
            
        // Get the sum of the steps from today and state the timeInterval you want to recevie batches of steps count defaults to each hour
        case let .today(timeInterval):
            
            // create predicate for start and end of day
            let predicate = try NSPredicate.today()
            
            // set timeInterval for grabbing data batches (in mins)
            var component = DateComponents()
            component.hour = timeInterval ?? 1
            
            query = HKStatisticsCollectionQuery(quantityType: steps, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: Date().startOfDay, intervalComponents: component)
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = { [unowned self]
                query, collection, error in

                self.configure(query: query, collectionStats: collection, error: error, completionHandler: completionHandler)
            }
        
        // Get the sum of the steps from week and state the timeInterval you want to recevie batches of steps count defaults to each day
        case let .thisWeek(timeInterval):
            
            // create predicate for start and end of week
            let predicate = try NSPredicate.thisWeek()
            
            // set timeInterval for grabbing data batches (in mins)
            var component = DateComponents()
            component.hour = timeInterval ?? 1
            
            query = HKStatisticsCollectionQuery(quantityType: steps, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: Date().startOfWeek!, intervalComponents: component)
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = { [unowned self]
                query, collection, error in
                
                self.configure(query: query, collectionStats: collection, error: error, completionHandler: completionHandler)
            }
            
            
        // Get the steps from within a time preference and select timeInterval batches that want from time period
        case let .betweenTimePref(start, end, timeInterval):
            
            // create predicate for timePref
            let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: [])
            
            // set timeInterval for grabbing data batches (in mins)
            var component = DateComponents()
            component.hour = timeInterval
            
            query = HKStatisticsCollectionQuery(quantityType: steps, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: start, intervalComponents: component)
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = { [unowned self]
                query, collection, error in
                self.configure(query: query, collectionStats: collection, error: error, completionHandler: completionHandler)
            }
        }
        healthStore.execute(query)
    }
}

private extension StepsService {
    
    func configure(query: HKStatisticsCollectionQuery, collectionStats: HKStatisticsCollection?, error: Error?, completionHandler: @escaping (AsyncCallResult<Steps>) -> Void) {
        
        guard error == nil else {
            completionHandler(.failed(error!))
            return
        }
        
        guard let quantitySamples = collectionStats?.statistics() else {
            completionHandler(.failed(MBAsyncParsingError.unableToParse("Steps log")))
            return
        }
        
        let items = quantitySamples.map {
            Steps.StepsItem(count: $0.sumQuantity()?.doubleValue(for: HKUnit(from: StepsConfig.stepsCount)))
        }
        
        let vm = Steps(items: items)
        completionHandler(.success(vm))
    }
    
}
