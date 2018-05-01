//
//  ConfigurationServiceProtocol.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit


public protocol ConfigurationServiceProtocol {
    
    func requestAuthorization(toShare share: [MBShareType], toRead read: [MBReadType], completionHandler: @escaping (AsyncCallResult<Bool>) -> Void)
    
    func navigateToHealthSettings()
}
