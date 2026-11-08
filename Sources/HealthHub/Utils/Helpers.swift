//
//  Helpers.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit
import Synchronization

/// The single `HKHealthStore` HealthHub uses, for both `HealthHubClient` and the domain services.
public enum HealthStoreProvider {
    private static let storage = Mutex(HKHealthStore())

    /// The store HealthHub currently uses. HealthHub creates one for you unless you call `configure(with:)`.
    public static var shared: HKHealthStore {
        storage.withLock { $0 }
    }

    /// Makes HealthHub use your own `HKHealthStore`, so your app and HealthHub share one store.
    ///
    /// Call this once at launch, before creating any HealthHub objects.
    public static func configure(with store: HKHealthStore) {
        storage.withLock { $0 = store }
    }
}

public protocol HealthStoreProtocol {
    func requestAuthorization(toShare typesToShare: Set<HKSampleType>, read typesToRead: Set<HKObjectType>) async throws
    func statusForAuthorizationRequest(toShare typesToShare: Set<HKSampleType>, read typesToRead: Set<HKObjectType>) async throws -> HKAuthorizationRequestStatus
}

public extension HealthStoreProtocol {
    func statusForAuthorizationRequest(toShare typesToShare: Set<HKSampleType>, read typesToRead: Set<HKObjectType>) async throws -> HKAuthorizationRequestStatus {
        .unknown
    }
}

extension HKHealthStore: HealthStoreProtocol { }

public enum AuthorizationStatusError: LocalizedError {
    case notDetermined(String)
    case sharingDenied(String)
    case healthDataNotAvailable
    
    public var errorDescription: String? {
        switch self {
        case let .notDetermined(type):
            "The status for \(type) has not been allowed in health settings"
        case let .sharingDenied(type):
            "The status for \(type) has sharing denied in health settings for sharing"
        case .healthDataNotAvailable:
            "Health data is not available to use on this device"
        }
    }
}

func ensureHealthDataAvailable() throws {
    if !HKHealthStore.isHealthDataAvailable() {
        throw AuthorizationStatusError.healthDataNotAvailable
    }
}
