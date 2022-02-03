//
//  VitalsServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 9/12/19.
//

import Foundation

public protocol VitalsServiceProtocol: AnyObject {
    
    func bloodGlucose(completionHandler: @escaping (MBAsyncCallResult<BloodGlucose>) -> Void) throws
    func bloodPressure(completionHandler: @escaping (MBAsyncCallResult<BloodPressure>) -> Void) throws
    func bloodOxygen(completionHandler: @escaping (MBAsyncCallResult<BloodOxygen>) -> Void) throws
}

