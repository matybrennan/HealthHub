import Testing
import Foundation
@testable import HealthHub

@Suite("Electrocardiogram Model Suite")
struct ElectrocardiogramModelTests {

    @Test("ECG item duration and symptom flag compute correctly")
    func itemComputedProperties() {
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(30)
        let item = Electrocardiogram.Item(
            classification: "Sinus Rhythm",
            averageHeartRate: 67,
            symptomsStatus: "Present",
            numberOfVoltageMeasurements: 256,
            samplingFrequency: 512,
            startDate: startDate,
            endDate: endDate
        )

        #expect(item.duration == 30)
        #expect(item.hasSymptoms == true)
        #expect(item.averageSamplingInterval == (1 / 512.0))
    }

    @Test("Average heart rate ignores missing ECG heart rates")
    func averageHeartRate() {
        let date = Date()
        let model = Electrocardiogram(items: [
            Electrocardiogram.Item(classification: "Sinus Rhythm", averageHeartRate: 60, symptomsStatus: "None", numberOfVoltageMeasurements: 200, samplingFrequency: 256, startDate: date, endDate: date),
            Electrocardiogram.Item(classification: "Atrial Fibrillation", averageHeartRate: nil, symptomsStatus: "Present", numberOfVoltageMeasurements: 300, samplingFrequency: nil, startDate: date, endDate: date),
            Electrocardiogram.Item(classification: "Not Set", averageHeartRate: 90, symptomsStatus: "Not Set", numberOfVoltageMeasurements: 400, samplingFrequency: 512, startDate: date, endDate: date)
        ])

        #expect(model.averageHeartRate == 75)
    }

    @Test("Total voltage measurements sum across ECG samples")
    func totalVoltageMeasurements() {
        let date = Date()
        let model = Electrocardiogram(items: [
            Electrocardiogram.Item(classification: "Sinus Rhythm", averageHeartRate: nil, symptomsStatus: "None", numberOfVoltageMeasurements: 128, samplingFrequency: nil, startDate: date, endDate: date),
            Electrocardiogram.Item(classification: "Not Set", averageHeartRate: nil, symptomsStatus: "Not Set", numberOfVoltageMeasurements: 512, samplingFrequency: nil, startDate: date, endDate: date)
        ])

        #expect(model.totalVoltageMeasurements == 640)
    }

    @Test("Most recent ECG is selected by latest end date")
    func mostRecent() {
        let now = Date()
        let older = Electrocardiogram.Item(classification: "Not Set", averageHeartRate: 58, symptomsStatus: "None", numberOfVoltageMeasurements: 100, samplingFrequency: nil, startDate: now, endDate: now)
        let newer = Electrocardiogram.Item(classification: "Sinus Rhythm", averageHeartRate: 65, symptomsStatus: "Present", numberOfVoltageMeasurements: 250, samplingFrequency: 256, startDate: now, endDate: now.addingTimeInterval(60))
        let model = Electrocardiogram(items: [older, newer])

        #expect(model.mostRecent?.classification == "Sinus Rhythm")
    }
}
