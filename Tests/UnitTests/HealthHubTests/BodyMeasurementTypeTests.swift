import Testing
@testable import HealthHub

@Suite("BodyMeasurementType Enum Suite")
struct BodyMeasurementTypeTests {

    @Test("All cases have non-empty display names")
    func allDisplayNamesNonEmpty() {
        for type in BodyMeasurementType.allCases {
            #expect(!type.displayName.isEmpty, "Empty displayName for \(type)")
        }
    }

    @Test("All cases have non-empty units")
    func allUnitsNonEmpty() {
        for type in BodyMeasurementType.allCases {
            #expect(!type.unit.isEmpty, "Empty unit for \(type)")
        }
    }

    @Test("Wrist temperature is not saveable")
    func wristTemperatureNotSaveable() {
        #expect(BodyMeasurementType.wristTemperature.isSaveable == false)
    }

    @Test("All other types are saveable")
    func otherTypesAreSaveable() {
        let unsaveableTypes: Set<BodyMeasurementType> = [.wristTemperature]
        for type in BodyMeasurementType.allCases where !unsaveableTypes.contains(type) {
            #expect(type.isSaveable == true, "\(type) should be saveable")
        }
    }

    @Test("Weight unit is kg")
    func weightUnit() {
        #expect(BodyMeasurementType.weight.unit == "kg")
    }

    @Test("BMI display name")
    func bmiDisplayName() {
        #expect(BodyMeasurementType.bodyMassIndex.displayName == "Body Mass Index (BMI)")
    }

    @Test("Height unit is cm")
    func heightUnit() {
        #expect(BodyMeasurementType.height.unit == "cm")
    }
}
