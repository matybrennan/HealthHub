//
//  VitalsServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 9/12/19.
//

import Foundation

public protocol VitalsServiceProtocol: AnyObject {
    
    // Fetch
    func bloodGlucose() async throws -> BloodGlucose
    func bloodOxygen() async throws -> BloodOxygen
    func bloodPressure() async throws -> BloodPressure
    func bodyTemperature() async throws -> BodyTemperature
    func menstruation() async throws -> Menstruation
    func respiratoryRate() async throws -> RespiratoryRate

    // Save
    func saveBloodGlucose(model: BloodGlucose, extra: [String : Any]?) async throws
    func saveBloodOxygen(model: BloodOxygen, extra: [String : Any]?) async throws
    func saveBloodPressure(model: BloodPressure, extra: [String : Any]?) async throws
    func saveBodyTemperature(model: BodyTemperature, extra: [String : Any]?) async throws
    func saveMenstruation(model: Menstruation, extra: [String : Any]?) async throws
    func saveRespiratoryRate(model: RespiratoryRate, extra: [String : Any]?) async throws
}

