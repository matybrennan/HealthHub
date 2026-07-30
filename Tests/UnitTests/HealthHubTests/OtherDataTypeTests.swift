import Testing
@testable import HealthHub

@Suite("OtherDataType Enum Suite")
struct OtherDataTypeTests {

    @Test("All cases have non-empty display names")
    func allDisplayNamesNonEmpty() {
        for type in OtherDataType.allCases {
            #expect(!type.displayName.isEmpty, "Empty displayName for \(type)")
        }
    }

    @Test("All cases have non-empty units")
    func allUnitsNonEmpty() {
        for type in OtherDataType.allCases {
            #expect(!type.unit.isEmpty, "Empty unit for \(type)")
        }
    }

    @Test("Alcohol types have alcohol category")
    func alcoholCategory() {
        #expect(OtherDataType.alcoholConsumption.category == .alcohol)
        #expect(OtherDataType.bloodAlcoholContent.category == .alcohol)
    }

    @Test("Hygiene types have hygiene category")
    func hygieneCategory() {
        #expect(OtherDataType.handWashing.category == .hygiene)
        #expect(OtherDataType.toothBrushing.category == .hygiene)
    }

    @Test("Diabetes types have diabetes category")
    func diabetesCategory() {
        #expect(OtherDataType.bloodGlucose.category == .diabetes)
        #expect(OtherDataType.insulinDelivery.category == .diabetes)
    }

    @Test("Environment types have environment category")
    func environmentCategory() {
        #expect(OtherDataType.timeInDaylight.category == .environment)
        #expect(OtherDataType.uvExposure.category == .environment)
        #expect(OtherDataType.waterTemperature.category == .environment)
    }

    @Test("Hearing types have hearing category")
    func hearingCategory() {
        #expect(OtherDataType.environmentalAudioExposure.category == .hearing)
        #expect(OtherDataType.headphoneAudioExposure.category == .hearing)
    }

    @Test("Blood glucose display name")
    func bloodGlucoseDisplayName() {
        #expect(OtherDataType.bloodGlucose.displayName == "Blood Glucose")
    }

    @Test("UV exposure unit")
    func uvExposureUnit() {
        #expect(OtherDataType.uvExposure.unit == "UV Index")
    }
}
