//
//  RespiratoryServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation

public protocol RespiratoryServiceProtocol: AnyObject {

    // Fetch
    func bloodOxygen() async throws -> BloodOxygen
    func forcedExpiratoryVolume() async throws -> ForcedExpiratoryVolume
    func forcedVitalCapacity() async throws -> ForcedVitalCapacity
    func inhalerUsage() async throws -> InhalerUsage
    func peakExpiratoryFlowRate() async throws -> PeakExpiratoryFlowRate
    func respiratoryRate() async throws -> RespiratoryRate
    func sixMinuteWalk()  async throws -> SixMinuteWalk

    // Save
    func saveBloodOxygen(model: BloodOxygen, extra: [String : Any]?) async throws
    func saveForcedExpiratoryVolume(model: ForcedExpiratoryVolume, extra: [String : Any]?) async throws
    func saveForcedVitalCapacity(model: ForcedVitalCapacity, extra: [String : Any]?) async throws
    func saveInhalerUsage(model: InhalerUsage, extra: [String : Any]?) async throws
    func savePeakExpiratoryFlowRate(model: PeakExpiratoryFlowRate, extra: [String : Any]?) async throws
    func saveRespiratoryRate(model: RespiratoryRate, extra: [String : Any]?) async throws
    func saveSixMinuteWalk(model: SixMinuteWalk, extra: [String : Any]?)  async throws
}
