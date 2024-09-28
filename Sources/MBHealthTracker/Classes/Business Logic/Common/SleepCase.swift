//
//  File.swift
//  
//
//  Created by Maty Brennan on 2/3/2024.
//

import Foundation
@preconcurrency import HealthKit

protocol SleepCase: FetchCategorySample { }

extension SleepCase {

    func baseSleep() async throws -> Sleep {
        let samples = try await fetchCategorySamples(categoryIdentifier: .sleepAnalysis)
        let items = samples.map { item -> Sleep.Info in
            let style = Sleep.Info.Style(rawValue: item.value) ?? Sleep.Info.Style.awake
            return Sleep.Info(style: style, startDate: item.startDate, endDate: item.endDate)
        }

        let vm = Sleep(items: items)
        return vm
    }

    func baseSaveSleep(model: Sleep, extra: [String: Sendable]?) async throws {
        let sleepType = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .sleepAnalysis)
        try MBHealthParser.checkSharingAuthorizationStatus(for: sleepType)

        let sampleObjects = model.items.map {
            HKCategorySample(type: sleepType, value: $0.style.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
