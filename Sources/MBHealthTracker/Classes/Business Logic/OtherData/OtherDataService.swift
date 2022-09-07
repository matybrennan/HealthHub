//
//  OtherDataService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation
import HealthKit

public class OtherDataService {
    
    public init() { }
}

// MARK: OtherDataServiceProtocol
extension OtherDataService: OtherDataServiceProtocol {
    
    public func alcoholConsumption(handler: @escaping (MBAsyncCallResult<AlcoholConsumption>) -> Void) throws {
        // Confirm that the type and device works
        let alcoholConsumptionType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .numberOfAlcoholicBeverages)
        
        let query = HKSampleQuery(sampleType: alcoholConsumptionType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("alcoholConsumption log")))
                return
            }
            
            let items = quantitySamples.map { item -> AlcoholConsumption.Item in
                let drinks = item.quantity.doubleValue(for: HKUnit.count())
                return AlcoholConsumption.Item(drinks: drinks, date: item.startDate)
            }
            
            let model = AlcoholConsumption(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func alcoholContent(handler: @escaping (MBAsyncCallResult<AlcoholContent>) -> Void) throws {
        let alcoholContentType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bloodAlcoholContent)
        
        let query = HKSampleQuery(sampleType: alcoholContentType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("alcoholContent log")))
                return
            }
            
            let items = quantitySamples.map { item -> AlcoholContent.Item in
                let percentage = item.quantity.doubleValue(for: .percent()) * 100
                return AlcoholContent.Item(percentage: percentage, date: item.startDate)
            }
            
            let model = AlcoholContent(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func handWashing(handler: @escaping (MBAsyncCallResult<HandWashing>) -> Void) throws {
        let handWashingType = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .handwashingEvent)
        
        let query = HKSampleQuery(sampleType: handWashingType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("\(handWashingType.identifier) log")))
                return
            }
            
            let items = categorySamples.map { item -> HandWashing.Item in
                let duration = Int(item.endDate.timeIntervalSince(item.startDate))
                return HandWashing.Item(duration: duration, date: item.startDate)
            }
            
            let model = HandWashing(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func inhalerUsage(handler: @escaping (MBAsyncCallResult<InhalerUsage>) -> Void) throws {
        
        let inhalerUsageType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .inhalerUsage)
        
        let query = HKSampleQuery(sampleType: inhalerUsageType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("inhalerUsageType log")))
                return
            }
            
            let items = quantitySamples.map { item -> InhalerUsage.Item in
                let value = Int(item.quantity.doubleValue(for: HKUnit.count()))
                return InhalerUsage.Item(value: value, date: item.startDate)
            }
            
            let model = InhalerUsage(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func insulinDelivery(handler: @escaping (MBAsyncCallResult<InsulinDelivery>) -> Void) throws {
        
        let insulinDeliveryType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .insulinDelivery)
        
        let query = HKSampleQuery(sampleType: insulinDeliveryType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("insulinDelivery log")))
                return
            }
            
            let items = quantitySamples.map { item -> InsulinDelivery.Item in
                let value = item.quantity.doubleValue(for: HKUnit(from: "IU"))
                let purposeInt = item.metadata?[HKMetadataKeyInsulinDeliveryReason] as? Int ?? 1
                let purpose = InsulinDelivery.Item.Purpose(rawValue: purposeInt)!
                
                return InsulinDelivery.Item(value: value, purpose: purpose, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = InsulinDelivery(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func numberOfTimesFallen(handler: @escaping (MBAsyncCallResult<NumberOfTimesFallen>) -> Void) throws {
        
        let numberOfTimesFallenType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .numberOfTimesFallen)
        
        let query = HKSampleQuery(sampleType: numberOfTimesFallenType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("numberOfTimesFallenType log")))
                return
            }
            
            let items = quantitySamples.map { item -> NumberOfTimesFallen.Item in
                let value = Int(item.quantity.doubleValue(for: HKUnit.count()))
                return NumberOfTimesFallen.Item(value: value, date: item.startDate)
            }
            
            let model = NumberOfTimesFallen(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func toothBrushing(handler: @escaping (MBAsyncCallResult<ToothBrushing>) -> Void) throws {
        
        let toothBrushingType = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .toothbrushingEvent)
        
        let query = HKSampleQuery(sampleType: toothBrushingType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKCategorySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("toothBrushingType log")))
                return
            }
            
            let items = quantitySamples.map { item -> ToothBrushing.Item in
                let duration = Int(item.endDate.timeIntervalSince(item.startDate))
                return ToothBrushing.Item(durationSeconds: duration, date: item.startDate)
            }
            
            let model = ToothBrushing(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func uvExposure(handler: @escaping (MBAsyncCallResult<UVExposure>) -> Void) throws {
        
        let uvExposureType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .uvExposure)
        
        let query = HKSampleQuery(sampleType: uvExposureType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("uvExposureType log")))
                return
            }
            
            let items = quantitySamples.map { item -> UVExposure.Item in
                let value = Int(item.quantity.doubleValue(for: HKUnit.count()))
                return UVExposure.Item(value: value, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = UVExposure(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
}
