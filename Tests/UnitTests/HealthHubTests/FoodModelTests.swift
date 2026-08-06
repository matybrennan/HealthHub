import Testing
import Foundation
@testable import HealthHub

@Suite("Food Model Suite")
struct FoodModelTests {

    @Test("Food mostRecent returns the item with the latest endDate")
    func mostRecentReturnsLatest() {
        let older = Food.Item(
            foodType: "Salad",
            nutrients: [.energyConsumed: 150, .protein: 5],
            startDate: Date(timeIntervalSince1970: 0),
            endDate: Date(timeIntervalSince1970: 100)
        )
        let newer = Food.Item(
            foodType: "Pasta",
            nutrients: [.energyConsumed: 600, .carbohydrates: 80],
            startDate: Date(timeIntervalSince1970: 1_000_000),
            endDate: Date(timeIntervalSince1970: 1_000_100)
        )
        let model = Food(items: [older, newer])

        #expect(model.mostRecent?.foodType == "Pasta")
        #expect(model.mostRecent?.nutrients[.energyConsumed] == 600)
    }

    @Test("Food mostRecent is nil for an empty item list")
    func mostRecentEmpty() {
        let model = Food(items: [])
        #expect(model.mostRecent == nil)
    }

    @Test("Food item stores nutrients keyed by NutritionType")
    func nutrientsKeyedByType() {
        let item = Food.Item(nutrients: [.sodium: 200, .sugar: 12], startDate: Date(), endDate: Date())
        #expect(item.nutrients[.sodium] == 200)
        #expect(item.nutrients[.sugar] == 12)
        #expect(item.foodType == nil)
    }
}
