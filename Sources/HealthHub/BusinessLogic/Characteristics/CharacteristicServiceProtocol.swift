//
//  CharacteristicServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 5/23/18.
//

import Foundation
import HealthKit

public protocol CharacteristicServiceProtocol {
    var biologicalSex: BiologicalSex { get }
    var bloodType: BloodType { get }
    var dateOfBirth: DateComponents? { get }
    var skinType: FitzpatrickSkinType { get }
    var isWheelChairUser: WheelchairUse { get }
    var activityMoveMode: ActivityMoveMode { get }
}

// MARK: - Biological Sex

public enum BiologicalSex: Sendable {
    case female
    case male
    case other
    case notSet

    public var name: String {
        switch self {
        case .female: Copy.Gender.female
        case .male: Copy.Gender.male
        case .other: Copy.Gender.other
        case .notSet: "Not Set"
        }
    }

    init(from hkSex: HKBiologicalSex) {
        switch hkSex {
        case .female: self = .female
        case .male: self = .male
        case .other: self = .other
        case .notSet: self = .notSet
        @unknown default: self = .notSet
        }
    }
}

// MARK: - Blood Type

public enum BloodType: Sendable {
    case aPositive
    case aNegative
    case bPositive
    case bNegative
    case abPositive
    case abNegative
    case oPositive
    case oNegative
    case notSet

    public var name: String {
        switch self {
        case .aPositive: "A+"
        case .aNegative: "A-"
        case .bPositive: "B+"
        case .bNegative: "B-"
        case .abPositive: "AB+"
        case .abNegative: "AB-"
        case .oPositive: "O+"
        case .oNegative: "O-"
        case .notSet: "Not Set"
        }
    }

    init(from hkBloodType: HKBloodType) {
        switch hkBloodType {
        case .aPositive: self = .aPositive
        case .aNegative: self = .aNegative
        case .bPositive: self = .bPositive
        case .bNegative: self = .bNegative
        case .abPositive: self = .abPositive
        case .abNegative: self = .abNegative
        case .oPositive: self = .oPositive
        case .oNegative: self = .oNegative
        case .notSet: self = .notSet
        @unknown default: self = .notSet
        }
    }
}

// MARK: - Fitzpatrick Skin Type

public enum FitzpatrickSkinType: Sendable {
    case type1
    case type2
    case type3
    case type4
    case type5
    case type6
    case notSet

    public var name: String {
        switch self {
        case .type1: "Type I — Pale white skin"
        case .type2: "Type II — Fair skin"
        case .type3: "Type III — Darker white skin"
        case .type4: "Type IV — Light brown skin"
        case .type5: "Type V — Brown skin"
        case .type6: "Type VI — Dark brown or black skin"
        case .notSet: "Not Set"
        }
    }

    /// UV sensitivity description
    public var uvSensitivity: String {
        switch self {
        case .type1: "Very sensitive, always burns"
        case .type2: "Sensitive, burns easily"
        case .type3: "Moderate, sometimes burns"
        case .type4: "Tolerant, rarely burns"
        case .type5: "Resistant, very rarely burns"
        case .type6: "Very resistant, never burns"
        case .notSet: "Unknown"
        }
    }

    init(from hkSkinType: HKFitzpatrickSkinType) {
        switch hkSkinType {
        case .I: self = .type1
        case .II: self = .type2
        case .III: self = .type3
        case .IV: self = .type4
        case .V: self = .type5
        case .VI: self = .type6
        case .notSet: self = .notSet
        @unknown default: self = .notSet
        }
    }
}

// MARK: - Wheelchair Use

public enum WheelchairUse: Sendable {
    case yes
    case no
    case notSet

    public var name: String {
        switch self {
        case .yes: "Yes"
        case .no: "No"
        case .notSet: "Not Set"
        }
    }

    init(from hkWheelchairUse: HKWheelchairUse) {
        switch hkWheelchairUse {
        case .yes: self = .yes
        case .no: self = .no
        case .notSet: self = .notSet
        @unknown default: self = .notSet
        }
    }
}

// MARK: - Activity Move Mode

public enum ActivityMoveMode: Sendable {
    case activeEnergy
    case appleMoveTime
    case notSet

    public var name: String {
        switch self {
        case .activeEnergy: "Active Energy"
        case .appleMoveTime: "Move Time"
        case .notSet: "Not Set"
        }
    }

    init(from hkMode: HKActivityMoveMode) {
        switch hkMode {
        case .activeEnergy: self = .activeEnergy
        case .appleMoveTime: self = .appleMoveTime
        @unknown default: self = .notSet
        }
    }
}
