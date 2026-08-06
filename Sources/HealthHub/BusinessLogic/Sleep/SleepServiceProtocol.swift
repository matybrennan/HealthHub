//
//  SleepServiceProtocol.swift
//  HealthHub
//
//  Created by matybrennan on 1/12/18.
//

import Foundation

public protocol SleepServiceProtocol {
    func sleep() async throws -> Sleep
    func sleepApneaEvent() async throws -> SleepApneaEvent
    func sleepingBreathingDisturbances() async throws -> SleepingBreathingDisturbances
    func save(model: Sleep, extra: [String: Sendable]?) async throws
}
