//
//  ConfigurationServiceProtocol.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit


public protocol ConfigurationServiceProtocol {
    
    func requestAuthorization(toShare share: Set<HKSampleType>?, toRead read: Set<HKObjectType>?, completionHandler: @escaping (AsyncCallResult<Bool>) -> Void)
    
    func navigateToHealthSettings()
    
}
