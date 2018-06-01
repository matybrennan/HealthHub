//
//  HealthType.swift
//  MBHealthTracker
//
//  Created by matybrennan on 23/4/18.
//

import Foundation
import HealthKit

public protocol SharableType {
    var sharable: HKSampleType { get }
}

public protocol ReadableType {
    var readable: HKObjectType { get }
}

public typealias SharableReadableType = SharableType & ReadableType

/// Has both read and sharing capabilities
public enum MBObjectType: SharableType, ReadableType {

    case stepCount
    case heartRate
    case workout
    
    public var sharable: HKSampleType {
        switch self {
        case .stepCount: return HKQuantityType.quantityType(forIdentifier: .stepCount)!
        case .heartRate: return HKQuantityType.quantityType(forIdentifier: .heartRate)!
        case .workout: return HKWorkoutType.workoutType()
        }
    }
    
    public var readable: HKObjectType {
        switch self {
        case .stepCount: return HKQuantityType.quantityType(forIdentifier: .stepCount)!
        case .heartRate: return HKQuantityType.quantityType(forIdentifier: .heartRate)!
        case .workout: return HKWorkoutType.workoutType()
        }
    }
}


public enum MBReadType: ReadableType {
    
    case dob
    
    public var readable: HKObjectType {
        switch self {
        case .dob:
            return HKCharacteristicType.characteristicType(forIdentifier: .dateOfBirth)!
        }
    }
}

public enum MBShareType: SharableType {
    
    public var sharable: HKSampleType {
        switch self {
            //
        }
    }
}


//public enum MBReadType { // HKObjectType
//
//    case stepCount
//    case heartRate
//    case workout
//
//    public var type: HKObjectType {
//        switch self {
//        case .stepCount:
//            return HKQuantityType.quantityType(forIdentifier: .stepCount)!
//        case .heartRate:
//            return HKQuantityType.quantityType(forIdentifier: .heartRate)!
//        case .workout:
//            return HKWorkoutType.workoutType()
//        }
//    }
//
//}

//public enum MBShareType { // HKSampleType
//
//    case stepCount
//    case heartRate
//    case workout
//
//    public var type: HKSampleType {
//        switch self {
//        case .stepCount:
//            return HKQuantityType.quantityType(forIdentifier: .stepCount)!
//        case .heartRate:
//            return HKQuantityType.quantityType(forIdentifier: .heartRate)!
//        case .workout:
//            return HKWorkoutType.workoutType()
//        }
//    }
//}



public struct MBHealthType {
    
//    public static func shareTypes(_ types: [MBShareType]) -> Set<HKSampleType>? {
//        let res = types.map { $0.type }
//        return Set(res)
//    }
//
//    public static func readTypes(_ types: [MBReadType]) -> Set<HKObjectType>? {
//        let res = types.map {$0.type }
//        return Set(res)
//    }
    
    static func shareTypes(_ types: [SharableType]) -> Set<HKSampleType>? {
        let res = types.map { $0.sharable }
        return Set(res)
    }
    
    static func readTypes(_ types: [ReadableType]) -> Set<HKObjectType>? {
        let res = types.map { $0.readable }
        return Set(res)
    }
}
