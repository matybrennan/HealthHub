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

// MARK: - CharacteristicServiceProtocol
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
        case 1: return "aPositive"
        case 2: return "aNegative"
        case 3: return "bPositive"
        case 4: return "bNegative"
        case 5: return "abPositive"
        case 6: return "abNegative"
        case 7: return "oPositive"
        case 8: return "oNegative"
        default: return "Not Set"
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
        case 1: return "Pale white skin, blue/green eyes, blond/red hair"
        case 2: return "Fair skin, blue eyes"
        case 3: return "Darker white skin"
        case 4: return "Light brown skin"
        case 5: return "Brown skin"
        case 6: return "Dark brown or black skin"
        default: return "Not Set"
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
