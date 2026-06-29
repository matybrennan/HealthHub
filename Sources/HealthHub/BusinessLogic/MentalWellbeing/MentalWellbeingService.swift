//
//  MentalWellbeingService.swift
//  HealthHub
//
//  Created by matybrennan on 24/9/19.
//

import Foundation
import HealthKit

public final class MentalWellbeingService {
    
    public init() { }
}

// MARK: - FetchQuantitySample
extension MentalWellbeingService: FetchCategorySample, SleepCase, TimeInDaylightCase { }

// MARK: - MentalWellbeingServiceProtocol
extension MentalWellbeingService: MentalWellbeingServiceProtocol {
    
    public func mindfulActivity() async throws -> Mindful {
        let sortDescriptor = SortDescriptor(\HKCategorySample.endDate, order: .reverse)
        let samples = try await fetchCategorySamples(categoryIdentifier: .mindfulSession, sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> Mindful.Info in
            Mindful.Info(value: item.value, startDate: item.startDate, endDate: item.endDate)
        }
        
        let vm = Mindful(items: items)
        return vm
    }

    public func stateOfMind() async throws -> StateOfMindEntry {
        let sortDescriptor = SortDescriptor(\HKStateOfMind.endDate, order: .reverse)
        let descriptor = HKSampleQueryDescriptor(predicates: [.stateOfMind()], sortDescriptors: [sortDescriptor])
        let samples = try await descriptor.result(for: HealthStoreProvider.shared)

        let items = samples.map { sample -> StateOfMindEntry.Item in
            let kind = StateOfMindEntry.Kind(rawValue: sample.kind.rawValue) ?? .momentaryEmotion
            let classification = StateOfMindEntry.ValenceClassification(rawValue: sample.valenceClassification.rawValue) ?? .neutral
            let labels = sample.labels.compactMap { StateOfMindEntry.Label(rawValue: $0.rawValue) }
            let associations = sample.associations.compactMap { StateOfMindEntry.Association(rawValue: $0.rawValue) }
            return StateOfMindEntry.Item(
                kind: kind,
                valence: sample.valence,
                valenceClassification: classification,
                labels: labels,
                associations: associations,
                date: sample.startDate
            )
        }

        return StateOfMindEntry(items: items)
    }

    public func gad7() async throws -> GAD7Assessment {
        let sortDescriptor = SortDescriptor(\HKGAD7Assessment.endDate, order: .reverse)
        let descriptor = HKSampleQueryDescriptor(predicates: [.gad7Assessment()], sortDescriptors: [sortDescriptor])
        let samples = try await descriptor.result(for: HealthStoreProvider.shared)

        let items = samples.map { sample -> GAD7Assessment.Item in
            let risk = GAD7Assessment.Risk(rawValue: sample.risk.rawValue) ?? .noneToMinimal
            let answers = sample.answers.compactMap { GAD7Assessment.Answer(rawValue: $0.rawValue) }
            return GAD7Assessment.Item(score: sample.score, risk: risk, answers: answers, date: sample.startDate)
        }

        return GAD7Assessment(items: items)
    }

    public func phq9() async throws -> PHQ9Assessment {
        let sortDescriptor = SortDescriptor(\HKPHQ9Assessment.endDate, order: .reverse)
        let descriptor = HKSampleQueryDescriptor(predicates: [.phq9Assessment()], sortDescriptors: [sortDescriptor])
        let samples = try await descriptor.result(for: HealthStoreProvider.shared)

        let items = samples.map { sample -> PHQ9Assessment.Item in
            let risk = PHQ9Assessment.Risk(rawValue: sample.risk.rawValue) ?? .noneToMinimal
            let answers = sample.answers.compactMap { PHQ9Assessment.Answer(rawValue: $0.rawValue) }
            return PHQ9Assessment.Item(score: sample.score, risk: risk, answers: answers, date: sample.startDate)
        }

        return PHQ9Assessment(items: items)
    }

    public func sleep() async throws -> Sleep {
        try await baseSleep()
    }

    public func timeInDaylight() async throws -> TimeInDaylight {
        try await baseTimeInDaylight()
    }

    // MARK: - Saving

    public func save(mindful: Mindful, extra: [String: Sendable]?) async throws {
        let mindfulType = try HealthParser.categoryType(for: .mindfulSession)
        try HealthParser.checkSharingAuthorizationStatus(for: mindfulType)
        let sampleObjects = mindful.items.map {
            HKCategorySample(type: mindfulType, value: HKCategoryValue.notApplicable.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func save(stateOfMind: StateOfMindEntry, extra: [String: Sendable]?) async throws {
        let sampleObjects = stateOfMind.items.map { item -> HKStateOfMind in
            let labels = item.labels.map { HKStateOfMind.Label(rawValue: $0.rawValue)! }
            let associations = item.associations.map { HKStateOfMind.Association(rawValue: $0.rawValue)! }
            let kind = HKStateOfMind.Kind(rawValue: item.kind.rawValue)!
            return HKStateOfMind(
                date: item.date,
                kind: kind,
                valence: item.valence,
                labels: labels,
                associations: associations,
                metadata: extra
            )
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func save(gad7: GAD7Assessment, extra: [String: Sendable]?) async throws {
        let sampleObjects = gad7.items.map { item -> HKGAD7Assessment in
            let answers = item.answers.map { HKGAD7Assessment.Answer(rawValue: $0.rawValue)! }
            return HKGAD7Assessment(
                date: item.date,
                answers: answers,
                metadata: extra
            )
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func save(phq9: PHQ9Assessment, extra: [String: Sendable]?) async throws {
        let sampleObjects = phq9.items.map { item -> HKPHQ9Assessment in
            let answers = item.answers.map { HKPHQ9Assessment.Answer(rawValue: $0.rawValue)! }
            return HKPHQ9Assessment(
                date: item.date,
                answers: answers,
                metadata: extra
            )
        }

        try await HealthStoreProvider.shared.save(sampleObjects)
    }

    public func save(model: Sleep, extra: [String: Sendable]?) async throws {
        try await baseSaveSleep(model: model, extra: extra)
    }

    public func saveTimeInDaylight(model: TimeInDaylight, extra: [String: Sendable]?) async throws {
        try await baseSaveTimeInDaylight(model: model, extra: extra)
    }
}

