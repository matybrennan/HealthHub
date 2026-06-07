//
//  NSPredicate+Extension.swift
//  HealthHub
//
//  Created by matybrennan on 9/4/18.
//

import Foundation
import HealthKit

enum NSPredicateError: LocalizedError {
    case unableToGetDate
    
    var errorDescription: String? {
        switch self {
        case .unableToGetDate:
            "Unable to calculate date"
        }
    }
}

extension NSPredicate {
    
    static func thisWeek() throws -> NSPredicate {
        let now = Date()
        guard let startDate = now.startOfWeek else { throw NSPredicateError.unableToGetDate }
        let endDate = now.endOfWeek
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
        return predicate
    }
    
    static func today() throws -> NSPredicate {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: now)
        guard let startDate = calendar.date(from: components) else { throw NSPredicateError.unableToGetDate }
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
        return predicate
    }
}
