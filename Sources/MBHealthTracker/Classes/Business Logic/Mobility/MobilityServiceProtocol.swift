//
//  File.swift
//  
//
//  Created by Maty Brennan on 24/2/2024.
//

import Foundation

public protocol MobilityServiceProtocol: AnyObject {

    // Fetch
    func cardioFitness() async throws -> CardioFitness // Cant save as healthkit prohibits
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
    func saveDoubleSupportTime(model: DoubleSupportTime) async throws
    func saveGroundContactTime(model: GroundContactTime) async throws
    func saveRunningStrideLength(model: RunningStrideLength) async throws
    func saveSixMinuteWalk(model: SixMinuteWalk) async throws
    func saveStairSpeedDown(model: StairSpeedDown) async throws
    func saveStairSpeedUp(model: StairSpeedUp) async throws
    func saveVerticalOscillation(model: VerticalOscillation) async throws
    func saveWalkingSpeed(model: WalkingSpeed) async throws
    func saveWalkingStepLength(model: WalkingStepLength) async throws
}
