//
//  File.swift
//  
//
//  Created by Maty Brennan on 24/2/2024.
//

import Foundation

public protocol MobilityServiceProtocol: AnyObject {

    func cardioFitness() async throws -> CardioFitness
    func doubleSupportTime() async throws -> DoubleSupportTime
    func groundContactTime() async throws -> GroundContactTime
    func runningStrideLength() async throws -> RunningStrideLength
}
