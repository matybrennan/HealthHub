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

    /// Check whether HealthKit would prompt for an authorization plan.
    ///
    /// HealthKit does not expose whether read authorization was granted for an
    /// individual type.
    func authorizationRequestStatus(for plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestStatus

    /// Request authorization with a least-privilege authorization plan.
    @discardableResult
    func requestAuthorization(plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestResult

    /// Legacy sharing status for a specific type.
    ///
    /// HealthKit does not expose per-type read authorization status.
    func authorizationStatus(for type: ReadableType) -> HKAuthorizationStatus

    /// Check whether a specific type is authorized for sharing (writing)
    func sharingAuthorizationStatus(for type: ShareableType) -> HKAuthorizationRequestStatus?

    /// Open the Apple Health app
    @MainActor
    func navigateToHealthSettings()
}

public extension ConfigurationServiceProtocol {

    func authorizationRequestStatus(for plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestStatus {
        .unknown
    }

    @discardableResult
    func requestAuthorization(plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestResult {
        try await requestAuthorization(toShare: plan.availableShareTypes, toRead: plan.availableReadTypes)
        return .requested
    }
}
