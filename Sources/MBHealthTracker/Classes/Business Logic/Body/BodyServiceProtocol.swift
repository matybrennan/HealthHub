//
//  BodyServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 20/9/19.
//

import Foundation

public protocol BodyServiceProtocol: AnyObject {
    
    func basalBodyTemperature() async throws -> BasalBodyTemperature
    func bodyFatPercentage() async throws -> BodyFatPercentage
    func bodyMassIndex() async throws -> BodyMassIndex
    func bodyTemperature() async throws -> BodyTemperature
    func height() async throws -> BodyHeight
    func leanBodyMass() async throws -> LeanBodyMass
    func waistCircumference() async throws -> WaistCircumference
    func weight() async throws -> BodyWeight
    func electrodermalActivity() async throws -> ElectrodermalActivity
    
}
