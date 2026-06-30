//
//  MobilityServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 24/2/2024.
//

import Foundation
import HealthKit

public enum MobilityType: String, CaseIterable, Sendable {
    case cardioFitness
    case doubleSupportTime
    case groundContactTime
    case runningStrideLength
    case sixMinuteWalk
    case stairSpeedDown
    case stairSpeedUp
    case verticalOscillation
    case walkingAsymmetry
    case walkingSpeed
    case walkingSteadiness
    case walkingStepLength

    public var displayName: String {
        switch self {
        case .cardioFitness: "Cardio Fitness (VO₂ Max)"
        case .doubleSupportTime: "Double Support Time"
        case .groundContactTime: "Ground Contact Time"
        case .runningStrideLength: "Running Stride Length"
        case .sixMinuteWalk: "Six-Minute Walk"
        case .stairSpeedDown: "Stair Speed: Down"
        case .stairSpeedUp: "Stair Speed: Up"
        case .verticalOscillation: "Vertical Oscillation"
        case .walkingAsymmetry: "Walking Asymmetry"
        case .walkingSpeed: "Walking Speed"
        case .walkingSteadiness: "Walking Steadiness"
        case .walkingStepLength: "Walking Step Length"
        }
    }

    public var unit: String {
        switch self {
        case .cardioFitness: "mL/kg·min"
        case .doubleSupportTime: "%"
        case .groundContactTime: "ms"
        case .runningStrideLength: "m"
        case .sixMinuteWalk: "m"
        case .stairSpeedDown: "m/s"
        case .stairSpeedUp: "m/s"
        case .verticalOscillation: "cm"
        case .walkingAsymmetry: "%"
        case .walkingSpeed: "km/hr"
        case .walkingSteadiness: "%"
        case .walkingStepLength: "cm"
        }
    }

    /// Whether this type can be saved by third-party apps
    public var isSaveable: Bool {
        switch self {
        case .walkingAsymmetry, .walkingSteadiness: false
        default: true
        }
    }
}

public protocol MobilityServiceProtocol {

    // Fetch
    func cardioFitness(from dateRange: DateRangeType) async throws -> CardioFitness
    func doubleSupportTime(from dateRange: DateRangeType) async throws -> DoubleSupportTime
    func groundContactTime(from dateRange: DateRangeType) async throws -> GroundContactTime
    func runningStrideLength(from dateRange: DateRangeType) async throws -> RunningStrideLength
    func sixMinuteWalk(from dateRange: DateRangeType) async throws -> SixMinuteWalk
    func stairSpeedDown(from dateRange: DateRangeType) async throws -> StairSpeedDown
    func stairSpeedUp(from dateRange: DateRangeType) async throws -> StairSpeedUp
    func verticalOscillation(from dateRange: DateRangeType) async throws -> VerticalOscillation
    func walkingAsymmetry(from dateRange: DateRangeType) async throws -> WalkingAsymmetry
    func walkingSpeed(from dateRange: DateRangeType) async throws -> WalkingSpeed
    func walkingSteadiness(from dateRange: DateRangeType) async throws -> WalkingSteadiness
    func walkingStepLength(from dateRange: DateRangeType) async throws -> WalkingStepLength

    // Save
    func saveCardioFitness(model: CardioFitness, extra: [String: Sendable]?) async throws
    func saveDoubleSupportTime(model: DoubleSupportTime, extra: [String: Sendable]?) async throws
    func saveGroundContactTime(model: GroundContactTime, extra: [String: Sendable]?) async throws
    func saveRunningStrideLength(model: RunningStrideLength, extra: [String: Sendable]?) async throws
    func saveSixMinuteWalk(model: SixMinuteWalk, extra: [String: Sendable]?) async throws
    func saveStairSpeedDown(model: StairSpeedDown, extra: [String: Sendable]?) async throws
    func saveStairSpeedUp(model: StairSpeedUp, extra: [String: Sendable]?) async throws
    func saveVerticalOscillation(model: VerticalOscillation, extra: [String: Sendable]?) async throws
    func saveWalkingSpeed(model: WalkingSpeed, extra: [String: Sendable]?) async throws
    func saveWalkingStepLength(model: WalkingStepLength, extra: [String: Sendable]?) async throws
}

// MARK: - Default date range (backwards compatibility)

public extension MobilityServiceProtocol {
    func cardioFitness() async throws -> CardioFitness { try await cardioFitness(from: .allTime) }
    func doubleSupportTime() async throws -> DoubleSupportTime { try await doubleSupportTime(from: .allTime) }
    func groundContactTime() async throws -> GroundContactTime { try await groundContactTime(from: .allTime) }
    func runningStrideLength() async throws -> RunningStrideLength { try await runningStrideLength(from: .allTime) }
    func sixMinuteWalk() async throws -> SixMinuteWalk { try await sixMinuteWalk(from: .allTime) }
    func stairSpeedDown() async throws -> StairSpeedDown { try await stairSpeedDown(from: .allTime) }
    func stairSpeedUp() async throws -> StairSpeedUp { try await stairSpeedUp(from: .allTime) }
    func verticalOscillation() async throws -> VerticalOscillation { try await verticalOscillation(from: .allTime) }
    func walkingAsymmetry() async throws -> WalkingAsymmetry { try await walkingAsymmetry(from: .allTime) }
    func walkingSpeed() async throws -> WalkingSpeed { try await walkingSpeed(from: .allTime) }
    func walkingSteadiness() async throws -> WalkingSteadiness { try await walkingSteadiness(from: .allTime) }
    func walkingStepLength() async throws -> WalkingStepLength { try await walkingStepLength(from: .allTime) }
}

