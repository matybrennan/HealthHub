import Testing
import Foundation
@testable import HealthHub

@Suite("BloodPressure Model Suite")
struct BloodPressureModelTests {

    // MARK: - Classification

    @Test("Normal blood pressure classification")
    func normalClassification() {
        let info = BloodPressure.Info(systolic: 115, diastolic: 75, startDate: Date(), endDate: Date())
        #expect(info.classification == .normal)
    }

    @Test("Elevated blood pressure classification")
    func elevatedClassification() {
        let info = BloodPressure.Info(systolic: 122, diastolic: 78, startDate: Date(), endDate: Date())
        #expect(info.classification == .elevated)
    }

    @Test("High Stage 1 blood pressure classification")
    func highStage1Classification() {
        let info = BloodPressure.Info(systolic: 132, diastolic: 82, startDate: Date(), endDate: Date())
        #expect(info.classification == .highStage1)
    }

    @Test("High Stage 2 blood pressure — systolic driven")
    func highStage2SystolicClassification() {
        let info = BloodPressure.Info(systolic: 142, diastolic: 85, startDate: Date(), endDate: Date())
        #expect(info.classification == .highStage2)
    }

    @Test("High Stage 2 blood pressure — diastolic driven")
    func highStage2DiastolicClassification() {
        let info = BloodPressure.Info(systolic: 125, diastolic: 92, startDate: Date(), endDate: Date())
        #expect(info.classification == .highStage2)
    }

    @Test("Hypertensive crisis — systolic >= 180")
    func hypertensiveCrisisSystolic() {
        let info = BloodPressure.Info(systolic: 185, diastolic: 110, startDate: Date(), endDate: Date())
        #expect(info.classification == .hypertensiveCrisis)
    }

    @Test("Hypertensive crisis — diastolic >= 120")
    func hypertensiveCrisisDiastolic() {
        let info = BloodPressure.Info(systolic: 170, diastolic: 122, startDate: Date(), endDate: Date())
        #expect(info.classification == .hypertensiveCrisis)
    }

    // MARK: - Value display

    @Test("Value string formats systolic/diastolic with unit")
    func valueString() {
        let info = BloodPressure.Info(systolic: 120, diastolic: 80, unit: "mmHg", startDate: Date(), endDate: Date())
        #expect(info.value == "120/80 mmHg")
    }
}
