import Foundation
import HealthKit
@testable import HealthHub

actor MockHealthStoreClient: HealthStoreClientProtocol {

    let requestStatus: HealthAuthorizationRequestStatus
    let requestResult: HealthAuthorizationRequestResult
    let statisticsByIdentifier: [String: HealthQuantityStatistics]
    let summariesByIdentifier: [String: [HealthSampleSummary]]

    init(
        requestStatus: HealthAuthorizationRequestStatus = .shouldRequest,
        requestResult: HealthAuthorizationRequestResult = .requested,
        statisticsByIdentifier: [String: HealthQuantityStatistics] = [:],
        summariesByIdentifier: [String: [HealthSampleSummary]] = [:]
    ) {
        self.requestStatus = requestStatus
        self.requestResult = requestResult
        self.statisticsByIdentifier = statisticsByIdentifier
        self.summariesByIdentifier = summariesByIdentifier
    }

    func authorizationRequestStatus(for plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestStatus {
        requestStatus
    }

    func requestAuthorization(plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestResult {
        requestResult
    }

    func sampleSummaries(for types: [HealthObjectType], query: HealthQuery, unit: HKUnit?) async throws -> [HealthSampleSummary] {
        types.flatMap { summariesByIdentifier[$0.readable.identifier] ?? [] }
    }

    func statistics(for type: HealthObjectType, unit: HKUnit, query: HealthQuery) async throws -> HealthQuantityStatistics {
        guard let statistics = statisticsByIdentifier[type.readable.identifier] else {
            return HealthQuantityStatistics(
                typeIdentifier: type.readable.identifier,
                unit: unit.unitString,
                sum: nil,
                average: nil,
                minimum: nil,
                maximum: nil
            )
        }
        return statistics
    }

    func save(_ objects: [HKObject]) async throws { }

    func delete(_ objects: [HKObject]) async throws { }

    func anchoredChanges(for type: HealthObjectType, from anchor: HealthQueryAnchor?, query: HealthQuery, unit: HKUnit?) async throws -> HealthAnchoredChange {
        HealthAnchoredChange(addedSamples: [], deletedObjectIDs: [], anchor: HealthQueryAnchor(data: Data()))
    }

    func synchronize(for type: HealthObjectType, anchorKey: String, anchorStore: any HealthQueryAnchorStoring, query: HealthQuery, unit: HKUnit?) async throws -> HealthAnchoredChange {
        try await anchoredChanges(for: type, from: nil, query: query, unit: unit)
    }

    func updates(for types: [HealthObjectType], query: HealthQuery) async throws -> AsyncThrowingStream<HealthStoreChange, Error> {
        AsyncThrowingStream { continuation in
            continuation.finish()
        }
    }

    func enableBackgroundUpdates(for types: [HealthObjectType], frequency: HKUpdateFrequency) async throws { }
}
