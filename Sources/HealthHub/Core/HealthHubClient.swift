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

    public func requestAuthorization(plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestResult {
        try await store.requestAuthorization(plan: plan)
    }

    public func authorizationRequestStatus(for plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestStatus {
        try await store.authorizationRequestStatus(for: plan)
    }

    public func dashboard(for dateRange: DateRangeType = .today) async throws -> HealthDashboard {
        try await HealthDashboardService(store: store).summary(for: dateRange)
    }
}
