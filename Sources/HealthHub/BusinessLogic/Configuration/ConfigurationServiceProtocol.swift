//
//  ConfigurationServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit

public protocol ConfigurationServiceProtocol {

    /// Current authorization state
    var state: ConfigurationService.State { get }

    /// Whether HealthKit data is available on this device
    var isHealthDataAvailable: Bool { get }

    /// Request authorization to read and/or write specific HealthKit data types
    func requestAuthorization(toShare share: [ShareableType], toRead read: [ReadableType]) async throws

    /// Check the current authorization status for a specific readable type
    func authorizationStatus(for type: ReadableType) -> HKAuthorizationStatus

    /// Check whether a specific type is authorized for sharing (writing)
    func sharingAuthorizationStatus(for type: ShareableType) -> HKAuthorizationRequestStatus?

    /// Open the Apple Health app
    func navigateToHealthSettings()
}
