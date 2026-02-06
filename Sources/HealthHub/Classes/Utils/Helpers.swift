//
//  Helpers.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit

public enum HealthStoreProvider {
    public static let shared = HKHealthStore()
}

public protocol HealthStoreProtocol {
    func requestAuthorization(toShare typesToShare: Set<HKSampleType>, read typesToRead: Set<HKObjectType>) async throws
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

public func ensureHealthDataAvailable() throws {
    if !HKHealthStore.isHealthDataAvailable() {
        throw AuthorizationStatusError.healthDataNotAvailable
    }
}
