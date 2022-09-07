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
    
    public func getNutrition(fromType type: NutritionType, completionHandler: @escaping (MBAsyncCallResult<Nutrition>) -> Void) throws {
        
        // Confirm that the type and device works
        let _ = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: HKQuantityTypeIdentifier(rawValue: type.value.identifier))
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

                Nutrition.Info(value: $0.quantity.doubleValue(for: unitToUse.unit), unit: unitToUse.unitStr, startDate: $0.startDate, endDate: $0.endDate, type: type.value)
            }
            
            let vm = Nutrition(items: items)
            
            completionHandler(MBAsyncCallResult.success(vm))
        }
        healthStore.execute(query)
    }
    
    public func save(nutrition: Nutrition.Info, extra: [String : Any]?, completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) throws {
        
        let nutritionType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: HKQuantityTypeIdentifier(rawValue: nutrition.type.identifier))
        
        let quantity = HKQuantity(unit: HKUnit(from: nutrition.unit), doubleValue: nutrition.value)
        let nutritionObj = HKQuantitySample.init(type: nutritionType, quantity: quantity, start: nutrition.startDate, end: nutrition.endDate, metadata: extra)
        
        healthStore.save(nutritionObj) { (status, error) in
            if let error = error {
                completionHandler(.failed(error))
            } else {
                completionHandler(.success(status))
            }
        }
    }
}

private extension NutritionService {
    
    func getNutritionUnitMeasure(from nutritionType: NutritionType) -> (unit: HKUnit, unitStr: String) {
        
        var unitTuple: (HKUnit, String)!
        
        switch nutritionType {
           
        // Macronutrients
        case .energyConsumed: unitTuple = (HKUnit.kilocalorie(), "kcal")
        case .carbohydrates: unitTuple = (HKUnit.gram(), "g")
        case .fiber: unitTuple = (HKUnit.gram(), "g")
        case .sugar: unitTuple = (HKUnit.gram(), "g")
        case .fatTotal: unitTuple = (HKUnit.gram(), "g")
        case .fatMono: unitTuple = (HKUnit.gram(), "g")
        case .fatPoly: unitTuple = (HKUnit.gram(), "g")
        case .fatSaturated: unitTuple = (HKUnit.gram(), "g")
        case .cholesterol: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .protein: unitTuple = (HKUnit.gram(), "g")
        
        
        // Vitamins
        case .vitaminA: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .thiamin: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .riboflavin: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .niacin: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .pathothenicAcid: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .vitaminB6: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .biotin: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .vitaminB12: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .vitaminC: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .vitaminD: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .vitaminE: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .vitaminK: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .folate: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        
        /// Minerals
        case .calcium: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .chloride: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .iron: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .magnesium: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .phosphorus: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .potassium: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .sodium: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .zinc: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
            
            
        /// Ultratrace Minerals
        case .chromium: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .copper: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .iodine: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .manganese: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
        case .molybdenum: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
        case .selenium: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.micro), "mcg")
            
        /// Hydration
        case .water: unitTuple = (HKUnit.literUnit(with: HKMetricPrefix.milli), "mL")
            
        /// Caffeine
        case .caffeine: unitTuple = (HKUnit.gramUnit(with: HKMetricPrefix.milli), "mg")
            
        }
        
        return unitTuple
    }
    
}
