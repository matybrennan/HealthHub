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

// MARK: - FetchQuantitySample
extension NutritionService: FetchQuantitySample { }

// MARK: - NutritionServiceProtocol
extension NutritionService: NutritionServiceProtocol {
    
    public func nutrition(type: NutritionType) async throws -> Nutrition {
        let identifier = HKQuantityTypeIdentifier(rawValue: type.quantityType.identifier)
        let unitToUse = type.unitMeasure
        let samples = try await fetchQuantitySamples(quantityIdentifier: identifier)
        
        let items = samples.map {
            Nutrition.Info(value: $0.quantity.doubleValue(for: unitToUse.unit), unit: unitToUse.unitStr, date: $0.endDate, type: type.quantityType)
        }
        
        let vm = Nutrition(items: items)
        return vm
    }
    
    public func save(nutrition: Nutrition.Info, extra: [String : Any]?) async throws {
        let nutritionType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: HKQuantityTypeIdentifier(rawValue: nutrition.type.identifier))
        let quantity = HKQuantity(unit: HKUnit(from: nutrition.unit), doubleValue: nutrition.value)
        let nutritionObj = HKQuantitySample(type: nutritionType, quantity: quantity, start: nutrition.date, end: nutrition.date, metadata: extra)
        
        try await healthStore.save(nutritionObj)
    }
}


