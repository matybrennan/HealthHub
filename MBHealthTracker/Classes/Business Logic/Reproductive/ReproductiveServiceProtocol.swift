//
//  ReproductiveServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation

public protocol ReproductiveServiceProtocol: AnyObject {
    
    func basalBodyTemperature(completionHandler: @escaping (MBAsyncCallResult<BasalBodyTemperature>) -> Void) throws
}
