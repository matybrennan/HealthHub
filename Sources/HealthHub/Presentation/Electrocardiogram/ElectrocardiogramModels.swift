//
//  ElectrocardiogramModels.swift
//  HealthHub
//
//  Created by Copilot on 7/8/2026.
//

import Foundation

public struct Electrocardiogram: Sendable {

    public struct VoltageMeasurement: Sendable {
        public let timeSinceSampleStart: TimeInterval
        /// Voltage for the Apple Watch Lead I-like lead, in mV.
        public let voltage: Double

        public init(timeSinceSampleStart: TimeInterval, voltage: Double) {
            self.timeSinceSampleStart = timeSinceSampleStart
            self.voltage = voltage
        }
    }

    public struct Item: Sendable {
        public let classification: String
        public let averageHeartRate: Double?
        public let symptomsStatus: String
        public let numberOfVoltageMeasurements: Int
        public let samplingFrequency: Double?
        public let startDate: Date
        public let endDate: Date

        public init(
            classification: String,
            averageHeartRate: Double?,
            symptomsStatus: String,
            numberOfVoltageMeasurements: Int,
            samplingFrequency: Double?,
            startDate: Date,
            endDate: Date
        ) {
            self.classification = classification
            self.averageHeartRate = averageHeartRate
            self.symptomsStatus = symptomsStatus
            self.numberOfVoltageMeasurements = numberOfVoltageMeasurements
            self.samplingFrequency = samplingFrequency
            self.startDate = startDate
            self.endDate = endDate
        }

        public var duration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }

        public var hasSymptoms: Bool {
            symptomsStatus == "Present"
        }

        public var averageSamplingInterval: TimeInterval? {
            guard let samplingFrequency, samplingFrequency > 0 else { return nil }
            return 1 / samplingFrequency
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.endDate < $1.endDate })
    }

    public var averageHeartRate: Double? {
        let values = items.compactMap(\.averageHeartRate)
        guard !values.isEmpty else { return nil }
        return values.reduce(0, +) / Double(values.count)
    }

    public var totalVoltageMeasurements: Int {
        items.reduce(0) { $0 + $1.numberOfVoltageMeasurements }
    }
}
