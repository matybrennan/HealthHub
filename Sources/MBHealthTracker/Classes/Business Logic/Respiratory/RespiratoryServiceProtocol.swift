//
//  RespiratoryServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation

public protocol RespiratoryServiceProtocol: AnyObject {

    func bloodOxygen() async throws -> BloodOxygen
    func forcedExpiratoryVolume() async throws -> ForcedExpiratoryVolume
    func forcedVitalCapacity() async throws -> ForcedVitalCapacity
    func inhalerUsage() async throws -> InhalerUsage
    func peakExpiratoryFlowRate() async throws -> PeakExpiratoryFlowRate
    func respiratoryRate() async throws -> RespiratoryRate
    func sixMinuteWalk()  async throws -> SixMinuteWalk
}
