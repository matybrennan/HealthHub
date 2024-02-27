//
//  SleepServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 1/12/18.
//

import Foundation

public protocol SleepServiceProtocol {
    
    func sleep() async throws -> Sleep
    func save(model: Sleep, extra: [String : Any]?) async throws
}
