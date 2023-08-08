//
//  OtherDataServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation

public protocol OtherDataServiceProtocol: AnyObject {
    
    func alcoholConsumption() async throws -> AlcoholConsumption
    func alcoholContent() async throws -> AlcoholContent
    func bloodGlucose() async throws -> BloodGlucose
    func handWashing() async throws -> HandWashing
    func inhalerUsage() async throws -> InhalerUsage
    func insulinDelivery() async throws -> InsulinDelivery
    func numberOfTimesFallen() async throws -> NumberOfTimesFallen
    func sexualActivity() async throws -> SexualActivity
    func toothBrushing() async throws -> ToothBrushing
    func uvExposure() async throws -> UVExposure
    func waterTemperature() async throws -> WaterTemperature
}
