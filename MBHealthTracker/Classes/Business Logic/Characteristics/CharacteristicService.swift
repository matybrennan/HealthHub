//
//  CharacteristicService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 5/23/18.
//

import Foundation
import HealthKit

public class CharacteristicService {
    
    //
    
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
        // TODO
        return nil
    }
    
    public var dateOfBirth: DateComponents? {
        return try? healthStore.dateOfBirthComponents()
    }
    
    public var skinType: String? {
        // TODO
        return nil
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
