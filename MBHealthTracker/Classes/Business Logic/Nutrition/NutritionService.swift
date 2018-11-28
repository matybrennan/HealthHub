//
//  NutritionService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 5/24/18.
//

import Foundation
import HealthKit

public class NutritionService {
    
    public init() { }
    
}

extension NutritionService: NutritionServiceProtocol {
    
    public func getNutrition(fromType type: NutritionType, completionHandler: @escaping (AsyncCallResult<Nutrition>) -> Void) throws {
        
        // Confirm that the type and device works
        try isDataStoreAvailable()
        
        let unitToUse = getNutritionUnitMeasure(from: type)
        
        let query = HKSampleQuery(sampleType: type.value, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            
            guard error == nil else {
                completionHandler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKQuantitySample] else {
                completionHandler(.failed(MBAsyncParsingError.unableToParse("Unable to parse: Nutrition: \(type.value.identifier)")))
                return
            }
            
            let items = quantitySamples.map {

                Nutrition.NutritionInfo(value: $0.quantity.doubleValue(for: unitToUse.unit), unit: unitToUse.unitStr, startDate: $0.startDate, endDate: $0.endDate)
            }
            
            let vm = Nutrition(items: items)
            
            completionHandler(AsyncCallResult.success(vm))
        }
        healthStore.execute(query)
    }
}

private extension NutritionService {
    
    func getNutritionUnitMeasure(from nutritionType: NutritionType) -> (unit: HKUnit, unitStr: String) {
        
        var unitTuple: (HKUnit, String)!
        
        switch nutritionType {
            
        case .energyConsumed: unitTuple = (HKUnit.kilocalorie() , "kcal")
        case .carbohydrates: print("is carbs....")
            
        case .vitaminA: print("is vitaminA....")
            
        case .calcium: print("is calcium....")
        case .chloride: print("is chloride....")
        case .iron: unitTuple = (HKUnit(from: "mg") , "mg")
            
            
        }
        
        return unitTuple
    }
    
}
