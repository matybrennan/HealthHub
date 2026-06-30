//
//  RespiratoryRateCase.swift
//  HealthHub
//
//  Created by Maty Brennan on 9/2/2023.
//

import Foundation
import HealthKit

protocol RespiratoryRateCase: FetchQuantitySample { }

extension RespiratoryRateCase {
    
    func baseRespiratoryRate(from dateRange: DateRangeType = .allTime) async throws -> RespiratoryRate {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let predicate = try dateRange.predicate()
        let samples = try await fetchQuantitySamples(quantityIdentifier: .respiratoryRate, predicate: predicate, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> RespiratoryRate.Item in
            let value = item.quantity.doubleValue(for: HKUnit(from: "count/min"))
            return RespiratoryRate.Item(value: value, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = RespiratoryRate(items: items)
        return model
    }

    func saveBaseRespiratoryRate(model: RespiratoryRate, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .respiratoryRate)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: "count/min")
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.value)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }
}
