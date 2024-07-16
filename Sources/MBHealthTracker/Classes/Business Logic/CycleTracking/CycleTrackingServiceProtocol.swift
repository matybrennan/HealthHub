//
//  CycleTrackingProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation

@MainActor
public protocol CycleTrackingProtocol: Sendable {

    // Fetch
    func abdominalCramps() async throws -> GenericSymptomModel
    func bloating() async throws -> GenericSymptomModel
    func breastPain() async throws -> GenericSymptomModel
    func cervicalMucusQuality() async throws -> CervicalMucusQuality
    func menstruation() async throws -> Menstruation
    func moodChanges() async throws -> GenericSymptomModel
    func ovulation() async throws -> Ovulation
    func pregnancyTestResult() async throws -> PregnancyTestResult
    func progesteroneTestResult() async throws -> ProgesteroneTestResult
    func sexualActivity() async throws -> SexualActivity
    func spotting() async throws -> Spotting
    func vaginalDryness() async throws -> GenericSymptomModel

    // Save
    func saveAbdominalCramps(model: GenericSymptomModel, extra: [String: Sendable]?) async throws
    func saveBloating(model: GenericSymptomModel, extra: [String: Sendable]?) async throws
    func saveBreastPain(model: GenericSymptomModel, extra: [String: Sendable]?) async throws
    func saveCervicalMucusQuality(model: CervicalMucusQuality, extra: [String: Sendable]?) async throws
    func saveMenstruation(model: Menstruation, extra: [String: Sendable]?) async throws
    func saveMoodChanges(model: GenericSymptomModel, extra: [String: Sendable]?) async throws
    func saveOvulation(model: Ovulation, extra: [String: Sendable]?) async throws
    func savePregnancyTestResult(model: PregnancyTestResult, extra: [String: Sendable]?) async throws
    func saveProgesteroneTestResult(model: ProgesteroneTestResult, extra: [String: Sendable]?) async throws
    func saveSexualActivity(model: SexualActivity, extra: [String: Sendable]?) async throws
    func saveSpotting(model: Spotting, extra: [String: Sendable]?) async throws
    func saveVaginalDryness(model: GenericSymptomModel, extra: [String: Sendable]?) async throws
}
