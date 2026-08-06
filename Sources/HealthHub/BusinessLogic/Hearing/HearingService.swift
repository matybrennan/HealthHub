//
//  HearingService.swift
//  HealthHub
//
//  Created by Maty Brennan on 29/6/2026.
//

import Foundation
import HealthKit

public final class HearingService {

    public init() { }
}

// MARK: - FetchQuantitySample
extension HearingService: FetchQuantitySample, FetchCategorySample { }

// MARK: - HearingServiceProtocol
extension HearingService: HearingServiceProtocol {

    public func environmentalAudioExposure() async throws -> EnvironmentalAudioExposureEvent {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .environmentalAudioExposure, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> EnvironmentalAudioExposureEvent.Item in
            let value = item.quantity.doubleValue(for: HKUnit.decibelAWeightedSoundPressureLevel())
            return EnvironmentalAudioExposureEvent.Item(value: value, startDate: item.startDate, endDate: item.endDate)
        }

        return EnvironmentalAudioExposureEvent(items: items)
    }

    public func environmentalAudioExposureEvent() async throws -> EnvironmentalAudioExposureNotification {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .environmentalAudioExposureEvent, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> EnvironmentalAudioExposureNotification.Item in
            let type = EnvironmentalAudioExposureNotification.EventType(rawValue: item.value) ?? .momentaryLimit
            return EnvironmentalAudioExposureNotification.Item(type: type, startDate: item.startDate, endDate: item.endDate)
        }

        return EnvironmentalAudioExposureNotification(items: items)
    }

    public func headphoneAudioExposure() async throws -> HeadphoneAudioExposureEvent {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .headphoneAudioExposure, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> HeadphoneAudioExposureEvent.Item in
            let value = item.quantity.doubleValue(for: HKUnit.decibelAWeightedSoundPressureLevel())
            return HeadphoneAudioExposureEvent.Item(value: value, startDate: item.startDate, endDate: item.endDate)
        }

        return HeadphoneAudioExposureEvent(items: items)
    }

    public func environmentalSoundReduction() async throws -> EnvironmentalSoundReduction {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .environmentalSoundReduction, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> EnvironmentalSoundReduction.Item in
            let value = item.quantity.doubleValue(for: HKUnit.decibelAWeightedSoundPressureLevel())
            return EnvironmentalSoundReduction.Item(value: value, startDate: item.startDate, endDate: item.endDate)
        }

        return EnvironmentalSoundReduction(items: items)
    }

    public func headphoneAudioExposureEvent() async throws -> HeadphoneAudioExposureNotification {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .headphoneAudioExposureEvent, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> HeadphoneAudioExposureNotification.Item in
            let type = HeadphoneAudioExposureNotification.EventType(rawValue: item.value) ?? .sevenDayLimit
            return HeadphoneAudioExposureNotification.Item(type: type, startDate: item.startDate, endDate: item.endDate)
        }

        return HeadphoneAudioExposureNotification(items: items)
    }

    public func audiogram() async throws -> AudiogramEntry {
        try ensureHealthDataAvailable()
        let audiogramType = HKAudiogramSampleType.audiogramSampleType()
        let sortDescriptor = SortDescriptor(\HKSample.endDate, order: .reverse)
        let predicate = HKSamplePredicate<HKAudiogramSample>.sample(type: audiogramType)
        let descriptor = HKSampleQueryDescriptor(predicates: [predicate], sortDescriptors: [sortDescriptor])
        let results = try await descriptor.result(for: HealthStoreProvider.shared)

        let items = results.compactMap { sample -> AudiogramEntry.Item? in
            guard let audiogramSample = sample as? HKAudiogramSample else { return nil }
            let points = audiogramSample.sensitivityPoints.map { point -> AudiogramEntry.SensitivityPoint in
                let leftSensitivity = point.leftEarSensitivity?.doubleValue(for: HKUnit.decibelHearingLevel())
                let rightSensitivity = point.rightEarSensitivity?.doubleValue(for: HKUnit.decibelHearingLevel())
                return AudiogramEntry.SensitivityPoint(
                    frequency: point.frequency.doubleValue(for: HKUnit.hertz()),
                    leftEarSensitivity: leftSensitivity,
                    rightEarSensitivity: rightSensitivity
                )
            }
            return AudiogramEntry.Item(sensitivityPoints: points, date: audiogramSample.endDate)
        }

        return AudiogramEntry(items: items)
    }
}
