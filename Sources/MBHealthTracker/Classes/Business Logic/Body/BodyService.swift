//
//  BodyService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 20/9/19.
//

import Foundation
import HealthKit

public class BodyService {
    
    public init() { }
}

// MARK: - FetchQuantitySample
extension BodyService: FetchQuantitySample { }

// MARK: - BodyServiceProtocol
extension BodyService: BodyServiceProtocol {
    
    public func basalBodyTemperature() async throws -> BasalBodyTemperature {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .basalBodyTemperature, sortDescriptors: [sortDescriptor])
        
        let items = samples.map { item -> BasalBodyTemperature.Item in
            let celsius = item.quantity.doubleValue(for: .degreeCelsius())
            let fahrenheit = item.quantity.doubleValue(for: .degreeFahrenheit())
            return BasalBodyTemperature.Item(celsius: celsius, fahrenheit: fahrenheit, date: item.endDate)
        }
        
        let model = BasalBodyTemperature(items: items)
        return model
    }
    
    public func bodyFatPercentage() async throws -> BodyFatPercentage {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .bodyFatPercentage, sortDescriptors: [sortDescriptor])
        
        let items = samples.map { item -> BodyFatPercentage.Item in
            let value = item.quantity.doubleValue(for: HKUnit.percent()) * 100
            return BodyFatPercentage.Item(value: value, date: item.endDate)
        }
        
        let bodyFatPercentage = BodyFatPercentage(items: items)
        return bodyFatPercentage
    }
    
    public func bodyMassIndex() async throws -> BodyMassIndex {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .bodyMassIndex, sortDescriptors: [sortDescriptor])
        
        let items = samples.map { item -> BodyMassIndex.Item in
            let value = item.quantity.doubleValue(for: HKUnit.count())
            return BodyMassIndex.Item(value: value, date: item.endDate)
        }
        
        let bodyMassIndex = BodyMassIndex(items: items)
        return bodyMassIndex
    }
    
    public func bodyTemperature() async throws -> BodyTemperature {
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
    
    public func height() async throws -> BodyHeight {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .height, sortDescriptors: [sortDescriptor])
        
        let items = samples.map { item -> BodyHeight.Item in
            let inches = Int(item.quantity.doubleValue(for: HKUnit.init(from: .inch)))
            let cm = Int(item.quantity.doubleValue(for: HKUnit.init(from: .centimeter)))
            return BodyHeight.Item(inches: inches, cm: cm, date: item.endDate)
        }
        
        let bodyHeight = BodyHeight(items: items)
        return bodyHeight
    }
    
    public func leanBodyMass() async throws -> LeanBodyMass {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .leanBodyMass, sortDescriptors: [sortDescriptor])
        
        let items = samples.map { item -> LeanBodyMass.Item in
            let leanBodyMassKg = item.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            let leanBodyMasslbs = item.quantity.doubleValue(for: HKUnit.pound())
            return LeanBodyMass.Item(kg: leanBodyMassKg, lbs: leanBodyMasslbs, date: item.endDate)
        }
        
        let leanBodyMass = LeanBodyMass(items: items)
        return leanBodyMass
    }
    
    public func waistCircumference() async throws -> WaistCircumference {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .waistCircumference, sortDescriptors: [sortDescriptor])
        
        let items = samples.map { item -> WaistCircumference.Item in
            let inches = Int(item.quantity.doubleValue(for: HKUnit.init(from: .inch)))
            let cm = Int(item.quantity.doubleValue(for: HKUnit.init(from: .centimeter)))
            return WaistCircumference.Item(inches: inches, cm: cm, date: item.endDate)
        }
        
        let waistCircumference = WaistCircumference(items: items)
        return waistCircumference
    }
    
    public func weight() async throws -> BodyWeight {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .bodyMass, sortDescriptors: [sortDescriptor])
        
        let items = samples.map { item -> BodyWeight.Item in
            let bodyMassKg = item.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            let bodyMasslbs = item.quantity.doubleValue(for: HKUnit.pound())
            return BodyWeight.Item(kg: bodyMassKg, lbs: bodyMasslbs, date: item.endDate)
        }
        
        let bodyWeight = BodyWeight(items: items)
        return bodyWeight
    }
    
    public func electrodermalActivity() async throws -> ElectrodermalActivity {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .electrodermalActivity, sortDescriptors: [sortDescriptor])
        
        let items = samples.map { item -> ElectrodermalActivity.Item in
            let value = item.quantity.doubleValue(for: HKUnit.siemenUnit(with: .micro))
            return ElectrodermalActivity.Item(value: value, date: item.endDate)
        }
        
        let electrodermalActivity = ElectrodermalActivity(items: items)
        return electrodermalActivity
    }
}
