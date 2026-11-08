//
//  HealthWriteMetadata.swift
//  HealthHub
//

import Foundation

/// Metadata helpers for idempotent and traceable HealthKit writes.
public enum HealthWriteMetadata {
    /// A namespaced metadata key for a caller-provided idempotency value.
    public static let idempotencyKey = "io.healthhub.idempotency-key"

    /// Creates metadata that lets an app identify a write across retry attempts.
    public static func idempotency(_ value: String) -> [String: any Sendable] {
        [idempotencyKey: value]
    }
}
