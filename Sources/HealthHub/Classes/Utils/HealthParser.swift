//
//  HealthTypes.swift
//  Pods
//
//  Created by Maty Brennan on 2/13/18.
//

import Foundation
import HealthKit

open class HealthParser {
    
    public static func unboxAndCheckIfAvailable(quantityIdentifier: HKQuantityTypeIdentifier) throws -> HKQuantityType {
        let result = HKQuantityType(quantityIdentifier)
        try isDataStoreAvailable()
        return result
    }
    
    public static func unboxAndCheckIfAvailable(characterIdentifier: HKCharacteristicTypeIdentifier) throws -> HKCharacteristicType {
        let result = HKCharacteristicType(characterIdentifier)
        try isDataStoreAvailable()
        return result
    }
    
    public static func unboxAndCheckIfAvailable(categoryIdentifier: HKCategoryTypeIdentifier) throws -> HKCategoryType {
        let result = HKCategoryType(categoryIdentifier)
        try isDataStoreAvailable()
        return result
    }
    
    public static func unboxAndCheckIfAvailable(correlationIdentifier: HKCorrelationTypeIdentifier) throws -> HKCorrelationType {
        let result = HKCorrelationType(correlationIdentifier)
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
