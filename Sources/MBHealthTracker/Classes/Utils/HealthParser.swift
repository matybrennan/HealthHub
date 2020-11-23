//
//  HealthTypes.swift
//  Pods
//
//  Created by Maty Brennan on 2/13/18.
//

import Foundation
import HealthKit

public enum MBHealthParserError: Error {
    case unableToAccess(String)
}

open class MBHealthParser {
    
    static func unbox(quantityIdentifier: HKQuantityTypeIdentifier) throws -> HKQuantityType {
        guard let result = HKQuantityType.quantityType(forIdentifier: quantityIdentifier) else {
            throw MBHealthParserError.unableToAccess(quantityIdentifier.rawValue)
        }
        return result
    }
    
    static func unbox(characterIdentifier: HKCharacteristicTypeIdentifier) throws -> HKCharacteristicType {
        guard let result = HKCharacteristicType.characteristicType(forIdentifier: characterIdentifier) else {
            throw MBHealthParserError.unableToAccess(characterIdentifier.rawValue)
        }
        return result
    }
    
    static func unbox(categoryIdentifier: HKCategoryTypeIdentifier) throws -> HKCategoryType {
        guard let result = HKCategoryType.categoryType(forIdentifier: categoryIdentifier) else {
            throw MBHealthParserError.unableToAccess(categoryIdentifier.rawValue)
        }
        return result
    }
    
    static func unbox(correlationIdentifier: HKCorrelationTypeIdentifier) throws -> HKCorrelationType {
        guard let result = HKCategoryType.correlationType(forIdentifier: correlationIdentifier) else {
            throw MBHealthParserError.unableToAccess(correlationIdentifier.rawValue)
        }
        return result
    }
}
