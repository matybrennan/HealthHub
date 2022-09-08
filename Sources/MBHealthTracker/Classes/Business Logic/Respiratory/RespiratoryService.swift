//
//  RespiratoryService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation
import HealthKit

public class RespiratoryService {
    
    public init() { }
}

// MARK: - FetchQuantitySample
extension RespiratoryService: FetchQuantitySample { }

// MARK: - RespiratoryServiceProtocol
extension RespiratoryService: RespiratoryServiceProtocol {
    
    public func respiratoryRate() async throws -> RespiratoryRate {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .respiratoryRate)
        let items = samples.map { item -> RespiratoryRate.Info in
            let value = item.quantity.doubleValue(for: HKUnit(from: "count/min"))
            return RespiratoryRate.Info(value: value, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = RespiratoryRate(items: items)
        return model
    }
}
