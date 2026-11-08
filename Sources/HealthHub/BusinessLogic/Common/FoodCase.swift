//
//  FoodCase.swift
//
//
//  Created by Maty Brennan on 8/7/2026.
//

import Foundation
import HealthKit

protocol FoodCase: FetchCorrelationSample { }

extension FoodCase {

    func baseFood(from dateRange: DateRangeType = .allTime) async throws -> Food {
        let sortDescriptor = SortDescriptor(\HKCorrelation.endDate, order: .reverse)
        let samples = try await fetchCorrelationSamples(correlationIdentifier: .food, sortDescriptors: [sortDescriptor])

        let items = samples.map { correlation -> Food.Item in
            var nutrients: [NutritionType: Double] = [:]
            for object in correlation.objects {
                guard let quantitySample = object as? HKQuantitySample else { continue }
                guard let nutritionType = NutritionType(quantityIdentifier: quantitySample.quantityType.identifier) else { continue }
                nutrients[nutritionType] = quantitySample.quantity.doubleValue(for: nutritionType.unitMeasure.unit)
            }

            let foodType = correlation.metadata?[HKMetadataKeyFoodType] as? String
            return Food.Item(foodType: foodType, nutrients: nutrients, startDate: correlation.startDate, endDate: correlation.endDate)
        }

        return Food(items: items)
    }

    func baseSaveFood(model: Food.Item, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.correlationType(for: .food)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects: Set<HKSample> = Set(model.nutrients.map { nutritionType, value in
            let quantity = HKQuantity(unit: nutritionType.unitMeasure.unit, doubleValue: value)
            return HKQuantitySample(type: nutritionType.quantityType, quantity: quantity, start: model.startDate, end: model.endDate)
        })

        var metadata = extra ?? [:]
        if let foodType = model.foodType {
            metadata[HKMetadataKeyFoodType] = foodType
        }

        let correlation = HKCorrelation(type: type, start: model.startDate, end: model.endDate, objects: sampleObjects, metadata: metadata)
        try await HealthStoreProvider.shared.save([correlation])
    }
}
