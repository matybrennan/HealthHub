//
//  BodyServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 20/9/19.
//

import Foundation

public protocol BodyServiceProtocol: AnyObject {
    func bodyWeight(completionHandler: @escaping (MBAsyncCallResult<BodyWeight>) -> Void) throws
    func bodyFatPercentage(completionHandler: @escaping (MBAsyncCallResult<BodyFatPercentage>) -> Void) throws
    func bodyMassIndex(completionHandler: @escaping (MBAsyncCallResult<BodyMassIndex>) -> Void) throws
    func bodyLeanBodyMass(completionHandler: @escaping (MBAsyncCallResult<LeanBodyMass>) -> Void) throws
    func bodyHeight(completionHandler: @escaping (MBAsyncCallResult<BodyHeight>) -> Void) throws
    func bodyWaistCircumference(completionHandler: @escaping (MBAsyncCallResult<WaistCircumference>) -> Void) throws
}
