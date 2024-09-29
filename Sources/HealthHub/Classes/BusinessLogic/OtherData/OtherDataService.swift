//
//  OtherDataService.swift
//  HealthHub
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation
@preconcurrency import HealthKit

public final class OtherDataService {
    
    public init() { }
}

// MARK: - FetchQuantitySample & FetchCategorySample
extension OtherDataService: FetchQuantitySample, FetchCategorySample, SexualActivityCase, BloodGlucoseCase, InhalerUsageCase, TimeInDaylightCase { }

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
    
    public func bloodAlcoholContent() async throws -> AlcoholContent {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .bloodAlcoholContent)
        let items = samples.map { item -> AlcoholContent.Item in
            let percentage = item.quantity.doubleValue(for: .percent()) * 100
            return AlcoholContent.Item(percentage: percentage, date: item.startDate)
        }
        
        let model = AlcoholContent(items: items)
        return model
    }

    public func bloodGlucose() async throws -> BloodGlucose {
        try await baseBloodGlucose()
    }
    
    public func handWashing() async throws -> HandWashing {
        let samples = try await fetchCategorySamples(categoryIdentifier: .handwashingEvent)
        let items = samples.map { item -> HandWashing.Item in
            return HandWashing.Item(startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = HandWashing(items: items)
        return model
    }
    
    public func inhalerUsage() async throws -> InhalerUsage {
        try await baseInhalerUsage()
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
    
    public func sexualActivity() async throws -> SexualActivity {
        try await baseSexualActivity()
    }
    
    public func toothBrushing() async throws -> ToothBrushing {
        let samples = try await fetchCategorySamples(categoryIdentifier: .toothbrushingEvent)
        let items = samples.map { item -> ToothBrushing.Item in
            return ToothBrushing.Item(startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = ToothBrushing(items: items)
        return model
    }

    public func timeInDaylight() async throws -> TimeInDaylight {
        try await baseTimeInDaylight()
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
    
    public func waterTemperature() async throws -> WaterTemperature {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .waterTemperature)
        
        let items = samples.map { item -> WaterTemperature.Item in
            let celsius = item.quantity.doubleValue(for: .degreeCelsius())
            let fahrenheit = item.quantity.doubleValue(for: .degreeFahrenheit())
            return WaterTemperature.Item(celsius: celsius, fahrenheit: fahrenheit, date: item.endDate)
        }
        
        let model = WaterTemperature(items: items)
        return model
    }

    // MARK: Saving

    public func saveAlcoholConsumption(model: AlcoholConsumption, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .numberOfAlcoholicBeverages)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .count(), doubleValue: $0.drinks)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveBloodAlcoholContent(model: AlcoholContent, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bloodAlcoholContent)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .percent(), doubleValue: $0.percentage)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveBloodGlucose(model: BloodGlucose, extra: [String: Sendable]?) async throws {
        try await saveBaseBloodGlucose(model: model, extra: extra)
    }

    public func saveHandWashing(model: HandWashing, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .handwashingEvent)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let duration = Int($0.endDate.timeIntervalSince($0.startDate))
            return HKCategorySample(type: type, value: duration, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveInhalerUsage(model: InhalerUsage, extra: [String: Sendable]?) async throws {
        try await saveBaseInhalerUsage(model: model, extra: extra)
    }

    public func saveInsulinDelivery(model: InsulinDelivery, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .insulinDelivery)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: "IU")
        let sampleObjects = model.items.map {
            var metadata = extra ?? [:]
            metadata[HKMetadataKeyInsulinDeliveryReason] = $0.purpose.rawValue
            let quantity = HKQuantity(unit: unit, doubleValue: $0.value)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveNumberOfTimesFallen(model: NumberOfTimesFallen, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .numberOfTimesFallen)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .count(), doubleValue: Double($0.value))
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveSexualActivity(model: SexualActivity, extra: [String: Sendable]?) async throws {
        try await saveBaseSexualActivity(model, extra: extra)
    }

    public func saveToothBrushing(model: ToothBrushing, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .toothbrushingEvent)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let duration = Int($0.endDate.timeIntervalSince($0.startDate))
            return HKCategorySample(type: type, value: duration, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveTimeInDaylight(model: TimeInDaylight, extra: [String: Sendable]?) async throws {
        try await baseSaveTimeInDaylight(model: model, extra: extra)
    }

    public func saveUvExposure(model: UVExposure, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .uvExposure)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .count(), doubleValue: Double($0.value))
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }

    public func saveWaterTemperature(model: WaterTemperature, extra: [String: Sendable]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .waterTemperature)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .degreeCelsius(), doubleValue: $0.celsius)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
