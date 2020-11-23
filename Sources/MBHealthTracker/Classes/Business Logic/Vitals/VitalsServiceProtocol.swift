//
//  VitalsServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 9/12/19.
//

import Foundation

public protocol VitalsServiceProtocol: AnyObject {
    
    func bloodPressure(completionHandler: @escaping (MBAsyncCallResult<BloodPressure>) -> Void) throws
    func respiratoryRate(completionHandler: @escaping (MBAsyncCallResult<RespiratoryRate>) -> Void) throws
    func bodyTemperature(completionHandler: @escaping (MBAsyncCallResult<BodyTemperature>) -> Void) throws
}

