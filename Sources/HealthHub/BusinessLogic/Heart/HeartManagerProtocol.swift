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
    case lowCardioFitnessEvents
    case hypertensionEvents
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
        case .lowCardioFitnessEvents: "Low Cardio Fitness Notifications"
        case .hypertensionEvents: "Hypertension Notifications"
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
        case .lowCardioFitnessEvents: "events"
        case .hypertensionEvents: "events"
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

    var heartRate: HeartRateServiceProtocol { get }

    func atrialFibrillation() async throws -> AtrialFibrillationHistory
    func bloodPressure() async throws -> BloodPressure
    func cardioFitness() async throws -> CardioFitness
    func cardioRecovery() async throws -> CardioRecovery
    func heartRateVariability() async throws -> HeartRateVariability
    func highHeartRateEvents() async throws -> HighHeartRateEvent
    func irregularHeartRhythmEvents() async throws -> IrregularHeartRhythmEvent
    func lowHeartRateEvents() async throws -> LowHeartRateEvent
    func lowCardioFitnessEvents() async throws -> LowCardioFitnessEvent
    /// Requires iOS 26.2+. Throws `AsyncParsingError.unsupportedOSVersion` on earlier OS versions.
    func hypertensionEvents() async throws -> HypertensionEvent
    func peripheralPerfusionIndex() async throws -> PeripheralPerfusionIndex
    func restingHeartRate() async throws -> RestingHeartRate
    func walkingHeartRateAverage() async throws -> WalkingHeartRateAverage

    // MARK: - Save

    func saveBloodPressure(model: BloodPressure, extra: [String: Sendable]?) async throws
    func saveCardioFitness(model: CardioFitness, extra: [String: Sendable]?) async throws
    func saveCardioRecovery(model: CardioRecovery, extra: [String: Sendable]?) async throws
    func savePeripheralPerfusionIndex(model: PeripheralPerfusionIndex, extra: [String: Sendable]?) async throws
}
