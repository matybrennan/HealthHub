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
        let alcoholConsumptionType = try MBHealthParser.unbox(quantityIdentifier: .numberOfAlcoholicBeverages)
        try isDataStoreAvailable()
        
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
        let alcoholContentType = try MBHealthParser.unbox(quantityIdentifier: .bloodAlcoholContent)
        try isDataStoreAvailable()
        
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
        let handWashingType = try MBHealthParser.unbox(categoryIdentifier: .handwashingEvent)
        try isDataStoreAvailable()
        
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
                let diffComponents = Calendar.current.dateComponents([.second], from: item.startDate, to: item.endDate)
                let duration = diffComponents.second ?? 0
                return HandWashing.Item(duration: duration, date: item.startDate)
            }
            
            let model = HandWashing(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
}
