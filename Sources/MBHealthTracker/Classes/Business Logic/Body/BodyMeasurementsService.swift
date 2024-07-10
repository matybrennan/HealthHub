//
//  BodyMeasurementsService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 20/9/19.
//

import Foundation
import HealthKit

public final class BodyMeasurementsService {
    
    public init() { }
}

// MARK: - FetchQuantitySample & BodyTemperatureCase
extension BodyMeasurementsService: FetchQuantitySample, BodyTemperatureCase { }

// MARK: - BodyServiceProtocol
extension BodyMeasurementsService: BodyMeasurementsServiceProtocol {
    
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
            let percentage = item.quantity.doubleValue(for: HKUnit.percent()) * 100
            return BodyFatPercentage.Item(percentage: percentage, date: item.endDate)
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
        try await baseBodyTemperature()
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
            let inches = Int(item.quantity.doubleValue(for: HKUnit(from: .inch)))
            let cm = Int(item.quantity.doubleValue(for: HKUnit(from: .centimeter)))
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

    public func wristTemperature() async throws -> WristTemperature {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .appleSleepingWristTemperature, sortDescriptors: [sortDescriptor])

        let items = samples.map { item -> WristTemperature.Item in
            let celsius = item.quantity.doubleValue(for: .degreeCelsius())
            let fahrenheit = item.quantity.doubleValue(for: .degreeFahrenheit())
            return WristTemperature.Item(celsius: celsius, fahrenheit: fahrenheit, date: item.endDate)
        }

        let model = WristTemperature(items: items)
        return model
    }

    // MARK: Saving

    public func saveBasalBodyTemperature(model: BasalBodyTemperature, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .basalBodyTemperature)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .degreeCelsius(), doubleValue: $0.celsius)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveBodyFatPercentage(model: BodyFatPercentage, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bodyFatPercentage)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .percent(), doubleValue: $0.percentage)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveBodyMassIndex(model: BodyMassIndex, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bodyMassIndex)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .count(), doubleValue: $0.value)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveBodyTemperature(model: BodyTemperature, extra: [String : Any]?) async throws {
        try await saveBaseBodyTemperature(model: model, extra: extra)
    }

    public func saveElectrodermalActivity(model: ElectrodermalActivity, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .electrodermalActivity)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.siemenUnit(with: .micro)
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.value)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveHeight(model: BodyHeight, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .height)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: .centimeter)
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: Double($0.cm))
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveLeanBodyMass(model: LeanBodyMass, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .leanBodyMass)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.gramUnit(with: .kilo)
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.kg)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveWaistCircumference(model: WaistCircumference, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .waistCircumference)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: .centimeter)
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: Double($0.cm))
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveWeight(model: BodyWeight, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bodyMass)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.gramUnit(with: .kilo)
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.kg)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
