//
//  SleepServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 1/12/18.
//

import Foundation

public enum MBSleepStyle: Int {
    
    case inBed
    case asleep
    case awake
}

public protocol SleepServiceProtocol {
    
    func getSleep(completionHandler: @escaping (MBAsyncCallResult<Sleep>) -> Void) throws
    func save(sleep: Sleep.Info, extra: [String : Any]?, completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws
}
