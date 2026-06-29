//
//  ConfigurationService.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit
import UIKit

@Observable
public final class ConfigurationService: ConfigurationServiceProtocol {

    private static let appleHealthAppURL = "x-apple-health://"

    private let healthStoreInstance: HealthStoreProtocol

    public var healthStore: HealthStoreProtocol {
        healthStoreInstance
    }

    public enum State: Equatable, Sendable {
        case idle
        case hasRequestedHealthKitInfo(Bool)
    }

    public private(set) var state: State = .idle

    public var isHealthDataAvailable: Bool {
        HKHealthStore.isHealthDataAvailable()
    }

    public init(healthStore: HealthStoreProtocol) {
        self.healthStoreInstance = healthStore
    }
    
    public func requestAuthorization(toShare share: [ShareableType], toRead read: [ReadableType]) async throws {
        guard isHealthDataAvailable else {
            throw AuthorizationStatusError.healthDataNotAvailable
        }
        let shareTypes = HealthType.shareTypes(from: share)
        let readTypes = HealthType.readTypes(read)
        try await healthStoreInstance.requestAuthorization(toShare: shareTypes, read: readTypes)
        state = .hasRequestedHealthKitInfo(true)
    }

    public func authorizationStatus(for type: ReadableType) -> HKAuthorizationStatus {
        HealthStoreProvider.shared.authorizationStatus(for: type.readable)
    }

    public func sharingAuthorizationStatus(for type: ShareableType) -> HKAuthorizationRequestStatus? {
        guard let sampleType = type.sharable else { return nil }
        return HealthStoreProvider.shared.authorizationStatus(for: sampleType) == .sharingAuthorized
            ? .unnecessary
            : .shouldRequest
    }
    
    public func navigateToHealthSettings() {
        guard let url = URL(string: Self.appleHealthAppURL) else { return }
        UIApplication.shared.open(url)
    }
}
