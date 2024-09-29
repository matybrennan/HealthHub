//
//  MentalWellbeingService.swift
//  HealthHub
//
//  Created by matybrennan on 24/9/19.
//

import Foundation

public protocol MentalWellbeingServiceProtocol: Sendable {

    // Fetch
    func mindfulActivity() async throws -> Mindful
    func sleep() async throws -> Sleep
    func timeInDaylight() async throws -> TimeInDaylight

    // Save
    func save(mindful: Mindful, extra: [String: Sendable]?) async throws
    func save(model: Sleep, extra: [String: Sendable]?) async throws
    func saveTimeInDaylight(model: TimeInDaylight, extra: [String: Sendable]?) async throws
}
