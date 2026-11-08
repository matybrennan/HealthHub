//
//  ElectrocardiogramService.swift
//  HealthHub
//
//  Created by Copilot on 7/8/2026.
//

import Foundation
import HealthKit

public final class ElectrocardiogramService {

    private nonisolated static let heartRateUnit = HKUnit(from: "count/min")
    private nonisolated static let voltageUnit = HKUnit.voltUnit(with: .milli)

    public init() { }
}

// MARK: - ElectrocardiogramServiceProtocol
extension ElectrocardiogramService: ElectrocardiogramServiceProtocol {

    public func electrocardiogram() async throws -> Electrocardiogram {
        try ensureHealthDataAvailable()
        let sortDescriptor = SortDescriptor(\HKElectrocardiogram.endDate, order: .reverse)
        let descriptor = HKSampleQueryDescriptor(predicates: [.electrocardiogram()], sortDescriptors: [sortDescriptor])
        let samples = try await descriptor.result(for: HealthStoreProvider.shared)

        let items = samples.map { sample in
            Electrocardiogram.Item(
                classification: Self.classificationDisplayName(for: sample.classification),
                averageHeartRate: sample.averageHeartRate?.doubleValue(for: Self.heartRateUnit),
                symptomsStatus: Self.symptomsStatusDisplayName(for: sample.symptomsStatus),
                numberOfVoltageMeasurements: sample.numberOfVoltageMeasurements,
                samplingFrequency: sample.samplingFrequency?.doubleValue(for: .hertz()),
                startDate: sample.startDate,
                endDate: sample.endDate
            )
        }

        return Electrocardiogram(items: items)
    }

    public func voltageMeasurements(for sample: HKElectrocardiogram) async throws -> [Electrocardiogram.VoltageMeasurement] {
        try ensureHealthDataAvailable()
        let descriptor = HKElectrocardiogramQueryDescriptor(sample)
        var items: [Electrocardiogram.VoltageMeasurement] = []

        for try await measurement in descriptor.results(for: HealthStoreProvider.shared) {
            guard let quantity = measurement.quantity(for: .appleWatchSimilarToLeadI) else { continue }
            let voltage = quantity.doubleValue(for: Self.voltageUnit)
            items.append(Electrocardiogram.VoltageMeasurement(timeSinceSampleStart: measurement.timeSinceSampleStart, voltage: voltage))
        }

        return items
    }
}

// MARK: - Private
private extension ElectrocardiogramService {

    static func classificationDisplayName(for classification: HKElectrocardiogram.Classification) -> String {
        switch classification {
        case .notSet: "Not Set"
        case .sinusRhythm: "Sinus Rhythm"
        case .atrialFibrillation: "Atrial Fibrillation"
        case .inconclusiveLowHeartRate: "Inconclusive: Low Heart Rate"
        case .inconclusiveHighHeartRate: "Inconclusive: High Heart Rate"
        case .inconclusivePoorReading: "Inconclusive: Poor Reading"
        case .inconclusiveOther: "Inconclusive: Other"
        case .unrecognized: "Unrecognized"
        @unknown default: "Unknown"
        }
    }

    static func symptomsStatusDisplayName(for symptomsStatus: HKElectrocardiogram.SymptomsStatus) -> String {
        switch symptomsStatus {
        case .notSet: "Not Set"
        case .none: "None"
        case .present: "Present"
        @unknown default: "Unknown"
        }
    }
}
