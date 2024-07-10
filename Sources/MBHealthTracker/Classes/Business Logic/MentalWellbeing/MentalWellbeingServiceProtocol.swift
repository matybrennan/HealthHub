//
//  MentalWellbeingService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 24/9/19.
//

import Foundation

@MainActor
public protocol MentalWellbeingServiceProtocol: Sendable {

    // Fetch
    func mindfulActivity() async throws -> Mindful
    func sleep() async throws -> Sleep
    func timeInDaylight() async throws -> TimeInDaylight

    // Save
    func save(mindful: Mindful, extra: [String : Any]?) async throws
    func save(model: Sleep, extra: [String : Any]?) async throws
    func saveTimeInDaylight(model: TimeInDaylight, extra: [String: Any]?) async throws
}
