import Testing
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

    @Test("Atrial fibrillation display name")
    func atrialFibrillationDisplayName() {
        #expect(HeartType.atrialFibrillation.displayName == "Atrial Fibrillation")
    }

    @Test("Blood pressure unit is mmHg")
    func bloodPressureUnit() {
        #expect(HeartType.bloodPressure.unit == "mmHg")
    }
}
