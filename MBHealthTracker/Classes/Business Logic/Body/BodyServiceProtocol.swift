//
//  BodyServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 20/9/19.
//

import Foundation

public protocol BodyServiceProtocol {
    func bodyWeight(completionHandler: @escaping (MBAsyncCallResult<BodyWeight>) -> Void) throws
    func bodyFatPercentage(completionHandler: @escaping (MBAsyncCallResult<BodyFatPercentage>) -> Void) throws
}
