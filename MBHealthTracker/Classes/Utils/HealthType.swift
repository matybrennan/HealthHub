//
//  HealthType.swift
//  MBHealthTracker
//
//  Created by matybrennan on 23/4/18.
//

import Foundation
import HealthKit

// TODO: Figure out solution better for Read & Share enum Types
public enum MBReadType { // HKObjectType
    
    case stepCount
    case heartRate
    case workout
    
    public var type: HKObjectType {
        switch self {
        case .stepCount:
            return HKQuantityType.quantityType(forIdentifier: .stepCount)!
        case .heartRate:
            return HKQuantityType.quantityType(forIdentifier: .heartRate)!
        case .workout:
            return HKWorkoutType.workoutType()
        }
    }
    
}

public enum MBShareType { // HKSampleType
    
    case stepCount
    case heartRate
    case workout
    
    public var type: HKSampleType {
        switch self {
        case .stepCount:
            return HKQuantityType.quantityType(forIdentifier: .stepCount)!
        case .heartRate:
            return HKQuantityType.quantityType(forIdentifier: .heartRate)!
        case .workout:
            return HKWorkoutType.workoutType()
        }
    }
}

public struct MBHealthType {
    
    public static func shareTypes(_ types: [MBShareType]) -> Set<HKSampleType>? {
        let res = types.map { $0.type }
        return Set(res)
    }
    
    public static func readTypes(_ types: [MBReadType]) -> Set<HKObjectType>? {
        let res = types.map {$0.type }
        return Set(res)
    }
}
