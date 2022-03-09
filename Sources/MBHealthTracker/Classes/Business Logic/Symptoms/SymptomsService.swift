//
//  SymptomsService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation
import HealthKit

public class SymptomsService {
    
    public init() { }
}

// MARK: - Private methods
private extension SymptomsService {
    
    func fetchGenericSymptomResult(categoryIdentifier: HKCategoryTypeIdentifier, handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        
        // Confirm that the type and device works
        let type = try MBHealthParser.unbox(categoryIdentifier: categoryIdentifier)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: type, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKCategorySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("\(type.identifier) log")))
                return
            }
            
            let items = quantitySamples.map { item -> GenericCycleTrackingModel.Item in
                let style = GenericCycleTrackingModel.Item.Style(rawValue: item.value) ?? .notPresent
                return GenericCycleTrackingModel.Item(style: style, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = GenericCycleTrackingModel(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
}

// MARK: - SymptomsServiceProtocol
extension SymptomsService: SymptomsServiceProtocol {
    
    public func acne(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .acne, handler: handler)
    }
    
    public func appetiteChanges(handler: @escaping (MBAsyncCallResult<AppetiteChanges>) -> Void) throws {
            
            // Confirm that the type and device works
            let appetiteChangesType = try MBHealthParser.unbox(categoryIdentifier: .appetiteChanges)
            try isDataStoreAvailable()
            
            let query = HKSampleQuery(sampleType: appetiteChangesType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
                
                guard error == nil else {
                    handler(.failed(error!))
                    return
                }
                
                guard let quantitySamples = samples as? [HKCategorySample] else {
                    handler(.failed(MBAsyncParsingError.unableToParse("appetiteChanges log")))
                    return
                }
                
                let items = quantitySamples.map { item -> AppetiteChanges.Item in
                    let type = AppetiteChanges.Item.AppetiteChangesType(rawValue: item.value) ?? .noChange
                    return AppetiteChanges.Item(type: type, startDate: item.startDate, endDate: item.endDate)
                }
                
                let model = AppetiteChanges(items: items)
                handler(.success(model))
            })
            
            healthStore.execute(query)
    }
    
    public func bladderIncontinence(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .bladderIncontinence, handler: handler)
    }
    
    public func bodyAndMuscleAche(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .generalizedBodyAche, handler: handler)
    }
    
    public func chestTightnessOrPain(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .chestTightnessOrPain, handler: handler)
    }
    
    public func chills(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .chills, handler: handler)
    }
    
    public func congestion(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .sinusCongestion, handler: handler)
    }
    
    public func constipation(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .constipation, handler: handler)
    }
    
    public func coughing(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .coughing, handler: handler)
    }
    
    public func diarrhea(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .diarrhea, handler: handler)
    }
    
    public func drySkin(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .drySkin, handler: handler)
    }
    
    public func fainting(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .fainting, handler: handler)
    }
    
    public func fatigue(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .fatigue, handler: handler)
    }
    
    public func fever(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .fever, handler: handler)
    }
    
    public func hairLoss(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .hairLoss, handler: handler)
    }
    
    public func headache(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .headache, handler: handler)
    }
    
    public func heartBurn(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .heartburn, handler: handler)
    }
    
    public func hotFlushes(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .hotFlashes, handler: handler)
    }
    
    public func lossOfSmell(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .lossOfSmell, handler: handler)
    }
    
    public func lossOfTaste(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .lossOfTaste, handler: handler)
    }
    
    public func lowerBackPain(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .lowerBackPain, handler: handler)
    }
    
    public func memoryLapse(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .memoryLapse, handler: handler)
    }
    
    public func nausea(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .nausea, handler: handler)
    }
    
    public func nightSweats(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .nightSweats, handler: handler)
    }
    
    public func pelvicPain(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .pelvicPain, handler: handler)
    }
    
    public func rapidPoundingOrFlutteringHeartbeat(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .rapidPoundingOrFlutteringHeartbeat, handler: handler)
    }
    
    public func runnyNose(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .runnyNose, handler: handler)
    }
    
    public func shortnessOfBreath(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .shortnessOfBreath, handler: handler)
    }
    
    public func skippedHeartbeat(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .skippedHeartbeat, handler: handler)
    }
    
    public func sleepChanges(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .sleepChanges, handler: handler)
    }
    
    public func soreThroat(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .soreThroat, handler: handler)
    }
    
    public func vomiting(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .vomiting, handler: handler)
    }
    
    public func wheezing(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericSymptomResult(categoryIdentifier: .wheezing, handler: handler)
    }
}

