//
//  ActiveEnergyServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/11/18.
//

import Foundation
import HealthKit

public enum ActiveEnergyType: Sendable {
    case today
    case thisWeek
    case betweenTimePref(start: Date, end: Date)

    func predicate() throws -> NSPredicate {
        switch self {
        case .today:
            try NSPredicate.today()
        case .thisWeek:
            try NSPredicate.thisWeek()
        case let .betweenTimePref(startDate, endDate):
            HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        }
    }
}

@MainActor
public protocol ActiveEnergyServiceProtocol: Sendable {
    
    func activeEnergy(from type: ActiveEnergyType) async throws -> ActiveEnergy
}
