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
    case rem
    case core
    case deep
}

public protocol SleepServiceProtocol {
    
    func sleep() async throws -> Sleep
    func save(sleep: Sleep.Info, extra: [String : Any]?) async throws
}
