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
    
    public func getSteps(fromStepsType type: StepsType, completionHandler: @escaping (AsyncCallResult<StepsVM>) -> Void) throws {
        
        // Confirm that the type and device works
        let steps = try HealthType.unbox(quantityIdentifier: .stepCount)
        try authorizationStatusSuccessful(for: steps)
        
        var query: HKQuery!
        
        switch type {
            
        case .lastHour:
            
            let now = Date()
            let oneHourAgo = Date(timeIntervalSinceNow: -StepsConfig.oneHour)
            
            // Get order from last steps recorded to previous time
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            let predicate = HKQuery.predicateForSamples(withStart: oneHourAgo, end: now, options: [])
            
            query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate, options: [.cumulativeSum], completionHandler: { (query, stats, error) in
                //
            })
            
            
        case let .today(timeInterval):
            
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
            component.hour = timeInterval
            
            query = HKStatisticsCollectionQuery(quantityType: steps, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startDate, intervalComponents: component)
            
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                
                guard error == nil else {
                    completionHandler(.failed(error!))
                    return
                }
                
                guard let quantitySamples = collection?.statistics() else {
                    completionHandler(.failed(StepsParsingError.unableToParse("Today steps")))
                    return
                }
                
                let items = quantitySamples.map {
                    StepsVM.StepsItem(count: $0.sumQuantity()?.doubleValue(for: HKUnit(from: StepsConfig.stepsCount)))
                }
                
                let vm = StepsVM(items: items)
                completionHandler(.success(vm))
            }
            
            
        case .thisWeek: break
        case .betweenTimePref: break
            
        }
        
        
        healthStore.execute(query)
    }
    
    
}
