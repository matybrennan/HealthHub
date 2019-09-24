//
//  MindfulnessService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 24/9/19.
//

import Foundation
import HealthKit

public class MindfulnessService {
    
    public init() { }
}

extension MindfulnessService: MindfulnessServiceProtocol {
    
    public func getMindfulActivity(completionHandler: @escaping (MBAsyncCallResult<Mindful>) -> Void) throws {
        
        // Confirm that the type and device works
        let mindfulType = try MBHealthParser.unbox(categoryIdentifier: .mindfulSession)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: mindfulType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("Unable to parse mindful")))
                return
            }
            
            let items = categorySamples.map { item -> Mindful.Info in
                return Mindful.Info(value: item.value, startDate: item.startDate, endDate: item.endDate)
            }
            
            let vm = Mindful(items: items)
            
            completionHandler(MBAsyncCallResult.success(vm))
        }
        
        healthStore.execute(query)
    }
    
    public func save(mindful: Mindful.Info, extra: [String : Any]?, completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws {
        
        try checkSharingAuthorizationStatus(for: MBObjectType.mindful.sharable)
        try isDataStoreAvailable()
        
        let sampleObj = HKCategorySample(type: MBObjectType.mindful.sharable as! HKCategoryType, value: mindful.value, start: mindful.startDate, end: mindful.endDate, metadata: extra)
        
        healthStore.save(sampleObj) { (status, error) in
            if let error = error {
                completionHandler(.failed(error))
            } else {
                completionHandler(.success(status))
            }
        }
    }
}
