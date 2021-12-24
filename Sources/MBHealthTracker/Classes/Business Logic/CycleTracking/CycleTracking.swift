//
//  CycleTracking.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation
import HealthKit

public class CycleTracking {
    
    public init() { }
}

// MARK: - CycleTrackingProtocol
extension CycleTracking: CycleTrackingProtocol {
    
    public func abdominalCramps(completionHandler: @escaping (MBAsyncCallResult<AbdominalCramp>) -> Void) throws {
        
        // Confirm that the type and device works
        let abdominalCrampsType = try MBHealthParser.unbox(categoryIdentifier: .abdominalCramps)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: abdominalCrampsType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKCategorySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("abdominalCramps log")))
                return
            }
            
            let items = quantitySamples.map { item -> AbdominalCramp.Item in
                let type = AbdominalCramp.Item.AbdominalCrampType(rawValue: item.value) ?? .notPresent
                return AbdominalCramp.Item(type: type, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = AbdominalCramp(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func acne(completionHandler: @escaping (MBAsyncCallResult<Acne>) -> Void) throws {
        
        // Confirm that the type and device works
        let acneType = try MBHealthParser.unbox(categoryIdentifier: .acne)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: acneType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKCategorySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("acne log")))
                return
            }
            
            let items = quantitySamples.map { item -> Acne.Item in
                let type = Acne.Item.AcneType(rawValue: item.value) ?? .notPresent
                return Acne.Item(type: type, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = Acne(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func basalBodyTemperature(completionHandler: @escaping (MBAsyncCallResult<BasalBodyTemperature>) -> Void) throws {
        
        // Confirm that the type and device works
        let basalBodyTempType = try MBHealthParser.unbox(quantityIdentifier: .basalBodyTemperature)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: basalBodyTempType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("BasalBodyTemperature log")))
                return
            }
            
            let items = quantitySamples.map { item -> BasalBodyTemperature.Info in
                let celsius = item.quantity.doubleValue(for: .degreeCelsius())
                let fahrenheit = item.quantity.doubleValue(for: .degreeFahrenheit())
                return BasalBodyTemperature.Info(celsius: celsius, fahrenheit: fahrenheit, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = BasalBodyTemperature(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func cervicalMucusQuality(completionHandler: @escaping (MBAsyncCallResult<CervicalMucusQuality>) -> Void) throws {
        
        // Confirm that the type and device works
        let cervicalMucusQualityType = try MBHealthParser.unbox(categoryIdentifier: .cervicalMucusQuality)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: cervicalMucusQualityType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("cervicalMucusQualityType log")))
                return
            }
            
            let items = categorySamples.map { item -> CervicalMucusQuality.Info in
                let type: CervicalMucusQuality.Info.MucusType = CervicalMucusQuality.Info.MucusType(rawValue: item.value) ?? .dry
                return CervicalMucusQuality.Info(type: type, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = CervicalMucusQuality(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func menstrualFlow(completionHandler: @escaping (MBAsyncCallResult<MenstrualFlow>) -> Void) throws {
        
        // Confirm that the type and device works
        let menstrualFlowType = try MBHealthParser.unbox(categoryIdentifier: .menstrualFlow)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: menstrualFlowType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("menstrualFlowType log")))
                return
            }
            
            let items = categorySamples.map { item -> MenstrualFlow.Info in
                
                let type: MenstrualFlow.Info.FlowType = MenstrualFlow.Info.FlowType(rawValue: item.value) ?? .unspecified
                let cycleStartInt = item.metadata?[HKMetadataKeyMenstrualCycleStart] as? Int ?? 0
                let isStartOfCylce = (cycleStartInt == 0) ? false : true
                return MenstrualFlow.Info(type: type, isStartOfCycle: isStartOfCylce, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = MenstrualFlow(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func ovulation(completionHandler: @escaping (MBAsyncCallResult<Ovulation>) -> Void) throws {
        
        // Confirm that the type and device works
        let ovulationType = try MBHealthParser.unbox(categoryIdentifier: .ovulationTestResult)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: ovulationType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("ovulationType log")))
                return
            }
            
            let items = categorySamples.map { item -> Ovulation.Info in
                
                let type: Ovulation.Info.ResultType = Ovulation.Info.ResultType(rawValue: item.value) ?? .indetermined
                return Ovulation.Info(type: type, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = Ovulation(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func sexualActivity(completionHandler: @escaping (MBAsyncCallResult<SexualActivity>) -> Void) throws {
        
        // Confirm that the type and device works
        let sexualActivityType = try MBHealthParser.unbox(categoryIdentifier: .sexualActivity)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: sexualActivityType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("sexualActivityType log")))
                return
            }
            
            let items = categorySamples.map { item -> SexualActivity.Info in
                
                let styleInt = item.metadata?[HKMetadataKeySexualActivityProtectionUsed] as? Int ?? -1
                let type: SexualActivity.Info.StyleType = SexualActivity.Info.StyleType(rawValue: styleInt) ?? .unspecified
                return SexualActivity.Info(type: type, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = SexualActivity(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func spotting(completionHandler: @escaping (MBAsyncCallResult<Spotting>) -> Void) throws {
        
        // Confirm that the type and device works
        let spottingType = try MBHealthParser.unbox(categoryIdentifier: .intermenstrualBleeding)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: spottingType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("spottingType log")))
                return
            }
            
            let items = categorySamples.map { item -> Spotting.Info in
                return Spotting.Info(startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = Spotting(items: items)
            completionHandler(.success(model))
        })
        
        healthStore.execute(query)
    }
}
