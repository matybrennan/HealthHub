//
//  HealthParser.swift
//  HealthHub
//
//  Created by Maty Brennan on 2/13/18.
//

import Foundation
import HealthKit

public enum HealthParser {
    
    public static func quantityType(for identifier: HKQuantityTypeIdentifier) throws -> HKQuantityType {
        try ensureHealthDataAvailable()
        return HKQuantityType(identifier)
    }
    
    public static func characteristicType(for identifier: HKCharacteristicTypeIdentifier) throws -> HKCharacteristicType {
        try ensureHealthDataAvailable()
        return HKCharacteristicType(identifier)
    }
    
    public static func categoryType(for identifier: HKCategoryTypeIdentifier) throws -> HKCategoryType {
        try ensureHealthDataAvailable()
        return HKCategoryType(identifier)
    }
    
    public static func correlationType(for identifier: HKCorrelationTypeIdentifier) throws -> HKCorrelationType {
        try ensureHealthDataAvailable()
        return HKCorrelationType(identifier)
    }
    
    public static func workoutTypeAndCheckIfAvailable() throws -> HKWorkoutType {
        try ensureHealthDataAvailable()
        return HKWorkoutType.workoutType()
    }
    
    public static func checkSharingAuthorizationStatus(for type: HKObjectType) throws {
        switch HealthStoreProvider.shared.authorizationStatus(for: type) {
        case .notDetermined:
            throw AuthorizationStatusError.notDetermined(type.identifier)
        case .sharingDenied:
            throw AuthorizationStatusError.sharingDenied(type.identifier)
        case .sharingAuthorized:
            break
        @unknown default:
            break
        }
    }
}
