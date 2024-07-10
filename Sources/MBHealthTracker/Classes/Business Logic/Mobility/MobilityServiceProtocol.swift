//
//  File.swift
//  
//
//  Created by Maty Brennan on 24/2/2024.
//

import Foundation

@MainActor
public protocol MobilityServiceProtocol: Sendable {

    // Fetch
    func cardioFitness() async throws -> CardioFitness
    func doubleSupportTime() async throws -> DoubleSupportTime
    func groundContactTime() async throws -> GroundContactTime
    func runningStrideLength() async throws -> RunningStrideLength
    func sixMinuteWalk() async throws -> SixMinuteWalk
    func stairSpeedDown() async throws -> StairSpeedDown
    func stairSpeedUp() async throws -> StairSpeedUp
    func verticalOscillation() async throws -> VerticalOscillation
    func walkingAsymmetry() async throws -> WalkingAsymmetry // Cant save as healthkit prohibits
    func walkingSpeed() async throws -> WalkingSpeed
    func walkingSteadiness() async throws -> WalkingSteadiness // Cant save as healthkit prohibits
    func walkingStepLength() async throws -> WalkingStepLength

    // Save
    func saveCardioFitness(model: CardioFitness, extra: [String : Any]?) async throws
    func saveDoubleSupportTime(model: DoubleSupportTime, extra: [String : Any]?) async throws
    func saveGroundContactTime(model: GroundContactTime, extra: [String : Any]?) async throws
    func saveRunningStrideLength(model: RunningStrideLength, extra: [String : Any]?) async throws
    func saveSixMinuteWalk(model: SixMinuteWalk, extra: [String : Any]?) async throws
    func saveStairSpeedDown(model: StairSpeedDown, extra: [String : Any]?) async throws
    func saveStairSpeedUp(model: StairSpeedUp, extra: [String : Any]?) async throws
    func saveVerticalOscillation(model: VerticalOscillation, extra: [String : Any]?) async throws
    func saveWalkingSpeed(model: WalkingSpeed, extra: [String : Any]?) async throws
    func saveWalkingStepLength(model: WalkingStepLength, extra: [String : Any]?) async throws
}
