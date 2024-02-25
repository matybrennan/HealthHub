//
//  Helpers.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit

// TODO: Figure out better way to be able to use this in the framework
public var healthStore: HKHealthStore {
    return HKHealthStore()
}

public enum AuthorizationStatusError: LocalizedError {
    case notDetermined(String)
    case sharingDenied(String)
    case healthDataNotAvailable
    
    public var errorDescription: String? {
        switch self {
        case let .notDetermined(type): return "The status for \(type) has not been allowed in health settings"
        case let .sharingDenied(type): return "The status for \(type) has sharing denied in health settings for sharing"
        case .healthDataNotAvailable: return "Health data is not available to use on this device"
        }
    }
}

public func isDataStoreAvailable() throws {
    if !HKHealthStore.isHealthDataAvailable() {
        throw AuthorizationStatusError.healthDataNotAvailable
    }
}
