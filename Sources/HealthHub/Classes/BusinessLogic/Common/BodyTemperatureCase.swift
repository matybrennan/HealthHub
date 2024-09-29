//
//  BodyTemperatureCase.swift
//  HealthHub
//
//  Created by Maty Brennan on 9/2/2023.
//

import Foundation
import HealthKit

protocol BodyTemperatureCase: FetchQuantitySample { }

extension BodyTemperatureCase {
    
    func baseBodyTemperature() async throws -> BodyTemperature {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .bodyTemperature, sortDescriptors: [sortDescriptor])
        
        let items = samples.map { item -> BodyTemperature.Item in
            let celsius = item.quantity.doubleValue(for: .degreeCelsius())
            let fahrenheit = item.quantity.doubleValue(for: .degreeFahrenheit())
            return BodyTemperature.Item(celsius: celsius, fahrenheit: fahrenheit, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = BodyTemperature(items: items)
        return model
    }

    func saveBaseBodyTemperature(model: BodyTemperature, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bodyTemperature)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .degreeCelsius(), doubleValue: $0.celsius)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
