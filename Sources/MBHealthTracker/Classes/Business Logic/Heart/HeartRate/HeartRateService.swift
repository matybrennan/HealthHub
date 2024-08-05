//
//  File.swift
//  
//
//  Created by Maty Brennan on 5/8/2024.
//

import Foundation
import HealthKit

@MainActor
@Observable
public final class HeartRateService {

    struct Unit {
        static let heartRateCountMin = "count/min"
    }

    private(set) var current: HeartRate.Item?
    private(set) var today: [HeartRate.Item] = []
    private(set) var thisWeek: [HeartRate.Item] = []
    private(set) var allTime: [HeartRate.Item] = []
    private(set) var betweenTimePreference: [HeartRate.Item] = []

    public init() { }

    public func heartRate(fromHeartRateType type: HeartRateType) throws {

        // Confirm that the type and device works
        let heartRate = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .heartRate)

        var query: HKQuery!

        switch type {
        case .current:

            // Get last item in healthStore for heartRate
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            // create query for heartRate
            query = HKSampleQuery(sampleType: heartRate, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor], resultsHandler: { (query, samples, error) in

                guard error == nil else {
                    return
                }

                guard let quantitySample = samples?.first as? HKQuantitySample else {
                    let _ = MBAsyncParsingError.unableToParse("current heartRate or no heart rate samples")
                    return
                }
                let hr = quantitySample.quantity.doubleValue(for: HKUnit(from: Unit.heartRateCountMin))
                let item = HeartRate.Item(max: hr, min: hr, average: hr)
                self.current = item
            })

        case let .today(interval):

            // create predicate for start and end of day
            let predicate = try NSPredicate.today()

            // set timeInterval for grabbing data batches (in mins)
            // If no interval is set create it for 1 hour batches
            var component = DateComponents()
            component.minute = interval

            // create query
            query = HKStatisticsCollectionQuery(quantityType: heartRate, quantitySamplePredicate: predicate, options: [.discreteAverage, .discreteMax, .discreteMin], anchorDate: Date().startOfDay, intervalComponents: component)


            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                try? self.configure(query: query, collection: collection, error: error, type: .today(timeInterval: interval))
            }
        case let .thisWeek(interval):

            // create predicate for start and end of day
            let predicate = try NSPredicate.thisWeek()

            var component = DateComponents()
            component.day = interval

            // create query
            query = HKStatisticsCollectionQuery(quantityType: heartRate, quantitySamplePredicate: predicate, options: [.discreteAverage, .discreteMax, .discreteMin], anchorDate: Date().startOfDay, intervalComponents: component)


            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                try? self.configure(query: query, collection: collection, error: error, type: .thisWeek(timeInterval: interval))
            }
        case let .allTime(interval):

            var component = DateComponents()
            component.day = interval

            // create query
            query = HKStatisticsCollectionQuery(quantityType: heartRate, quantitySamplePredicate: nil, options: [.discreteAverage, .discreteMax, .discreteMin], anchorDate: Date().startOfDay, intervalComponents: component)

            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                try? self.configure(query: query, collection: collection, error: error, type: .allTime(timeInterval: interval))
            }

        case let .betweenTimePreference(startDate, endDate):

            let calendar = Calendar.current
            let components = calendar.dateComponents([.second, .minute, .hour], from: startDate, to: endDate)

            let pred = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
            query = HKStatisticsCollectionQuery(quantityType: heartRate, quantitySamplePredicate: pred, options: [.discreteAverage, .discreteMax, .discreteMin], anchorDate: startDate, intervalComponents: components)

            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                try? self.configure(query: query, collection: collection, error: error, type: .betweenTimePreference(start: startDate, end: endDate))
            }
        }

        healthStore.execute(query)
    }

    public func reset(type: HeartRateType) {
        switch type {
        case .current:
            current = nil
        case .today:
            today = []
        case .thisWeek:
            thisWeek = []
        case .allTime:
            allTime = []
        case .betweenTimePreference:
            betweenTimePreference = []
        }
    }
}

private extension HeartRateService {

    func configure(query: HKStatisticsCollectionQuery, collection: HKStatisticsCollection?, error: Error?, type: HeartRateType) throws {
        guard error == nil else {
            throw error!
        }

        guard let quantitySamples = collection?.statistics() else {
            throw MBAsyncParsingError.unableToParse("HeartRate log")
        }

        let items = quantitySamples.compactMap { sample -> HeartRate.Item? in
            guard let max = sample.maximumQuantity()?.doubleValue(for: HKUnit(from: Unit.heartRateCountMin)) as? Double,
                let min = sample.minimumQuantity()?.doubleValue(for: HKUnit(from: Unit.heartRateCountMin)) as? Double,
                let average = sample.averageQuantity()?.doubleValue(for: HKUnit(from: Unit.heartRateCountMin)) as? Double else {
                return nil
            }
            return HeartRate.Item(max: max, min: min, average: average)
        }

        switch type {
        case .current:
            break
        case .today:
            today = today + items
        case .thisWeek:
            thisWeek = thisWeek + items
        case .allTime:
            allTime = allTime + items
        case .betweenTimePreference:
            betweenTimePreference = betweenTimePreference + items
        }
    }
}
