//
//  BodyServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 20/9/19.
//

import Foundation

public protocol BodyServiceProtocol: AnyObject {
    
    func basalBodyTemperature(handler: @escaping (MBAsyncCallResult<BasalBodyTemperature>) -> Void) throws
    func bodyFatPercentage(completionHandler: @escaping (MBAsyncCallResult<BodyFatPercentage>) -> Void) throws
    func bodyMassIndex(completionHandler: @escaping (MBAsyncCallResult<BodyMassIndex>) -> Void) throws
    func bodyTemperature(handler: @escaping (MBAsyncCallResult<BodyTemperature>) -> Void) throws
    func height(completionHandler: @escaping (MBAsyncCallResult<BodyHeight>) -> Void) throws
    func leanBodyMass(completionHandler: @escaping (MBAsyncCallResult<LeanBodyMass>) -> Void) throws
    func waistCircumference(completionHandler: @escaping (MBAsyncCallResult<WaistCircumference>) -> Void) throws
    func weight(completionHandler: @escaping (MBAsyncCallResult<BodyWeight>) -> Void) throws
    func electrodermalActivity(completionHandler: @escaping (MBAsyncCallResult<ElectrodermalActivity>) -> Void) throws
    
}
