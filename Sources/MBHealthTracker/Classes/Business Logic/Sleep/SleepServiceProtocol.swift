//
//  SleepServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 1/12/18.
//

import Foundation

@MainActor
public protocol SleepServiceProtocol: Sendable {

    func sleep() async throws -> Sleep
    func save(model: Sleep, extra: [String: Sendable]?) async throws
}
