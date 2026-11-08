//
//  ElectrocardiogramServiceProtocol.swift
//  HealthHub
//
//  Created by Copilot on 7/8/2026.
//

import Foundation
import HealthKit

public protocol ElectrocardiogramServiceProtocol {

    /// Electrocardiogram samples are read-only in HealthKit for third-party apps.
    func electrocardiogram() async throws -> Electrocardiogram
    func voltageMeasurements(for sample: HKElectrocardiogram) async throws -> [Electrocardiogram.VoltageMeasurement]
}
