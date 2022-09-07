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

// MARK: - RespiratoryServiceProtocol
extension RespiratoryService: RespiratoryServiceProtocol {
    
    public func respiratoryRate() async throws -> RespiratoryRate {
        
        // Confirm that the type and device works
        let respiratoryRateType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .respiratoryRate)
        
        let descriptorQuery = HKSampleQueryDescriptor(predicates: [.quantitySample(type: respiratoryRateType)], sortDescriptors: [])
        let samples = try await descriptorQuery.result(for: healthStore)
        let items = samples.map { item -> RespiratoryRate.Info in
            let value = item.quantity.doubleValue(for: HKUnit(from: "count/min"))
            return RespiratoryRate.Info(value: value, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = RespiratoryRate(items: items)
        return model
    }
}
