//
//  AuthorizationModels.swift
//  HealthHub
//

import Foundation

/// A least-privilege collection of HealthKit types to read and share.
public struct HealthAuthorizationPlan: Sendable {

    public let toShare: [HealthObjectType]
    public let toRead: [HealthObjectType]

    public init(toShare: [HealthObjectType] = [], toRead: [HealthObjectType] = []) {
        self.toShare = toShare
        self.toRead = toRead
    }

    /// Creates a read-only plan from the supplied health domains.
    ///
    /// Add write access explicitly through `toShare` to avoid asking for
    /// permissions an app does not need.
    public init(scopes: [HealthAuthorizationScope], toShare: [HealthObjectType] = []) {
        self.init(toShare: toShare, toRead: scopes.flatMap(\.readTypes))
    }

    /// Equivalent to `toShare`; every type exists on iOS 27+. Kept for source compatibility with 3.x.
    public var availableShareTypes: [HealthObjectType] { toShare }

    /// Equivalent to `toRead`; every type exists on iOS 27+. Kept for source compatibility with 3.x.
    public var availableReadTypes: [HealthObjectType] { toRead }
}

/// Common HealthKit domains for authorization planning.
public enum HealthAuthorizationScope: String, CaseIterable, Sendable {
    case activity
    case heart
    case body
    case mobility
    case nutrition
    case sleep
    case mentalWellbeing
    case reproductiveHealth
    case vitals
    case hearing

    public var readTypes: [HealthObjectType] {
        switch self {
        case .activity:
            [.stepCount, .workout, .activeEnergy, .exerciseMinutes, .standTime, .moveTime,
             .cyclingDistance, .cyclingPower, .walkingRunningDistance, .runningSpeed, .runningPower, .flightsClimbed]
        case .heart:
            [.heartRate, .heartRateVariability, .heartRateVariabilityRMSSD, .restingHeartRate,
             .walkingHeartRateAverage, .atrialFibrillation, .cardioRecovery, .peripheralPerfusionIndex,
             .highHeartRateEvent, .lowHeartRateEvent, .irregularHeartRhythmEvent, .lowCardioFitnessEvent,
             .hypertensionEvent]
        case .body:
            [.weight, .height, .bodyMassIndex, .bodyFatPercentage, .leanBodyMass, .waistCircumference,
             .basalBodyTemperature, .bodyTemperature, .wristTemperature, .electrodermalActivity]
        case .mobility:
            [.walkingSpeed, .walkingStepLength, .walkingAsymmetry, .walkingSteadiness,
             .walkingSteadinessEvent, .doubleSupportTime, .groundContactTime, .runningStrideLength,
             .stairSpeedDown, .stairSpeedUp, .verticalOscillation]
        case .nutrition:
            [.energyConsumed, .carbohydrates, .protein, .fatTotal, .fiber, .sugar, .water, .caffeine]
        case .sleep:
            [.sleepAnalysis, .sleepApneaEvent, .sleepingBreathingDisturbances]
        case .mentalWellbeing:
            [.mindful, .stateOfMind, .gad7Assessment, .phq9Assessment, .timeInDaylight]
        case .reproductiveHealth:
            [.menstruation, .sexualActivity, .abdominalCramps, .bloating, .breastPain, .contraceptives,
             .cervicalMucusQuality, .ovulationTestResult, .pregnancy, .pregancyTestResult,
             .progesteroneTestResult, .lactation, .spotting, .vaginalDryness, .bleedingDuringPregnancy,
             .bleedingAfterPregnancy, .bleedingAfterMenopause, .menopausalState]
        case .vitals:
            [.bloodGlucose, .bloodOxygen, .bloodPressureSystolic, .bloodPressureDiastolic,
             .respiratoryRate, .bodyTemperature]
        case .hearing:
            [.environmentalAudioExposure, .headphoneAudioExposure, .environmentalAudioExposureEvent,
             .headphoneAudioExposureEvent, .environmentalSoundReduction, .audiogram]
        }
    }
}

/// Whether HealthKit would prompt for an authorization request.
///
/// This reflects request necessity only. HealthKit does not reveal whether read
/// access was granted for an individual type.
public enum HealthAuthorizationRequestStatus: Sendable, Equatable {
    case unknown
    case shouldRequest
    case unnecessary
}

/// The outcome of submitting a `HealthAuthorizationPlan`.
public enum HealthAuthorizationRequestResult: Sendable, Equatable {
    /// HealthKit displayed or processed an authorization request.
    case requested
    /// HealthKit reported that the requested authorization is already current.
    case notRequired
}
