//
//  VitalsService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 9/12/19.
//

import Foundation
import HealthKit

public class VitalsService {
    
    public init() { }
}

// MARK: - VitalsServiceProtocol
extension VitalsService: VitalsServiceProtocol {
    
    public func bloodPressure(completionHandler: @escaping (MBAsyncCallResult<BloodPressure>) -> Void) throws {
        
        // Confirm that the type and device works
        let bloodPressureSystolicType = try MBHealthParser.unbox(quantityIdentifier: .bloodPressureSystolic)
        let bloodPressureDiastolicType = try MBHealthParser.unbox(quantityIdentifier: .bloodPressureDiastolic)
        let bloodPressureType = try MBHealthParser.unbox(correlationIdentifier: .bloodPressure)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: bloodPressureType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let correlationSamples = samples as? [HKCorrelation] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("bloodPressure log")))
                return
            }
            
            let items = correlationSamples.compactMap { item -> BloodPressure.Info? in
                guard let systolic = item.objects(for: bloodPressureSystolicType).first as? HKQuantitySample else { return nil }
                guard let diastolic = item.objects(for: bloodPressureDiastolicType).first as? HKQuantitySample else { return nil }
                
                let value1 = systolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                let value2 = diastolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                
                return BloodPressure.Info(systolic: value1, diastolic: value2, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = BloodPressure(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func respiratoryRate(completionHandler: @escaping (MBAsyncCallResult<RespiratoryRate>) -> Void) throws {
        
        // Confirm that the type and device works
        let respiratoryRateType = try MBHealthParser.unbox(quantityIdentifier: .respiratoryRate)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: respiratoryRateType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("respiratoryRate log")))
                return
            }
            
            let items = quantitySamples.map { item -> RespiratoryRate.Info in
                let value = item.quantity.doubleValue(for: HKUnit(from: "count/min"))
                
                return RespiratoryRate.Info(value: value, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = RespiratoryRate(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func bloodGlucose(completionHandler: @escaping (MBAsyncCallResult<BloodGlucose>) -> Void) throws {
        
        // Confirm that the type and device works
        let bloodGlucoseType = try MBHealthParser.unbox(quantityIdentifier: .bloodGlucose)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: bloodGlucoseType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("bloodGlucoseType log")))
                return
            }
            
            let items = quantitySamples.map { item -> BloodGlucose.Item in
                let glucoseLevel = item.quantity.doubleValue(for: HKUnit(from: "mg/dL"))
                let mealtimeInt = item.metadata?[HKMetadataKeyBloodGlucoseMealTime] as? Int ?? 0
                let mealTime = BloodGlucose.Item.MealTime(rawValue: mealtimeInt) ?? .unspecified
                return BloodGlucose.Item(date: item.startDate, bloodGlucose: glucoseLevel, mealTime: mealTime)
            }
            
            let model = BloodGlucose(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func bloodOxygen(completionHandler: @escaping (MBAsyncCallResult<BloodOxygen>) -> Void) throws {
        
        // Confirm that the type and device works
        let bloodOxygenType = try MBHealthParser.unbox(quantityIdentifier: .oxygenSaturation)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: bloodOxygenType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("bloodOxygenType log")))
                return
            }
            
            let items = quantitySamples.map { item -> BloodOxygen.Item in
                let percentage = item.quantity.doubleValue(for: .percent())
                return BloodOxygen.Item(date: item.startDate, oxygenSaturationPercentage: percentage)
            }
            
            let model = BloodOxygen(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
}

