//
//  BodyService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 20/9/19.
//

import Foundation
import HealthKit

public class BodyService {
    
    public init() { }
}

extension BodyService: BodyServiceProtocol {
    
    public func basalBodyTemperature(handler: @escaping (MBAsyncCallResult<BasalBodyTemperature>) -> Void) throws {
        
        // Confirm that the type and device works
        let basalBodyTempType = try MBHealthParser.unbox(quantityIdentifier: .basalBodyTemperature)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: basalBodyTempType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("BasalBodyTemperature log")))
                return
            }
            
            let items = quantitySamples.map { item -> BasalBodyTemperature.Info in
                let celsius = item.quantity.doubleValue(for: .degreeCelsius())
                let fahrenheit = item.quantity.doubleValue(for: .degreeFahrenheit())
                return BasalBodyTemperature.Info(celsius: celsius, fahrenheit: fahrenheit, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = BasalBodyTemperature(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func bodyFatPercentage(completionHandler: @escaping (MBAsyncCallResult<BodyFatPercentage>) -> Void) throws {
        
        // Confirm that the type and device works
        let bodyFatPercentage = try MBHealthParser.unbox(quantityIdentifier: .bodyFatPercentage)
        try isDataStoreAvailable()
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: bodyFatPercentage, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let result = results?.first as? HKQuantitySample  else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("bodyFatPercentage")))
                return
            }
            
            let value = result.quantity.doubleValue(for: HKUnit.percent()) * 100
            let bodyFatPercentage = BodyFatPercentage(value: value)
            completionHandler(.success(bodyFatPercentage))
        }
        
        healthStore.execute(query)
    }
    
    public func bodyMassIndex(completionHandler: @escaping (MBAsyncCallResult<BodyMassIndex>) -> Void) throws {
        
        // Confirm that the type and device works
        let bodyMassIndex = try MBHealthParser.unbox(quantityIdentifier: .bodyMassIndex)
        try isDataStoreAvailable()
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: bodyMassIndex, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let result = results?.first as? HKQuantitySample  else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("bodyMassIndex")))
                return
            }
            
            let value = result.quantity.doubleValue(for: HKUnit.count())
            let bodyMassIndex = BodyMassIndex(value: value)
            completionHandler(.success(bodyMassIndex))
        }
        
        healthStore.execute(query)
    }
    
    public func bodyTemperature(handler: @escaping (MBAsyncCallResult<BodyTemperature>) -> Void) throws {
        
        // Confirm that the type and device works
        let bodyTemperatureType = try MBHealthParser.unbox(quantityIdentifier: .bodyTemperature)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: bodyTemperatureType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("bodyTemperature log")))
                return
            }
            
            let items = quantitySamples.map { item -> BodyTemperature.Info in
                let celsius = item.quantity.doubleValue(for: .degreeCelsius())
                let fahrenheit = item.quantity.doubleValue(for: .degreeFahrenheit())
                
                return BodyTemperature.Info(celsius: celsius, fahrenheit: fahrenheit, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = BodyTemperature(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func bodyTemperature(handler: @escaping (MBAsyncCallResult<BasalBodyTemperature>) -> Void) throws {
        
    }
    
    public func height(completionHandler: @escaping (MBAsyncCallResult<BodyHeight>) -> Void) throws {
        
        // Confirm that the type and device works
        let height = try MBHealthParser.unbox(quantityIdentifier: .height)
        try isDataStoreAvailable()
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: height, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let result = results?.first as? HKQuantitySample  else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("height")))
                return
            }
            
            let inches = Int(result.quantity.doubleValue(for: HKUnit.init(from: .inch)))
            let cm = Int(result.quantity.doubleValue(for: HKUnit.init(from: .centimeter)))
            let bodyHeight = BodyHeight(inches: inches, cm: cm)
            completionHandler(.success(bodyHeight))
        }
        
        healthStore.execute(query)
    }
    
    public func leanBodyMass(completionHandler: @escaping (MBAsyncCallResult<LeanBodyMass>) -> Void) throws {
        
        // Confirm that the type and device works
        let leanBodyMass = try MBHealthParser.unbox(quantityIdentifier: .leanBodyMass)
        try isDataStoreAvailable()
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: leanBodyMass, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let result = results?.first as? HKQuantitySample  else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("leanBodyMass")))
                return
            }
            
            let leanBodyMassKg = result.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            let leanBodyMasslbs = result.quantity.doubleValue(for: HKUnit.pound())
            let leanBodyMass = LeanBodyMass(kg: leanBodyMassKg, lbs: leanBodyMasslbs)
            completionHandler(.success(leanBodyMass))
        }
        
        healthStore.execute(query)
    }
    
    public func waistCircumference(completionHandler: @escaping (MBAsyncCallResult<WaistCircumference>) -> Void) throws {
        
        // Confirm that the type and device works
        let waistCircumference = try MBHealthParser.unbox(quantityIdentifier: .waistCircumference)
        try isDataStoreAvailable()
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: waistCircumference, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let result = results?.first as? HKQuantitySample  else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("waistCircumference")))
                return
            }
            
            let inches = Int(result.quantity.doubleValue(for: HKUnit.init(from: .inch)))
            let cm = Int(result.quantity.doubleValue(for: HKUnit.init(from: .centimeter)))
            let waistCircumference = WaistCircumference(inches: inches, cm: cm)
            completionHandler(.success(waistCircumference))
        }
        
        healthStore.execute(query)
    }
    
    public func weight(completionHandler: @escaping (MBAsyncCallResult<BodyWeight>) -> Void) throws {
        
        // Confirm that the type and device works
        let bodyWeight = try MBHealthParser.unbox(quantityIdentifier: .bodyMass)
        try isDataStoreAvailable()
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: bodyWeight, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let result = results?.first as? HKQuantitySample  else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("bodyWeight")))
                return
            }
            
            let bodyMassKg = result.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            let bodyMasslbs = result.quantity.doubleValue(for: HKUnit.pound())
            let bodyWeight = BodyWeight(kg: bodyMassKg, lbs: bodyMasslbs)
            completionHandler(.success(bodyWeight))
        }
        
        healthStore.execute(query)
    }
}
