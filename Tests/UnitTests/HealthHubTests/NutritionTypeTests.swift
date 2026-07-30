import Testing
@testable import HealthHub

@Suite("NutritionType Enum Suite")
struct NutritionTypeTests {

    @Test("All cases have non-empty display names")
    func allDisplayNamesNonEmpty() {
        for type in NutritionType.allCases {
            #expect(!type.displayName.isEmpty, "Empty displayName for \(type)")
        }
    }

    @Test("Macronutrient types have macronutrients category")
    func macronutrientsCategory() {
        let types: [NutritionType] = [.energyConsumed, .carbohydrates, .fiber, .sugar, .fatTotal, .fatMono, .fatPoly, .fatSaturated, .cholesterol, .protein]
        for type in types {
            #expect(type.category == .macronutrients, "\(type) should be macronutrients")
        }
    }

    @Test("Vitamin types have vitamins category")
    func vitaminsCategory() {
        let types: [NutritionType] = [.vitaminA, .vitaminC, .vitaminD, .vitaminE, .vitaminK, .vitaminB6, .vitaminB12]
        for type in types {
            #expect(type.category == .vitamins, "\(type) should be vitamins")
        }
    }

    @Test("Mineral types have minerals category")
    func mineralsCategory() {
        let types: [NutritionType] = [.calcium, .iron, .magnesium, .potassium, .sodium, .zinc]
        for type in types {
            #expect(type.category == .minerals, "\(type) should be minerals")
        }
    }

    @Test("Ultratrace mineral types have correct category")
    func ultratraceCategory() {
        let types: [NutritionType] = [.chromium, .copper, .iodine, .manganese, .molybdenum, .selenium]
        for type in types {
            #expect(type.category == .ultratraceMinerals, "\(type) should be ultratraceMinerals")
        }
    }

    @Test("Water is in hydration category")
    func waterCategory() {
        #expect(NutritionType.water.category == .hydration)
    }

    @Test("Caffeine is in caffeine category")
    func caffeineCategory() {
        #expect(NutritionType.caffeine.category == .caffeine)
    }

    @Test("Protein display name")
    func proteinDisplayName() {
        #expect(NutritionType.protein.displayName == "Protein")
    }

    @Test("Energy consumed display name")
    func energyConsumedDisplayName() {
        #expect(NutritionType.energyConsumed.displayName == "Energy Consumed")
    }
}
