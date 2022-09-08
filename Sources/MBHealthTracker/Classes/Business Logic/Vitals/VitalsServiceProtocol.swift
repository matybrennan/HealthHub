//
//  VitalsServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 9/12/19.
//

import Foundation

public protocol VitalsServiceProtocol: AnyObject {
    
    func bloodGlucose() async throws -> BloodGlucose
    func bloodPressure() async throws -> BloodPressure
    func bloodOxygen() async throws -> BloodOxygen
}

