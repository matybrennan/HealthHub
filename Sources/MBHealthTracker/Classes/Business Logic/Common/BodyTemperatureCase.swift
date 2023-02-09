//
//  BodyTemperatureCase.swift
//  MBHealthTracker
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
}
