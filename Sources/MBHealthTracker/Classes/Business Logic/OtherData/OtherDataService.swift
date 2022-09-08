//
//  OtherDataService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation
import HealthKit

public class OtherDataService {
    
    public init() { }
}

// MARK: - FetchQuantitySample & FetchCategorySample
extension OtherDataService: FetchQuantitySample, FetchCategorySample { }

// MARK: OtherDataServiceProtocol
extension OtherDataService: OtherDataServiceProtocol {
    
    public func alcoholConsumption() async throws -> AlcoholConsumption {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .numberOfAlcoholicBeverages)
        let items = samples.map { item -> AlcoholConsumption.Item in
            let drinks = item.quantity.doubleValue(for: HKUnit.count())
            return AlcoholConsumption.Item(drinks: drinks, date: item.startDate)
        }
        
        let model = AlcoholConsumption(items: items)
        return model
    }
    
    public func alcoholContent() async throws -> AlcoholContent {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .bloodAlcoholContent)
        let items = samples.map { item -> AlcoholContent.Item in
            let percentage = item.quantity.doubleValue(for: .percent()) * 100
            return AlcoholContent.Item(percentage: percentage, date: item.startDate)
        }
        
        let model = AlcoholContent(items: items)
        return model
    }
    
    public func handWashing() async throws -> HandWashing {
        let samples = try await fetchCategorySamples(categoryIdentifier: .handwashingEvent)
        let items = samples.map { item -> HandWashing.Item in
            let duration = Int(item.endDate.timeIntervalSince(item.startDate))
            return HandWashing.Item(duration: duration, date: item.startDate)
        }
        
        let model = HandWashing(items: items)
        return model
    }
    
    public func inhalerUsage() async throws -> InhalerUsage {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .inhalerUsage)
        let items = samples.map { item -> InhalerUsage.Item in
            let value = Int(item.quantity.doubleValue(for: HKUnit.count()))
            return InhalerUsage.Item(value: value, date: item.startDate)
        }
        
        let model = InhalerUsage(items: items)
        return model
    }
    
    public func insulinDelivery() async throws -> InsulinDelivery {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .insulinDelivery)
        let items = samples.map { item -> InsulinDelivery.Item in
            let value = item.quantity.doubleValue(for: HKUnit(from: "IU"))
            let purposeInt = item.metadata?[HKMetadataKeyInsulinDeliveryReason] as? Int ?? 1
            let purpose = InsulinDelivery.Item.Purpose(rawValue: purposeInt)!
            return InsulinDelivery.Item(value: value, purpose: purpose, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = InsulinDelivery(items: items)
        return model
    }
    
    public func numberOfTimesFallen() async throws -> NumberOfTimesFallen {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .numberOfTimesFallen)
        let items = samples.map { item -> NumberOfTimesFallen.Item in
            let value = Int(item.quantity.doubleValue(for: HKUnit.count()))
            return NumberOfTimesFallen.Item(value: value, date: item.startDate)
        }
        
        let model = NumberOfTimesFallen(items: items)
        return model
    }
    
    public func toothBrushing() async throws -> ToothBrushing {
        let samples = try await fetchCategorySamples(categoryIdentifier: .toothbrushingEvent)
        let items = samples.map { item -> ToothBrushing.Item in
            let duration = Int(item.endDate.timeIntervalSince(item.startDate))
            return ToothBrushing.Item(durationSeconds: duration, date: item.startDate)
        }
        
        let model = ToothBrushing(items: items)
        return model
    }
    
    public func uvExposure() async throws -> UVExposure {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .uvExposure)
        let items = samples.map { item -> UVExposure.Item in
            let value = Int(item.quantity.doubleValue(for: HKUnit.count()))
            return UVExposure.Item(value: value, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = UVExposure(items: items)
        return model
    }
}
