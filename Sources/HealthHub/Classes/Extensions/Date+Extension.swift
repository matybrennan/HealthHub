//
//  Date+Extension.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation

extension Date {
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        Calendar.current.date(byAdding: DateComponents(day: 1, second: -1), to: startOfDay) ?? startOfDay
    }

    var startOfWeek: Date? {
        let calendar = Calendar(identifier: .gregorian)
        guard let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else {
            return nil
        }
        return calendar.date(byAdding: .day, value: 1, to: weekStart)
    }
    
    var endOfWeek: Date? {
        guard let start = startOfWeek else { return nil }
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: 6, to: start)?.endOfDay
    }
    
    func minutes(from start: Date, to end: Date) -> Int  {
        Calendar.current.dateComponents([.minute], from: start, to: end).minute ?? 0
    }
}
