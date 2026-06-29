//
//  HearingModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 29/6/2026.
//

import Foundation

public struct EnvironmentalAudioExposureEvent: Sendable {

    public struct Item: Sendable {
        /// Sound level in dB A-weighted Sound Pressure Level
        public let value: Double
        public let startDate: Date
        public let endDate: Date

        public init(value: Double, startDate: Date, endDate: Date) {
            self.value = value
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Duration of the measurement period
        public var duration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }

        /// WHO recommends max 70 dB for prolonged exposure
        public var exceedsRecommendedLevel: Bool {
            value > 70
        }

        /// NIOSH damage threshold (85 dB for 8 hours)
        public var exceedsDamageThreshold: Bool {
            value > 85
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average sound level across all readings
    public var averageLevel: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.value } / Double(items.count)
    }
}

public struct HeadphoneAudioExposureEvent: Sendable {

    public struct Item: Sendable {
        /// Sound level in dB A-weighted Sound Pressure Level
        public let value: Double
        public let startDate: Date
        public let endDate: Date

        public init(value: Double, startDate: Date, endDate: Date) {
            self.value = value
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Duration of listening
        public var duration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }

        /// WHO recommends max 85 dB for headphone listening
        public var exceedsRecommendedLevel: Bool {
            value > 85
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average sound level across all readings
    public var averageLevel: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.value } / Double(items.count)
    }

    /// Total listening duration across all entries
    public var totalListeningDuration: TimeInterval {
        items.reduce(0) { $0 + $1.duration }
    }
}

public struct AudiogramEntry: Sendable {

    public struct SensitivityPoint: Sendable {
        /// Frequency in Hz
        public let frequency: Double
        /// Sensitivity (hearing threshold) in dBHL
        public let leftEarSensitivity: Double?
        /// Sensitivity (hearing threshold) in dBHL
        public let rightEarSensitivity: Double?

        public init(frequency: Double, leftEarSensitivity: Double?, rightEarSensitivity: Double?) {
            self.frequency = frequency
            self.leftEarSensitivity = leftEarSensitivity
            self.rightEarSensitivity = rightEarSensitivity
        }
    }

    public enum HearingLossClassification: String, Sendable {
        case normal = "Normal"
        case mild = "Mild"
        case moderate = "Moderate"
        case moderatelySevere = "Moderately Severe"
        case severe = "Severe"
        case profound = "Profound"

        /// WHO classification based on Pure Tone Average (PTA) in dBHL
        public init(pta: Double) {
            switch pta {
            case ..<26: self = .normal
            case 26..<41: self = .mild
            case 41..<56: self = .moderate
            case 56..<71: self = .moderatelySevere
            case 71..<91: self = .severe
            default: self = .profound
            }
        }
    }

    public struct Item: Sendable {
        public let sensitivityPoints: [SensitivityPoint]
        public let date: Date

        public init(sensitivityPoints: [SensitivityPoint], date: Date) {
            self.sensitivityPoints = sensitivityPoints
            self.date = date
        }

        /// Pure Tone Average for left ear (average of 500, 1000, 2000, 4000 Hz)
        public var leftEarPTA: Double? {
            let ptaFrequencies: [Double] = [500, 1000, 2000, 4000]
            let values = sensitivityPoints
                .filter { ptaFrequencies.contains($0.frequency) }
                .compactMap { $0.leftEarSensitivity }
            guard !values.isEmpty else { return nil }
            return values.reduce(0, +) / Double(values.count)
        }

        /// Pure Tone Average for right ear (average of 500, 1000, 2000, 4000 Hz)
        public var rightEarPTA: Double? {
            let ptaFrequencies: [Double] = [500, 1000, 2000, 4000]
            let values = sensitivityPoints
                .filter { ptaFrequencies.contains($0.frequency) }
                .compactMap { $0.rightEarSensitivity }
            guard !values.isEmpty else { return nil }
            return values.reduce(0, +) / Double(values.count)
        }

        /// WHO hearing loss classification for left ear
        public var leftEarClassification: HearingLossClassification? {
            guard let pta = leftEarPTA else { return nil }
            return HearingLossClassification(pta: pta)
        }

        /// WHO hearing loss classification for right ear
        public var rightEarClassification: HearingLossClassification? {
            guard let pta = rightEarPTA else { return nil }
            return HearingLossClassification(pta: pta)
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent audiogram
    public var mostRecent: Item? { items.first }
}
