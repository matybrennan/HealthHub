//
//  HealthMetadata+Extension.swift
//  HealthHub
//

import Foundation

extension Optional where Wrapped == [String: Any] {

    /// HealthKit metadata values are Foundation value types, so the dictionary is safe to treat as `Sendable`.
    var sendableMetadata: [String: any Sendable]? {
        (self as Any) as? [String: any Sendable]
    }
}
