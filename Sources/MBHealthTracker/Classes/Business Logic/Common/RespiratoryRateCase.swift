//
//  RespiratoryRateCase.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/2/2023.
//

import Foundation
import HealthKit

protocol RespiratoryRateCase: FetchQuantitySample { }

extension RespiratoryRateCase {
    
    func baseRespiratoryRate() async throws -> RespiratoryRate {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .respiratoryRate)
        let items = samples.map { item -> RespiratoryRate.Item in
            let value = item.quantity.doubleValue(for: HKUnit(from: "count/min"))
            return RespiratoryRate.Item(value: value, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = RespiratoryRate(items: items)
        return model
    }
}
