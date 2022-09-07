//
//  HealthTypes.swift
//  Pods
//
//  Created by Maty Brennan on 2/13/18.
//

import Foundation
import HealthKit

open class MBHealthParser {
    
    public static func unboxAndCheckIfAvailable(quantityIdentifier: HKQuantityTypeIdentifier) throws -> HKQuantityType {
        guard let result = HKQuantityType.quantityType(forIdentifier: quantityIdentifier) else {
            throw AuthorizationStatusError.unableToAccess(quantityIdentifier.rawValue)
        }
        try isDataStoreAvailable()
        return result
    }
    
    public static func unboxAndCheckIfAvailable(characterIdentifier: HKCharacteristicTypeIdentifier) throws -> HKCharacteristicType {
        guard let result = HKCharacteristicType.characteristicType(forIdentifier: characterIdentifier) else {
            throw AuthorizationStatusError.unableToAccess(characterIdentifier.rawValue)
        }
        try isDataStoreAvailable()
        return result
    }
    
    public static func unboxAndCheckIfAvailable(categoryIdentifier: HKCategoryTypeIdentifier) throws -> HKCategoryType {
        guard let result = HKCategoryType.categoryType(forIdentifier: categoryIdentifier) else {
            throw AuthorizationStatusError.unableToAccess(categoryIdentifier.rawValue)
        }
        try isDataStoreAvailable()
        return result
    }
    
    public static func unboxAndCheckIfAvailable(correlationIdentifier: HKCorrelationTypeIdentifier) throws -> HKCorrelationType {
        guard let result = HKCategoryType.correlationType(forIdentifier: correlationIdentifier) else {
            throw AuthorizationStatusError.unableToAccess(correlationIdentifier.rawValue)
        }
        try isDataStoreAvailable()
        return result
    }
    
    public static func workoutTypeAndCheckIfAvailable() throws -> HKWorkoutType {
        let workout = HKWorkoutType.workoutType()
        try isDataStoreAvailable()
        return workout
    }
    
    // Shareable content checker
    public static func checkSharingAuthorizationStatus(for type: HKObjectType) throws {
        
        switch healthStore.authorizationStatus(for: type) {
        case .notDetermined:
            throw AuthorizationStatusError.notDetermined(type.identifier)
        case .sharingDenied:
            throw AuthorizationStatusError.sharingDenied(type.identifier)
        case .sharingAuthorized:
            print("Success status for: \(type.identifier)")
        @unknown default:
            print("Unknown/New status for: \(type.identifier)")
        }
    }
}
