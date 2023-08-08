//
//  VitalsServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 9/12/19.
//

import Foundation

public protocol VitalsServiceProtocol: AnyObject {
    
    func bloodGlucose() async throws -> BloodGlucose
    func bloodOxygen() async throws -> BloodOxygen
    func bloodPressure() async throws -> BloodPressure
    func bodyTemperature() async throws -> BodyTemperature
    func menstruation() async throws -> Menstruation
    func respiratoryRate() async throws -> RespiratoryRate
}

