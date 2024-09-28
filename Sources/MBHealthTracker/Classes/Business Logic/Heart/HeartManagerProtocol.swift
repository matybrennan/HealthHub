//
//  HeartManagerProtocol.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/7/18.
//

import Foundation

public protocol HeartManagerProtocol: Sendable {

    // Services
    var heartRate: HeartRateService { get }

    // Fetch
    func atrialFibrillation() async throws -> AtrialFibrillationHistory
    func bloodPressure() async throws -> BloodPressure
    func cardioFitness() async throws -> CardioFitness
    func cardioRecovery() async throws -> CardioRecovery
    func peripheralPerfusionIndex() async throws -> PeripheralPerfusionIndex

    // Save
    func saveBloodPressure(model: BloodPressure, extra: [String: Sendable]?) async throws
    func saveCardioFitness(model: CardioFitness, extra: [String: Sendable]?) async throws
    func saveCardioRecovery(model: CardioRecovery, extra: [String: Sendable]?) async throws
    func savePeripheralPerfusionIndex(model: PeripheralPerfusionIndex, extra: [String: Sendable]?) async throws
}
