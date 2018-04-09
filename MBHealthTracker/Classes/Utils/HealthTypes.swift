//
//  HealthTypes.swift
//  Pods
//
//  Created by Maty Brennan on 2/13/18.
//

import Foundation
import HealthKit

public enum HealthTypeError: Error {
    case unableToAccess(String)
}

open class HealthType {
    
    static func unbox(quantityIdentifier: HKQuantityTypeIdentifier) throws -> HKQuantityType {
        guard let result = HKQuantityType.quantityType(forIdentifier: quantityIdentifier) else {
            throw HealthTypeError.unableToAccess(quantityIdentifier.rawValue)
        }
        return result
    }
    
    
}
