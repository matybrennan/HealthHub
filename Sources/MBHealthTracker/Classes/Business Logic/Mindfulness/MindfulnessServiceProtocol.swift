//
//  MindfulnessServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 24/9/19.
//

import Foundation

public protocol MindfulnessServiceProtocol: AnyObject {
    
    func getMindfulActivity(completionHandler: @escaping (MBAsyncCallResult<Mindful>) -> Void) throws
    func save(mindful: Mindful.Info, extra: [String : Any]?, completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws
}
