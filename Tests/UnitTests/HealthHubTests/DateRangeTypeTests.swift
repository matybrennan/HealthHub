import Testing
import Foundation
import HealthKit
@testable import HealthHub

@Suite("DateRangeType Suite")
struct DateRangeTypeTests {

    @Test("allTime predicate is nil")
    func allTimePredicate() throws {
        let predicate = try DateRangeType.allTime.predicate()
        #expect(predicate == nil)
    }

    @Test("today predicate is non-nil")
    func todayPredicate() throws {
        let predicate = try DateRangeType.today.predicate()
        #expect(predicate != nil)
    }

    @Test("thisWeek predicate is non-nil")
    func thisWeekPredicate() throws {
        let predicate = try DateRangeType.thisWeek.predicate()
        #expect(predicate != nil)
    }

    @Test("thisMonth predicate is non-nil")
    func thisMonthPredicate() throws {
        let predicate = try DateRangeType.thisMonth.predicate()
        #expect(predicate != nil)
    }

    @Test("lastNDays predicate is non-nil")
    func lastNDaysPredicate() throws {
        let predicate = try DateRangeType.lastNDays(7).predicate()
        #expect(predicate != nil)
    }

    @Test("betweenDates predicate is non-nil")
    func betweenDatesPredicate() throws {
        let start = Date().addingTimeInterval(-86400)
        let end = Date()
        let predicate = try DateRangeType.betweenDates(start: start, end: end).predicate()
        #expect(predicate != nil)
    }

    @Test("All non-allTime cases produce a predicate")
    func allNonAllTimeCasesHavePredicate() throws {
        let start = Date().addingTimeInterval(-86400)
        let cases: [DateRangeType] = [.today, .thisWeek, .thisMonth, .lastNDays(30), .betweenDates(start: start, end: Date())]
        for dateRange in cases {
            let predicate = try dateRange.predicate()
            #expect(predicate != nil, "\(dateRange) should return a non-nil predicate")
        }
    }
}
