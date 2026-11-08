//
//  HealthQueryAnchorStore.swift
//  HealthHub
//

import Foundation

/// Persists query anchors between app launches for incremental HealthKit synchronization.
public protocol HealthQueryAnchorStoring: Sendable {
    func anchor(for key: String) async -> HealthQueryAnchor?
    func save(_ anchor: HealthQueryAnchor, for key: String) async
    func removeAnchor(for key: String) async
}

/// A UserDefaults-backed anchor store suitable for app targets.
public actor HealthQueryAnchorStore: HealthQueryAnchorStoring {
    private let userDefaults: UserDefaults
    private let prefix: String

    public init(suiteName: String? = nil, prefix: String = "HealthHub.queryAnchor") {
        userDefaults = suiteName.flatMap(UserDefaults.init(suiteName:)) ?? .standard
        self.prefix = prefix
    }

    public func anchor(for key: String) -> HealthQueryAnchor? {
        guard let data = userDefaults.data(forKey: storageKey(for: key)) else {
            return nil
        }
        return HealthQueryAnchor(data: data)
    }

    public func save(_ anchor: HealthQueryAnchor, for key: String) {
        userDefaults.set(anchor.data, forKey: storageKey(for: key))
    }

    public func removeAnchor(for key: String) {
        userDefaults.removeObject(forKey: storageKey(for: key))
    }

    private func storageKey(for key: String) -> String {
        "\(prefix).\(key)"
    }
}
