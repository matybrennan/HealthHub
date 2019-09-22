//
//  BodyServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 20/9/19.
//

import Foundation

// TODO: Need to add height and lean body mass

public protocol BodyServiceProtocol: AnyObject {
    func bodyWeight(completionHandler: @escaping (MBAsyncCallResult<BodyWeight>) -> Void) throws
    func bodyFatPercentage(completionHandler: @escaping (MBAsyncCallResult<BodyFatPercentage>) -> Void) throws
    func bodyMassIndex(completionHandler: @escaping (MBAsyncCallResult<BodyMassIndex>) -> Void) throws
    func bodyWaistCircumference(completionHandler: @escaping (MBAsyncCallResult<WaistCircumference>) -> Void) throws
}
