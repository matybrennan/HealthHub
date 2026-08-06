//
//  CycleTracking.swift
//  HealthHub
//
//  Created by matybrennan on 27/9/19.
//

import Foundation
import HealthKit

public final class CycleTracking {
    
    public init() { }
}

// MARK: - FetchCategorySample
extension CycleTracking: FetchCategorySample, SexualActivityCase, MenstruationCase, AbdominalCrampsCase { }

// MARK: - Private methods
private extension CycleTracking {
    
    func fetchGenericCycleResult(categoryIdentifier: HKCategoryTypeIdentifier) async throws -> GenericSymptomModel {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: categoryIdentifier, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> GenericSymptomModel.Item in
            let style = GenericSymptomModel.Item.Style(rawValue: item.value) ?? .notPresent
            return GenericSymptomModel.Item(style: style, startDate: item.startDate, endDate: item.endDate)
        }
        
        let type = HKCategoryType(categoryIdentifier)
        let model = GenericSymptomModel(items: items, type: type)
        return model
    }

    func saveGenericCycleResult(model: GenericSymptomModel, categoryIdentifier: HKCategoryTypeIdentifier, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: categoryIdentifier)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.style.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    func fetchCycleNotification(categoryIdentifier: HKCategoryTypeIdentifier, notificationType: CycleNotification.NotificationType) async throws -> CycleNotification {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: categoryIdentifier, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> CycleNotification.Item in
            CycleNotification.Item(startDate: item.startDate, endDate: item.endDate)
        }

        let model = CycleNotification(notificationType: notificationType, items: items)
        return model
    }

    func fetchVaginalBleedingSamples(categoryIdentifier: HKCategoryTypeIdentifier) async throws -> [HKCategorySample] {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        return try await fetchCategorySamples(categoryIdentifier: categoryIdentifier, sortDescriptors: [sortDescriptor])
    }
}

// MARK: - CycleTrackingProtocol
extension CycleTracking: CycleTrackingProtocol {
    
    public func abdominalCramps() async throws -> GenericSymptomModel {
        try await baseAbdominalCramps()
    }
    
    public func bloating() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .bloating)
    }
    
    public func breastPain() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .breastPain)
    }

    public func bleedingAfterPregnancy() async throws -> BleedingAfterPregnancy {
        let samples = try await fetchVaginalBleedingSamples(categoryIdentifier: .bleedingAfterPregnancy)
        let items = samples.map { item -> BleedingAfterPregnancy.Item in
            let type = VaginalBleedingType(rawValue: item.value) ?? .unspecified
            return BleedingAfterPregnancy.Item(type: type, startDate: item.startDate, endDate: item.endDate)
        }

        return BleedingAfterPregnancy(items: items)
    }

    public func bleedingDuringPregnancy() async throws -> BleedingDuringPregnancy {
        let samples = try await fetchVaginalBleedingSamples(categoryIdentifier: .bleedingDuringPregnancy)
        let items = samples.map { item -> BleedingDuringPregnancy.Item in
            let type = VaginalBleedingType(rawValue: item.value) ?? .unspecified
            return BleedingDuringPregnancy.Item(type: type, startDate: item.startDate, endDate: item.endDate)
        }

        return BleedingDuringPregnancy(items: items)
    }
    
    public func cervicalMucusQuality() async throws -> CervicalMucusQuality {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .cervicalMucusQuality, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> CervicalMucusQuality.Item in
            let type: CervicalMucusQuality.Item.MucusType = CervicalMucusQuality.Item.MucusType(rawValue: item.value) ?? .dry
            return CervicalMucusQuality.Item(type: type, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = CervicalMucusQuality(items: items)
        return model
    }

    public func contraceptive() async throws -> Contraceptive {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .contraceptive, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> Contraceptive.Item in
            let type = Contraceptive.Item.ContraceptiveType(rawValue: item.value) ?? .unspecified
            return Contraceptive.Item(type: type, startDate: item.startDate, endDate: item.endDate)
        }

        let model = Contraceptive(items: items)
        return model
    }

    public func lactation() async throws -> Lactation {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .lactation, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> Lactation.Item in
            Lactation.Item(startDate: item.startDate, endDate: item.endDate)
        }

        let model = Lactation(items: items)
        return model
    }
    
    public func menstruation() async throws -> Menstruation {
        try await baseMenstruation()
    }
    
    public func moodChanges() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .moodChanges)
    }
    
    public func ovulation() async throws -> Ovulation {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .ovulationTestResult, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> Ovulation.Item in
            let type: CycleResultType = CycleResultType(rawValue: item.value) ?? .indetermined
            return Ovulation.Item(type: type, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = Ovulation(items: items)
        return model
    }

    public func pregnancy() async throws -> Pregnancy {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .pregnancy, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> Pregnancy.Item in
            Pregnancy.Item(startDate: item.startDate, endDate: item.endDate)
        }

        let model = Pregnancy(items: items)
        return model
    }
    
    public func pregnancyTestResult() async throws -> PregnancyTestResult {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .pregnancyTestResult, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> PregnancyTestResult.Item in
            let type: CycleResultType = CycleResultType(rawValue: item.value) ?? .indetermined
            return PregnancyTestResult.Item(type: type, date: item.endDate)
        }
        
        let model = PregnancyTestResult(items: items)
        return model
    }
    
    public func progesteroneTestResult() async throws -> ProgesteroneTestResult {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .progesteroneTestResult, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> ProgesteroneTestResult.Item in
            let type: CycleResultType = CycleResultType(rawValue: item.value) ?? .indetermined
            return ProgesteroneTestResult.Item(type: type, date: item.endDate)
        }
        
        let model = ProgesteroneTestResult(items: items)
        return model
    }
    
    public func sexualActivity() async throws -> SexualActivity {
        try await baseSexualActivity()
    }
    
    public func spotting() async throws -> Spotting {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .intermenstrualBleeding, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> Spotting.Item in
            return Spotting.Item(date: item.endDate)
        }
        
        let model = Spotting(items: items)
        return model
    }
    
    public func vaginalDryness() async throws -> GenericSymptomModel {
        try await fetchGenericCycleResult(categoryIdentifier: .vaginalDryness)
    }

    // MARK: - Cycle Notifications (read-only)

    public func infrequentMenstrualCycles() async throws -> CycleNotification {
        try await fetchCycleNotification(categoryIdentifier: .infrequentMenstrualCycles, notificationType: .infrequentMenstrualCycles)
    }

    public func irregularMenstrualCycles() async throws -> CycleNotification {
        try await fetchCycleNotification(categoryIdentifier: .irregularMenstrualCycles, notificationType: .irregularMenstrualCycles)
    }

    public func persistentIntermenstrualBleeding() async throws -> CycleNotification {
        try await fetchCycleNotification(categoryIdentifier: .persistentIntermenstrualBleeding, notificationType: .persistentIntermenstrualBleeding)
    }

    public func prolongedMenstrualPeriods() async throws -> CycleNotification {
        try await fetchCycleNotification(categoryIdentifier: .prolongedMenstrualPeriods, notificationType: .prolongedMenstrualPeriods)
    }

    // MARK: - Saving

    public func saveAbdominalCramps(model: GenericSymptomModel, extra: [String: Sendable]?) async throws {
        try await saveBaseAbdominalCramps(model: model, extra: extra)
    }

    public func saveBloating(model: GenericSymptomModel, extra: [String: Sendable]?) async throws {
        try await saveGenericCycleResult(model: model, categoryIdentifier: .bloating, extra: extra)
    }

    public func saveBreastPain(model: GenericSymptomModel, extra: [String: Sendable]?) async throws {
        try await saveGenericCycleResult(model: model, categoryIdentifier: .breastPain, extra: extra)
    }

    public func saveBleedingAfterPregnancy(model: BleedingAfterPregnancy, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .bleedingAfterPregnancy)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.type.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveBleedingDuringPregnancy(model: BleedingDuringPregnancy, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .bleedingDuringPregnancy)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.type.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveCervicalMucusQuality(model: CervicalMucusQuality, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .cervicalMucusQuality)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.type.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveContraceptive(model: Contraceptive, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .contraceptive)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.type.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveLactation(model: Lactation, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .lactation)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: HKCategoryValue.notApplicable.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveMenstruation(model: Menstruation, extra: [String: Sendable]?) async throws {
        try await saveBaseMenstruation(model, extra: extra)
    }

    public func saveMoodChanges(model: GenericSymptomModel, extra: [String: Sendable]?) async throws {
        try await saveGenericCycleResult(model: model, categoryIdentifier: .moodChanges, extra: extra)
    }

    public func saveOvulation(model: Ovulation, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .ovulationTestResult)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.type.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func savePregnancy(model: Pregnancy, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .pregnancy)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: HKCategoryValue.notApplicable.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func savePregnancyTestResult(model: PregnancyTestResult, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .pregnancyTestResult)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.type.rawValue, start: $0.date, end: $0.date, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveProgesteroneTestResult(model: ProgesteroneTestResult, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .progesteroneTestResult)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: $0.type.rawValue, start: $0.date, end: $0.date, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveSexualActivity(model: SexualActivity, extra: [String: Sendable]?) async throws {
        try await saveBaseSexualActivity(model, extra: extra)
    }

    public func saveSpotting(model: Spotting, extra: [String: Sendable]?) async throws {
        let type = try HealthParser.categoryType(for: .intermenstrualBleeding)
        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            HKCategorySample(type: type, value: 0, start: $0.date, end: $0.date)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func saveVaginalDryness(model: GenericSymptomModel, extra: [String: Sendable]?) async throws {
        try await saveGenericCycleResult(model: model, categoryIdentifier: .vaginalDryness, extra: extra)
    }
}
