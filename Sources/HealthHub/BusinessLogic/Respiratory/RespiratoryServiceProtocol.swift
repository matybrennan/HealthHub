//
//  RespiratoryServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation
import HealthKit

public protocol RespiratoryServiceProtocol {

    // Fetch
    func bloodOxygen() async throws -> BloodOxygen
    func forcedExpiratoryVolume() async throws -> ForcedExpiratoryVolume
    func forcedVitalCapacity() async throws -> ForcedVitalCapacity
    func inhalerUsage() async throws -> InhalerUsage
    func peakExpiratoryFlowRate() async throws -> PeakExpiratoryFlowRate
    func respiratoryRate() async throws -> RespiratoryRate
    func sixMinuteWalk() async throws -> SixMinuteWalk

    // Save
    func saveBloodOxygen(model: BloodOxygen, extra: [String: Sendable]?) async throws
    func saveForcedExpiratoryVolume(model: ForcedExpiratoryVolume, extra: [String: Sendable]?) async throws
    func saveForcedVitalCapacity(model: ForcedVitalCapacity, extra: [String: Sendable]?) async throws
    func saveInhalerUsage(model: InhalerUsage, extra: [String: Sendable]?) async throws
    func savePeakExpiratoryFlowRate(model: PeakExpiratoryFlowRate, extra: [String: Sendable]?) async throws
    func saveRespiratoryRate(model: RespiratoryRate, extra: [String: Sendable]?) async throws
    func saveSixMinuteWalk(model: SixMinuteWalk, extra: [String: Sendable]?) async throws
}

public enum RespiratoryType: CaseIterable, Sendable {
    case bloodOxygen
    case forcedExpiratoryVolume
    case forcedVitalCapacity
    case inhalerUsage
    case peakExpiratoryFlowRate
    case respiratoryRate
    case sixMinuteWalk

    public var displayName: String {
        switch self {
        case .bloodOxygen: return "Blood Oxygen"
        case .forcedExpiratoryVolume: return "Forced Expiratory Volume (FEV1)"
        case .forcedVitalCapacity: return "Forced Vital Capacity (FVC)"
        case .inhalerUsage: return "Inhaler Usage"
        case .peakExpiratoryFlowRate: return "Peak Expiratory Flow Rate"
        case .respiratoryRate: return "Respiratory Rate"
        case .sixMinuteWalk: return "Six-Minute Walk"
        }
    }

    public var unit: String {
        switch self {
        case .bloodOxygen: return "%"
        case .forcedExpiratoryVolume: return "L"
        case .forcedVitalCapacity: return "L"
        case .inhalerUsage: return "uses"
        case .peakExpiratoryFlowRate: return "L/min"
        case .respiratoryRate: return "breaths/min"
        case .sixMinuteWalk: return "m"
        }
    }
}
