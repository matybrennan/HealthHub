//
//  OtherDataService.swift
//  HealthHub
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation
import HealthKit

public final class OtherDataService {
    
    public init() { }
}

// MARK: - FetchQuantitySample & FetchCategorySample
extension OtherDataService: FetchQuantitySample, FetchCategorySample, SexualActivityCase, BloodGlucoseCase, InhalerUsageCase, TimeInDaylightCase { }

// MARK: OtherDataServiceProtocol
extension OtherDataService: OtherDataServiceProtocol {

    public func alcoholConsumption() async throws -> AlcoholConsumption {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .numberOfAlcoholicBeverages, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> AlcoholConsumption.Item in
            let drinks = item.quantity.doubleValue(for: HKUnit.count())
            return AlcoholConsumption.Item(drinks: drinks, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = AlcoholConsumption(items: items)
        return model
    }
    
    public func bloodAlcoholContent() async throws -> AlcoholContent {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .bloodAlcoholContent, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> AlcoholContent.Item in
            let percentage = item.quantity.doubleValue(for: .percent()) * 100
            return AlcoholContent.Item(percentage: percentage, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = AlcoholContent(items: items)
        return model
    }

    public func bloodGlucose() async throws -> BloodGlucose {
        try await baseBloodGlucose()
    }

    public func environmentalAudioExposure() async throws -> EnvironmentalAudioExposure {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .environmentalAudioExposure, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> EnvironmentalAudioExposure.Item in
            let value = item.quantity.doubleValue(for: HKUnit.decibelAWeightedSoundPressureLevel())
            return EnvironmentalAudioExposure.Item(value: value, startDate: item.startDate, endDate: item.endDate)
        }

        let model = EnvironmentalAudioExposure(items: items)
        return model
    }
    
    public func handWashing() async throws -> HandWashing {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .handwashingEvent, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> HandWashing.Item in
            return HandWashing.Item(startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = HandWashing(items: items)
        return model
    }

    public func headphoneAudioExposure() async throws -> HeadphoneAudioExposure {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .headphoneAudioExposure, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> HeadphoneAudioExposure.Item in
            let value = item.quantity.doubleValue(for: HKUnit.decibelAWeightedSoundPressureLevel())
            return HeadphoneAudioExposure.Item(value: value, startDate: item.startDate, endDate: item.endDate)
        }

        let model = HeadphoneAudioExposure(items: items)
        return model
    }
    
    public func inhalerUsage() async throws -> InhalerUsage {
        try await baseInhalerUsage()
    }
    
    public func insulinDelivery() async throws -> InsulinDelivery {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .insulinDelivery, sortDescriptors: [sortDescriptor])
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
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .numberOfTimesFallen, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> NumberOfTimesFallen.Item in
            let value = Int(item.quantity.doubleValue(for: HKUnit.count()))
            return NumberOfTimesFallen.Item(value: value, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = NumberOfTimesFallen(items: items)
        return model
    }
    
    public func sexualActivity() async throws -> SexualActivity {
        try await baseSexualActivity()
    }
    
    public func toothBrushing() async throws -> ToothBrushing {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .toothbrushingEvent, sortDescriptors: [sortDescriptor])
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
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .uvExposure, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> UVExposure.Item in
            let value = Int(item.quantity.doubleValue(for: HKUnit.count()))
            return UVExposure.Item(value: value, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = UVExposure(items: items)
        return model
    }
    
    public func waterTemperature() async throws -> WaterTemperature {
        let sortDescriptor = SortDescriptor(\HKQuantitySample.endDate, order: .reverse)
        let samples = try await fetchQuantitySamples(quantityIdentifier: .waterTemperature, sortDescriptors: [sortDescriptor])
        
        let items = samples.map { item -> WaterTemperature.Item in
            let celsius = item.quantity.doubleValue(for: .degreeCelsius())
            let fahrenheit = item.quantity.doubleValue(for: .degreeFahrenheit())
            return WaterTemperature.Item(celsius: celsius, fahrenheit: fahrenheit, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = WaterTemperature(items: items)
        return model
    }

    // MARK: Saving

    public func saveAlcoholConsumption(model: AlcoholConsumption, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .numberOfAlcoholicBeverages)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .count(), doubleValue: $0.drinks)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveBloodAlcoholContent(model: AlcoholContent, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .bloodAlcoholContent)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .percent(), doubleValue: $0.percentage / 100.0)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveBloodGlucose(model: BloodGlucose, extra: [String: Sendable]?) async throws {
        try await saveBaseBloodGlucose(model: model, extra: extra)
    }

    public func saveHandWashing(model: HandWashing, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .handwashingEvent)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            return HKCategorySample(type: type, value: HKCategoryValue.notApplicable.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveInhalerUsage(model: InhalerUsage, extra: [String: Sendable]?) async throws {
        try await saveBaseInhalerUsage(model: model, extra: extra)
    }

    public func saveInsulinDelivery(model: InsulinDelivery, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .insulinDelivery)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: "IU")
        let sampleObjects = model.items.map {
            var metadata = extra ?? [:]
            metadata[HKMetadataKeyInsulinDeliveryReason] = $0.purpose.rawValue
            let quantity = HKQuantity(unit: unit, doubleValue: $0.value)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: metadata)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveNumberOfTimesFallen(model: NumberOfTimesFallen, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .numberOfTimesFallen)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .count(), doubleValue: Double($0.value))
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveSexualActivity(model: SexualActivity, extra: [String: Sendable]?) async throws {
        try await saveBaseSexualActivity(model, extra: extra)
    }

    public func saveToothBrushing(model: ToothBrushing, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .toothbrushingEvent)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            return HKCategorySample(type: type, value: HKCategoryValue.notApplicable.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveTimeInDaylight(model: TimeInDaylight, extra: [String: Sendable]?) async throws {
        try await baseSaveTimeInDaylight(model: model, extra: extra)
    }

    public func saveUvExposure(model: UVExposure, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .uvExposure)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .count(), doubleValue: Double($0.value))
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveWaterTemperature(model: WaterTemperature, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.quantityType(for: .waterTemperature)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: .degreeCelsius(), doubleValue: $0.celsius)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }
}
