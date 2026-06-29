//
//  MentalWellbeingServiceProtocol.swift
//  HealthHub
//
//  Created by matybrennan on 24/9/19.
//

import Foundation
import HealthKit

public enum MentalWellbeingType: String, CaseIterable, Sendable {
    case mindfulMinutes
    case stateOfMind
    case gad7
    case phq9
    case sleep
    case timeInDaylight

    public var displayName: String {
        switch self {
        case .mindfulMinutes: "Mindful Minutes"
        case .stateOfMind: "State of Mind"
        case .gad7: "Anxiety (GAD-7)"
        case .phq9: "Depression (PHQ-9)"
        case .sleep: "Sleep"
        case .timeInDaylight: "Time in Daylight"
        }
    }

    public var unit: String {
        switch self {
        case .mindfulMinutes: "min"
        case .stateOfMind: "valence"
        case .gad7: "score (0–21)"
        case .phq9: "score (0–27)"
        case .sleep: "hr"
        case .timeInDaylight: "min"
        }
    }
}

public protocol MentalWellbeingServiceProtocol {

    // Fetch
    func mindfulActivity() async throws -> Mindful
    func stateOfMind() async throws -> StateOfMindEntry
    func gad7() async throws -> GAD7Assessment
    func phq9() async throws -> PHQ9Assessment
    func sleep() async throws -> Sleep
    func timeInDaylight() async throws -> TimeInDaylight

    // Save
    func save(mindful: Mindful, extra: [String: Sendable]?) async throws
    func save(stateOfMind: StateOfMindEntry, extra: [String: Sendable]?) async throws
    func save(gad7: GAD7Assessment, extra: [String: Sendable]?) async throws
    func save(phq9: PHQ9Assessment, extra: [String: Sendable]?) async throws
    func save(model: Sleep, extra: [String: Sendable]?) async throws
    func saveTimeInDaylight(model: TimeInDaylight, extra: [String: Sendable]?) async throws
}
