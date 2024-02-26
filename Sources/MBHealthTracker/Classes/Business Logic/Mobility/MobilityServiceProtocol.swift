//
//  File.swift
//  
//
//  Created by Maty Brennan on 24/2/2024.
//

import Foundation

public protocol MobilityServiceProtocol: AnyObject {

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
    func saveSixMinuteWalk(model: SixMinuteWalk) async throws
}
