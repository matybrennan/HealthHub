//
//  HealthHubClient.swift
//  HealthHub
//

import Foundation

/// The iOS 27-first entry point for authorization, queries, synchronization, and summaries.
public actor HealthHubClient {

    public let store: any HealthStoreClientProtocol

    public init(store: any HealthStoreClientProtocol) {
        self.store = store
    }

    public init() {
        store = HealthStoreClient()
    }

    @discardableResult
    public func requestAuthorization(plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestResult {
        try await store.requestAuthorization(plan: plan)
    }

    /// Requests read access for the given domains and optional write access.
    ///
    /// The prompt is skipped when HealthKit reports nothing new to request.
    @discardableResult
    public func requestAuthorization(scopes: [HealthAuthorizationScope], toShare: [HealthObjectType] = []) async throws -> HealthAuthorizationRequestResult {
        try await requestAuthorization(plan: HealthAuthorizationPlan(scopes: scopes, toShare: toShare))
    }

    public func authorizationRequestStatus(for plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestStatus {
        try await store.authorizationRequestStatus(for: plan)
    }

    public func dashboard(for dateRange: DateRangeType = .today) async throws -> HealthDashboard {
        try await HealthDashboardService(store: store).summary(for: dateRange)
    }
}
