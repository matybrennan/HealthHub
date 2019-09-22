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
    
    public func bodyWeight(completionHandler: @escaping (MBAsyncCallResult<BodyWeight>) -> Void) throws {
        
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
    
    public func bodyWaistCircumference(completionHandler: @escaping (MBAsyncCallResult<WaistCircumference>) -> Void) throws {
        
        // Confirm that the type and device works
        var waistCircumference: HKQuantityType!
        if #available(iOS 11.0, *) {
            waistCircumference = try MBHealthParser.unbox(quantityIdentifier: .waistCircumference)
        } else {
            waistCircumference = try MBHealthParser.unbox(quantityIdentifier: .bodyMassIndex)
        }
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
            
            let inches = result.quantity.doubleValue(for: HKUnit.init(from: .inch))
            let cm = result.quantity.doubleValue(for: HKUnit.init(from: .centimeter))
            let waistCircumference = WaistCircumference(inches: inches, cm: cm)
            completionHandler(.success(waistCircumference))
        }
        
        healthStore.execute(query)
    }
}
