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
    func cardioFitness() async throws -> CardioFitness
    func doubleSupportTime() async throws -> DoubleSupportTime
    func groundContactTime() async throws -> GroundContactTime
    func runningStrideLength() async throws -> RunningStrideLength
    func sixMinuteWalk() async throws -> SixMinuteWalk
    func stairSpeedDown() async throws -> StairSpeedDown
    func stairSpeedUp() async throws -> StairSpeedUp
    func verticalOscillation() async throws -> VerticalOscillation
    func walkingAsymmetry() async throws -> WalkingAsymmetry
    func walkingSpeed() async throws -> WalkingSpeed
    func walkingSteadiness() async throws -> WalkingSteadiness
    func walkingStepLength() async throws -> WalkingStepLength

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

