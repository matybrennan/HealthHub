//
//  ConfigurationServiceProtocol.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit


public protocol ConfigurationServiceProtocol {
    
    func requestAuthorization(toShare share: [SharableType], toRead read: [ReadableType], completionHandler: @escaping (AsyncCallResult<Bool>) -> Void)
    
    func navigateToHealthSettings()
}
