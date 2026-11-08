import Testing
import HealthKit
@testable import HealthHub

@Suite("HeartType Enum Suite")
struct HeartTypeTests {

    @Test("All cases have non-empty display names")
    func allDisplayNamesNonEmpty() {
        for type in HeartType.allCases {
            #expect(!type.displayName.isEmpty, "Empty displayName for \(type)")
        }
    }

    @Test("All cases have non-empty units")
    func allUnitsNonEmpty() {
        for type in HeartType.allCases {
            #expect(!type.unit.isEmpty, "Empty unit for \(type)")
        }
    }

    @Test("Blood pressure is saveable")
    func bloodPressureIsSaveable() {
        #expect(HeartType.bloodPressure.isSaveable == true)
    }

    @Test("Cardio fitness is saveable")
    func cardioFitnessIsSaveable() {
        #expect(HeartType.cardioFitness.isSaveable == true)
    }

    @Test("Cardio recovery is saveable")
    func cardioRecoveryIsSaveable() {
        #expect(HeartType.cardioRecovery.isSaveable == true)
    }

    @Test("Peripheral perfusion index is saveable")
    func peripheralPerfusionIndexIsSaveable() {
        #expect(HeartType.peripheralPerfusionIndex.isSaveable == true)
    }

    @Test("Heart rate is not saveable")
    func heartRateIsNotSaveable() {
        #expect(HeartType.heartRate.isSaveable == false)
    }

    @Test("Heart rate variability is not saveable")
    func heartRateVariabilityIsNotSaveable() {
        #expect(HeartType.heartRateVariability.isSaveable == false)
    }

    @Test("RMSSD heart rate variability average")
    func heartRateVariabilityRMSSDAverage() {
        let model = HeartRateVariabilityRMSSD(items: [
            .init(rmssd: 30, date: .now),
            .init(rmssd: 50, date: .now)
        ])

        #expect(model.averageRMSSD == 40)
    }

    @Test("Atrial fibrillation display name")
    func atrialFibrillationDisplayName() {
        #expect(HeartType.atrialFibrillation.displayName == "Atrial Fibrillation")
    }

    @Test("Blood pressure unit is mmHg")
    func bloodPressureUnit() {
        #expect(HeartType.bloodPressure.unit == "mmHg")
    }
}

@Suite("Heart Rate Recovery Test Type Suite")
struct HeartRateRecoveryTestTypeTests {

    @Test("Raw values match HKHeartRateRecoveryTestType, including the iOS 27.2 step test")
    func rawValuesMatchHealthKit() {
        #expect(HeartRateRecoveryTestType.maxExercise.rawValue == HKHeartRateRecoveryTestType.maxExercise.rawValue)
        #expect(HeartRateRecoveryTestType.predictionSubMaxExercise.rawValue == HKHeartRateRecoveryTestType.predictionSubMaxExercise.rawValue)
        #expect(HeartRateRecoveryTestType.predictionNonExercise.rawValue == HKHeartRateRecoveryTestType.predictionNonExercise.rawValue)
        if #available(iOS 27.2, *) {
            #expect(HeartRateRecoveryTestType.stepTest.rawValue == HKHeartRateRecoveryTestType.stepTest.rawValue)
        }
    }

    @Test("Parses the test type from sample metadata")
    func parsesMetadata() {
        let metadata: [String: Any] = [HKMetadataKeyHeartRateRecoveryTestType: HeartRateRecoveryTestType.stepTest.rawValue]
        #expect(HeartRateRecoveryTestType(metadata: metadata) == .stepTest)
    }

    @Test("Missing or unknown metadata yields no test type")
    func ignoresMissingOrUnknownMetadata() {
        #expect(HeartRateRecoveryTestType(metadata: nil) == nil)
        #expect(HeartRateRecoveryTestType(metadata: [:]) == nil)
        #expect(HeartRateRecoveryTestType(metadata: [HKMetadataKeyHeartRateRecoveryTestType: 99]) == nil)
    }

    @Test("Cardio recovery items default to no test type")
    func itemsDefaultToNoTestType() {
        #expect(CardioRecovery.Item(bpm: 30, date: .now).testType == nil)
    }
}
