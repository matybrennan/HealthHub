//
//  HeartManagerProtocol.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/7/18.
//

import Foundation

public enum HeartType: String, CaseIterable, Sendable {
    case atrialFibrillation
    case bloodPressure
    case cardioFitness
    case cardioRecovery
    case heartRate
    case heartRateVariability
    case highHeartRateEvents
    case irregularHeartRhythmEvents
    case lowHeartRateEvents
    case peripheralPerfusionIndex
    case restingHeartRate
    case walkingHeartRateAverage

    public var displayName: String {
        switch self {
        case .atrialFibrillation: "Atrial Fibrillation"
        case .bloodPressure: "Blood Pressure"
        case .cardioFitness: "Cardio Fitness (VO₂ Max)"
        case .cardioRecovery: "Cardio Recovery"
        case .heartRate: "Heart Rate"
        case .heartRateVariability: "Heart Rate Variability"
        case .highHeartRateEvents: "High Heart Rate Notifications"
        case .irregularHeartRhythmEvents: "Irregular Heart Rhythm Notifications"
        case .lowHeartRateEvents: "Low Heart Rate Notifications"
        case .peripheralPerfusionIndex: "Peripheral Perfusion Index"
        case .restingHeartRate: "Resting Heart Rate"
        case .walkingHeartRateAverage: "Walking Heart Rate Average"
        }
    }

    public var unit: String {
        switch self {
        case .atrialFibrillation: "%"
        case .bloodPressure: "mmHg"
        case .cardioFitness: "mL/kg·min"
        case .cardioRecovery: "BPM"
        case .heartRate: "BPM"
        case .heartRateVariability: "ms"
        case .highHeartRateEvents: "events"
        case .irregularHeartRhythmEvents: "events"
        case .lowHeartRateEvents: "events"
        case .peripheralPerfusionIndex: "%"
        case .restingHeartRate: "BPM"
        case .walkingHeartRateAverage: "BPM"
        }
    }

    /// Whether this type can be saved by third-party apps
    public var isSaveable: Bool {
        switch self {
        case .bloodPressure, .cardioFitness, .cardioRecovery, .peripheralPerfusionIndex: true
        default: false
        }
    }
}

public protocol HeartManagerProtocol {

    var heartRate: HeartRateService { get }

    func atrialFibrillation() async throws -> AtrialFibrillationHistory
    func bloodPressure() async throws -> BloodPressure
    func cardioFitness() async throws -> CardioFitness
    func cardioRecovery() async throws -> CardioRecovery
    func heartRateVariability() async throws -> HeartRateVariability
    func highHeartRateEvents() async throws -> HighHeartRateEvent
    func irregularHeartRhythmEvents() async throws -> IrregularHeartRhythmEvent
    func lowHeartRateEvents() async throws -> LowHeartRateEvent
    func peripheralPerfusionIndex() async throws -> PeripheralPerfusionIndex
    func restingHeartRate() async throws -> RestingHeartRate
    func walkingHeartRateAverage() async throws -> WalkingHeartRateAverage

    // MARK: - Save

    func saveBloodPressure(model: BloodPressure, extra: [String: Sendable]?) async throws
    func saveCardioFitness(model: CardioFitness, extra: [String: Sendable]?) async throws
    func saveCardioRecovery(model: CardioRecovery, extra: [String: Sendable]?) async throws
    func savePeripheralPerfusionIndex(model: PeripheralPerfusionIndex, extra: [String: Sendable]?) async throws
}
