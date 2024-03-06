//
//  HeartService.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/7/18.
//

import Foundation
import HealthKit

public class HeartService {
    
    struct Unit {
        static let heartRateCountMin = "count/min"
    }
    
    public init() { }
}

// MARK: - BloodPressureCase
extension HeartService: BloodPressureCase, CardioFitnessCase { }

extension HeartService: HeartServiceProtocol {
    
    public func atrialFibrillation() async throws -> AtrialFibrillationHistory {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .vo2Max)
        let items = samples.map { item -> AtrialFibrillationHistory.Item in
            let percentage = item.quantity.doubleValue(for: .percent())
            return AtrialFibrillationHistory.Item(percentage: percentage, date: item.endDate)
        }

        let vm = AtrialFibrillationHistory(items: items)
        return vm
    }

    public func bloodPressure() async throws -> BloodPressure {
        try await baseBloodPressure()
    }

    public func cardioFitness() async throws -> CardioFitness {
        try await baseCardioFitness()
    }

    public func cardioRecovery() async throws -> CardioRecovery {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .heartRateRecoveryOneMinute)
        let items = samples.map { item -> CardioRecovery.Item in
            let value = item.quantity.doubleValue(for: HKUnit(from: "count/min"))
            return CardioRecovery.Item(bpm: Int(value), date: item.endDate)
        }

        let model = CardioRecovery(items: items)
        return model
    }

    public func heartRate(fromHeartRateType type: HeartRateType, completionHandler: @escaping (MBAsyncCallResult<HeartRate>) -> Void) throws {
        
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
                    completionHandler(.failed(error!))
                    return
                }
                
                guard let quantitySample = samples?.first as? HKQuantitySample else {
                    completionHandler(MBAsyncCallResult.failed(MBAsyncParsingError.unableToParse("current heartRate or no heart rate samples")))
                    return
                }
                let hr = quantitySample.quantity.doubleValue(for: HKUnit(from: Unit.heartRateCountMin))
                let item = HeartRate.Item(max: hr, min: hr, average: hr)
                let vm = HeartRate(items: [item])
                completionHandler(.success(vm))
            })
            
        case let .today(interval):
            
            // create predicate for start and end of day
            let predicate = try NSPredicate.today()
            
            // set timeInterval for grabbing data batches (in mins)
            // If no interval is set create it for 1 hour batches
            var component = DateComponents()
            component.minute = interval ?? 60
            
            // create query
            query = HKStatisticsCollectionQuery(quantityType: heartRate, quantitySamplePredicate: predicate, options: [.discreteAverage, .discreteMax, .discreteMin], anchorDate: Date().startOfDay, intervalComponents: component)
            
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                self.configure(query: query, collection: collection, error: error, completionHandler: completionHandler)
            }
        case let .thisWeek(interval):
            
            // create predicate for start and end of day
            let predicate = try NSPredicate.thisWeek()
            
            var component = DateComponents()
            component.day = interval ?? 1
            
            // create query
            query = HKStatisticsCollectionQuery(quantityType: heartRate, quantitySamplePredicate: predicate, options: [.discreteAverage, .discreteMax, .discreteMin], anchorDate: Date().startOfDay, intervalComponents: component)
            
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                self.configure(query: query, collection: collection, error: error, completionHandler: completionHandler)
            }
        case let .all(interval):
            
            var component = DateComponents()
            component.day = interval ?? 1
            
            // create query
            query = HKStatisticsCollectionQuery(quantityType: heartRate, quantitySamplePredicate: nil, options: [.discreteAverage, .discreteMax, .discreteMin], anchorDate: Date().startOfDay, intervalComponents: component)
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                self.configure(query: query, collection: collection, error: error, completionHandler: completionHandler)
            }
            
        case let .betweenTimePref(startDate, endDate):
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.second, .minute, .hour], from: startDate, to: endDate)
            
            let pred = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
            query = HKStatisticsCollectionQuery(quantityType: heartRate, quantitySamplePredicate: pred, options: [.discreteAverage, .discreteMax, .discreteMin], anchorDate: startDate, intervalComponents: components)
            
            (query as! HKStatisticsCollectionQuery).initialResultsHandler = {
                query, collection, error in
                self.configure(query: query, collection: collection, error: error, completionHandler: completionHandler)
            }
        }
        
        healthStore.execute(query)
    }

    // MARK: - Save

    public func saveBloodPressure(model: BloodPressure, extra: [String : Any]?) async throws {
        try await baseSaveBloodPressure(model: model, extra: extra)
    }
    
    public func saveCardioFitness(model: CardioFitness, extra: [String : Any]?) async throws {
        try await saveBaseCardioFitness(model, extra: extra)
    }

    public func saveCardioRecovery(model: CardioRecovery, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .heartRateRecoveryOneMinute)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: "count/min")
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: Double($0.bpm))
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}

private extension HeartService {
    
    func configure(query: HKStatisticsCollectionQuery, collection: HKStatisticsCollection?, error: Error?, completionHandler: @escaping (MBAsyncCallResult<HeartRate>) -> Void) {
        guard error == nil else {
            completionHandler(.failed(error!))
            return
        }
        
        guard let quantitySamples = collection?.statistics() else {
            completionHandler(.failed(MBAsyncParsingError.unableToParse("HeartRate log")))
            return
        }

        let items = quantitySamples.compactMap { sample -> HeartRate.Item? in
            guard let max = sample.maximumQuantity()?.doubleValue(for: HKUnit(from: Unit.heartRateCountMin)) as? Double,
                let min = sample.minimumQuantity()?.doubleValue(for: HKUnit(from: Unit.heartRateCountMin)) as? Double,
                let average = sample.averageQuantity()?.doubleValue(for: HKUnit(from: Unit.heartRateCountMin)) as? Double else {
                return nil
            }
            return HeartRate.Item(max: max, min: min, average: average)
        }
        
        let vm = HeartRate(items: items)
        completionHandler(.success(vm))
    }
    
}
