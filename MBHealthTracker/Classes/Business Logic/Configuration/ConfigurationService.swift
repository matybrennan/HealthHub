//
//  ConfigurationService.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit


public class ConfigurationService {
    
    static let appleHealthAppURL = "x-apple-health://"
    
}

extension ConfigurationService: ConfigurationServiceProtocol {
    
    public func requestAuthorization(toShare share: Set<HKSampleType>?, toRead read: Set<HKObjectType>?, completionHandler: @escaping (AsyncCallResult<Bool>) -> Void) {
        
        healthStore.requestAuthorization(toShare: share, read: read) { (status, error) in
            if let error = error {
                completionHandler(.failed(error))
            } else {
                completionHandler(.success(status))
            }
        }
    }
    
    public func navigateToHealthSettings() {
        UIApplication.shared.open(URL(string: ConfigurationService.appleHealthAppURL)!, options: [:], completionHandler: nil)
    }
    
}
