import Foundation
import HealthKit
@testable import HealthHub

final class MockNutritionService: NutritionServiceProtocol {

    var shouldThrowError: Error?
    var nutritionCallCount = 0
    var saveCallCount = 0
    var lastNutritionType: NutritionType?
    var stubbedNutrition = Nutrition(
        items: [],
        type: NutritionType.water.quantityType,
        displayName: NutritionType.water.displayName,
        category: NutritionType.water.category
    )

    func nutrition(type: NutritionType) async throws -> Nutrition {
        nutritionCallCount += 1
        lastNutritionType = type
        if let error = shouldThrowError { throw error }
        return stubbedNutrition
    }

    func save(model: Nutrition, extra: [String: Sendable]?) async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }
}
