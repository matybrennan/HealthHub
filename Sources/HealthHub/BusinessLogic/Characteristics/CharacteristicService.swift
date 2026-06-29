//
//  CharacteristicService.swift
//  HealthHub
//
//  Created by Maty Brennan on 5/23/18.
//

import Foundation
import HealthKit

public final class CharacteristicService {
    
    public init() { }
}

// MARK: - CharacteristicServiceProtocol
extension CharacteristicService: CharacteristicServiceProtocol {
    
    public var biologicalSex: BiologicalSex {
        guard let hkSex = try? HealthStoreProvider.shared.biologicalSex().biologicalSex else {
            return .notSet
        }
        return BiologicalSex(from: hkSex)
    }
    
    public var bloodType: BloodType {
        guard let hkBloodType = try? HealthStoreProvider.shared.bloodType().bloodType else {
            return .notSet
        }
        return BloodType(from: hkBloodType)
    }
    
    public var dateOfBirth: DateComponents? {
        try? HealthStoreProvider.shared.dateOfBirthComponents()
    }
    
    public var skinType: FitzpatrickSkinType {
        guard let hkSkinType = try? HealthStoreProvider.shared.fitzpatrickSkinType().skinType else {
            return .notSet
        }
        return FitzpatrickSkinType(from: hkSkinType)
    }
    
    public var isWheelChairUser: WheelchairUse {
        guard let hkWheelchairUse = try? HealthStoreProvider.shared.wheelchairUse().wheelchairUse else {
            return .notSet
        }
        return WheelchairUse(from: hkWheelchairUse)
    }

    public var activityMoveMode: ActivityMoveMode {
        guard let hkMode = try? HealthStoreProvider.shared.activityMoveMode().activityMoveMode else {
            return .notSet
        }
        return ActivityMoveMode(from: hkMode)
    }
}
