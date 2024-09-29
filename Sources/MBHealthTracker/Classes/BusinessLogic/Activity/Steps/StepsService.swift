//
//  StepsService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

@Observable
public final class StepsService: @unchecked Sendable {

    struct StepsConfig {
        static let oneHour: TimeInterval = 3600
        static let stepsCount = "count"
    }

    public private(set) var lastHour = Steps(items: [])
    public private(set) var today = Steps(items: [])
    public private(set) var thisWeek = Steps(items: [])
    public private(set) var betweenTimePreference = Steps(items: [])

    public init() { }
}

extension StepsService: StepsServiceProtocol {
    
    public func steps(fromStepsType type: StepsType) throws {
        
        // Confirm that the type and device works
        let stepCountType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .stepCount)
        
        var query: HKQuery!
        
        switch type {
            
        // Get the sum of the last hour of steps
        case .lastHour:
            
            let now = Date()
            let oneHourAgo = Date(timeIntervalSinceNow: -StepsConfig.oneHour)
            
            // set timeInterval for grabbing data from hour period
            var component = DateComponents()
            component.hour = 1
            
            let predicate = HKQuery.predicateForSamples(withStart: oneHourAgo, end: now, options: [])
            
            query = HKStatisticsCollectionQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: now, intervalComponents: component)
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = { [weak self] query, collection, error in
                guard let self else { return }
                try? self.configure(query: query, collectionStats: collection, error: error, type: type)
            }
            
        // Get the sum of the steps from today and state the timeInterval you want to recevie batches of steps count defaults to each hour
        case let .today(timeInterval):
            
            // create predicate for start and end of day
            let predicate = try NSPredicate.today()
            
            // set timeInterval for grabbing data batches (in mins)
            var component = DateComponents()
            component.hour = timeInterval
            
            query = HKStatisticsCollectionQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: Date().startOfDay, intervalComponents: component)
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = { [weak self]
                query, collection, error in
                guard let self else { return }
                try? self.configure(query: query, collectionStats: collection, error: error, type: type)
            }
            
        // Get the sum of the steps from week and state the timeInterval you want to recevie batches of steps count defaults to each day
        case let .thisWeek(timeInterval):
            
            // create predicate for start and end of week
            let predicate = try NSPredicate.thisWeek()
            
            // set timeInterval for grabbing data batches (in mins)
            var component = DateComponents()
            component.hour = timeInterval
            
            query = HKStatisticsCollectionQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: Date().startOfWeek!, intervalComponents: component)
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = { [weak self]
                query, collection, error in
                guard let self else { return }
                try? self.configure(query: query, collectionStats: collection, error: error, type: type)
            }
            
            
        // Get the steps from within a time preference
        case let .betweenTimePreference(start, end):

            // create predicate for timePref
            let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: [])
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.second, .minute, .hour], from: start, to: end)
            
            query = HKStatisticsCollectionQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: start, intervalComponents: components)
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = { [weak self]
                query, collection, error in
                guard let self else { return }
                try? self.configure(query: query, collectionStats: collection, error: error, type: type)
            }
        }
        healthStore.execute(query)
    }

    public func reset(type: StepsType) {
        switch type {
        case .lastHour:
            lastHour = Steps(items: [])
        case .today:
            today = Steps(items: [])
        case .thisWeek:
            thisWeek = Steps(items: [])
        case .betweenTimePreference:
            betweenTimePreference = Steps(items: [])
        }
    }
}

private extension StepsService {
    
    func configure(query: HKStatisticsCollectionQuery, collectionStats: HKStatisticsCollection?, error: Error?, type: StepsType) throws {

        guard error == nil else {
            throw error!
        }
        
        guard let quantitySamples = collectionStats?.statistics() else {
            throw MBAsyncParsingError.unableToParse("Steps log")
        }
        
        let items = quantitySamples.compactMap { item -> Steps.Item? in
            guard let count = item.sumQuantity()?.doubleValue(for: HKUnit(from: StepsConfig.stepsCount)) else {
                return nil
            }
            return Steps.Item(count: count)
        }

        switch type {
        case .lastHour:
            let allItems = lastHour.items + items
            lastHour = Steps(items: allItems)
        case .today:
            let allItems = today.items + items
            today = Steps(items: allItems)
        case .thisWeek:
            let allItems = thisWeek.items + items
            thisWeek = Steps(items: allItems)
        case .betweenTimePreference:
            let allItems = betweenTimePreference.items + items
            betweenTimePreference = Steps(items: allItems)
        }
    }
}
