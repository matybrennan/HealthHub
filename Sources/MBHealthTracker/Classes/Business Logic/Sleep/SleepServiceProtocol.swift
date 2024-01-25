//
//  SleepServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 1/12/18.
//

import Foundation

public protocol SleepServiceProtocol {
    
    func sleep() async throws -> Sleep
    func save(sleep: Sleep.Info, extra: [String : Any]?) async throws
}
