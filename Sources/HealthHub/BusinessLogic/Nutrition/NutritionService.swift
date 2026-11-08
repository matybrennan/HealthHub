//
//  NutritionService.swift
//  HealthHub
//
//  Created by Maty Brennan on 5/24/18.
//

import Foundation
import HealthKit

public final class NutritionService {

    public init() { }
}

// MARK: - FetchQuantitySample
extension NutritionService: FetchQuantitySample { }

// MARK: - FoodCase
extension NutritionService: FoodCase { }

// MARK: - NutritionServiceProtocol
extension NutritionService: NutritionServiceProtocol {
    
    public func nutrition(type: NutritionType) async throws -> Nutrition {
        let identifier = HKQuantityTypeIdentifier(rawValue: type.quantityType.identifier)
        let unitToUse = type.unitMeasure
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: identifier, sortDescriptors: [sortDescriptor])
        
        let items = samples.map {
            Nutrition.Info(value: $0.quantity.doubleValue(for: unitToUse.unit), unit: unitToUse.unitStr, startDate: $0.startDate, endDate: $0.endDate)
        }
        
        let vm = Nutrition(items: items, type: type.quantityType, displayName: type.displayName, category: type.category)
        return vm
    }
    
    public func save(model: Nutrition, extra: [String: Sendable]?) async throws {
        let nutritionType = try HealthParser.quantityType(for: HKQuantityTypeIdentifier(rawValue: model.type.identifier))
        try HealthParser.checkSharingAuthorizationStatus(for: model.type)

        let nutritionObjects = model.items.map {
            let quantity = HKQuantity(unit: HKUnit(from: $0.unit), doubleValue: $0.value)
            return HKQuantitySample(type: nutritionType, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(nutritionObjects)
    }

    public func food() async throws -> Food {
        try await baseFood()
    }

    public func saveFood(model: Food.Item, extra: [String: Sendable]?) async throws {
        try await baseSaveFood(model: model, extra: extra)
    }
}
