//
//  HealthDataCatalog.swift
//  HealthHub
//

import Foundation

/// A discoverable category for a HealthKit data type.
public enum HealthDataCategory: String, CaseIterable, Sendable {
    case activity
    case heart
    case body
    case mobility
    case nutrition
    case sleep
    case mentalWellbeing
    case reproductiveHealth
    case vitals
    case hearing
    case other
}

/// Metadata used to build authorization screens, catalogs, and diagnostics.
public struct HealthDataDescriptor: Sendable, Hashable {
    public let type: HealthObjectType
    public let displayName: String
    public let category: HealthDataCategory
    public let identifier: String?
    public let isAvailable: Bool
    public let isWritable: Bool
}

/// The single catalog for enumerating supported HealthKit data types.
public enum HealthDataCatalog {

    public static var all: [HealthDataDescriptor] {
        HealthObjectType.allCases.map(descriptor(for:))
    }

    public static func descriptor(for type: HealthObjectType) -> HealthDataDescriptor {
        let isAvailable = type.isAvailable
        let identifier = isAvailable ? type.readable.identifier : nil
        let isWritable = isAvailable && type.sharable != nil

        return HealthDataDescriptor(
            type: type,
            displayName: displayName(for: type),
            category: category(for: type),
            identifier: identifier,
            isAvailable: isAvailable,
            isWritable: isWritable
        )
    }

    public static func types(in category: HealthDataCategory) -> [HealthObjectType] {
        all.filter { $0.category == category }.map(\.type)
    }

    private static func category(for type: HealthObjectType) -> HealthDataCategory {
        for scope in HealthAuthorizationScope.allCases where scope.readTypes.contains(type) {
            switch scope {
            case .activity: return .activity
            case .heart: return .heart
            case .body: return .body
            case .mobility: return .mobility
            case .nutrition: return .nutrition
            case .sleep: return .sleep
            case .mentalWellbeing: return .mentalWellbeing
            case .reproductiveHealth: return .reproductiveHealth
            case .vitals: return .vitals
            case .hearing: return .hearing
            }
        }
        return .other
    }

    private static func displayName(for type: HealthObjectType) -> String {
        String(describing: type)
            .replacingOccurrences(of: "([a-z])([A-Z])", with: "$1 $2", options: .regularExpression)
            .replacingOccurrences(of: "([A-Z])([A-Z][a-z])", with: "$1 $2", options: .regularExpression)
            .capitalized
    }
}
