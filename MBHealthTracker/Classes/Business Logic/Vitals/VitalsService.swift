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
    
    public func bodyTemperature(completionHandler: @escaping (MBAsyncCallResult<BodyTemperature>) -> Void) throws {
        
        // Confirm that the type and device works
        let bodyTemperatureType = try MBHealthParser.unbox(quantityIdentifier: .bodyTemperature)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: bodyTemperatureType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("bodyTemperature log")))
                return
            }
            
            let items = quantitySamples.map { item -> BodyTemperature.Info in
                let celsius = item.quantity.doubleValue(for: .degreeCelsius())
                let fahrenheit = item.quantity.doubleValue(for: .degreeFahrenheit())
                
                return BodyTemperature.Info(celsius: celsius, fahrenheit: fahrenheit, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = BodyTemperature(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
}

