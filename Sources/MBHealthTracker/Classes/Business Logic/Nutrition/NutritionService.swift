//
//  NutritionService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 5/24/18.
//

import Foundation
@preconcurrency import HealthKit

public final class NutritionService {

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
            Nutrition.Info(value: $0.quantity.doubleValue(for: unitToUse.unit), unit: unitToUse.unitStr, date: $0.endDate)
        }
        
        let vm = Nutrition(items: items, type: type.quantityType)
        return vm
    }
    
    public func save(model: Nutrition, extra: [String : Any]?) async throws {
        let nutritionType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: HKQuantityTypeIdentifier(rawValue: model.type.identifier))
        try MBHealthParser.checkSharingAuthorizationStatus(for: model.type)

        let nutritionObjects = model.items.map {
            let quantity = HKQuantity(unit: HKUnit(from: $0.unit), doubleValue: $0.value)
            return HKQuantitySample(type: nutritionType, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(nutritionObjects)
    }
}
