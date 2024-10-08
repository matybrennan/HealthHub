//
//  SleepServiceProtocol.swift
//  HealthHub
//
//  Created by matybrennan on 1/12/18.
//

import Foundation

public protocol SleepServiceProtocol: Sendable {
    func sleep() async throws -> Sleep
    func save(model: Sleep, extra: [String: Sendable]?) async throws
}
