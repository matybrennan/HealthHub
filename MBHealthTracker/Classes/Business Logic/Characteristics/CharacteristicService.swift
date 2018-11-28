//
//  CharacteristicService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 5/23/18.
//

import Foundation
import HealthKit

public class CharacteristicService {
    
    public init() { }
    
}

extension CharacteristicService: CharacteristicServiceProtocol {
    public var biologicalSex: String? {
        guard let sexCase: Int = try? healthStore.biologicalSex().biologicalSex.rawValue else {
            return nil
        }
        
        switch sexCase {
        case 0: return "Not Set"
        case 1: return "Female"
        case 2: return "Male"
        default: return "Other"
        }
    }
    
    public var bloodType: String? {
        guard let bloodType = try? healthStore.bloodType().bloodType.rawValue else {
            return nil
        }
        switch bloodType {
        case 0: return "Not Set"
        default: return "finish"
        }
    }
    
    public var dateOfBirth: DateComponents? {
        return try? healthStore.dateOfBirthComponents()
    }
    
    public var skinType: String? {
        guard let skin = try? healthStore.fitzpatrickSkinType().skinType.rawValue else {
            return nil
        }
        
        switch skin {
        case 0: return "Not Set"
        default: return "finish"
        }
    }
    
    public var isWheelChairUser: Bool? {
        guard let wheelChairCase = try? healthStore.wheelchairUse().wheelchairUse.rawValue else {
            return nil
        }
        
        switch wheelChairCase {
        case 0: return nil
        case 1: return true
        case 2: return false
        default: return nil
        }
    }
}
