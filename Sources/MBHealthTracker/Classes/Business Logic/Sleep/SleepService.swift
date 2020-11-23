//
//  SleepService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 1/12/18.
//

import Foundation
import HealthKit

public class SleepService {
    
    public init() { }
}

// MARK: - SleepServiceProtocol
extension SleepService: SleepServiceProtocol {
    
    public func getSleep(completionHandler: @escaping (MBAsyncCallResult<Sleep>) -> Void) throws {
        
        // Confirm that the type and device works
        try isDataStoreAvailable()
        let sleepType = MBObjectType.sleep.readable as! HKSampleType
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("Unable to parse sleep")))
                return
            }
            
            let items = categorySamples.map { item -> Sleep.Info in
                
                let style = MBSleepStyle(rawValue: item.value) ?? MBSleepStyle.awake
                
                return Sleep.Info(style: style, startDate: item.startDate, endDate: item.endDate)
            }
            
            let vm = Sleep(items: items)
            
            completionHandler(MBAsyncCallResult.success(vm))
        }
        
        healthStore.execute(query)
    }
    
    public func save(sleep: Sleep.Info, extra: [String : Any]?, completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws {
        
        try checkSharingAuthorizationStatus(for: MBObjectType.sleep.sharable)
        try isDataStoreAvailable()
        
        let sampleObj = HKCategorySample(type: MBObjectType.sleep.sharable as! HKCategoryType, value: sleep.style.rawValue, start: sleep.startDate, end: sleep.endDate, metadata: extra)
        
        healthStore.save(sampleObj) { (status, error) in
            if let error = error {
                completionHandler(.failed(error))
            } else {
                completionHandler(.success(status))
            }
        }
    }
}
