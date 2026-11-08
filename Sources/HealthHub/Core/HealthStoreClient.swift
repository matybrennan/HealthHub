//
//  HealthStoreClient.swift
//  HealthHub
//

import Foundation
import HealthKit

/// A single, injectable gateway for all HealthKit I/O.
public protocol HealthStoreClientProtocol: Sendable {
    func authorizationRequestStatus(for plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestStatus
    @discardableResult
    func requestAuthorization(plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestResult
    func sampleSummaries(for types: [HealthObjectType], query: HealthQuery, unit: HKUnit?) async throws -> [HealthSampleSummary]
    func statistics(for type: HealthObjectType, unit: HKUnit, query: HealthQuery) async throws -> HealthQuantityStatistics
    func save(_ objects: [HKObject]) async throws
    func delete(_ objects: [HKObject]) async throws
    func anchoredChanges(for type: HealthObjectType, from anchor: HealthQueryAnchor?, query: HealthQuery, unit: HKUnit?) async throws -> HealthAnchoredChange
    func synchronize(for type: HealthObjectType, anchorKey: String, anchorStore: any HealthQueryAnchorStoring, query: HealthQuery, unit: HKUnit?) async throws -> HealthAnchoredChange
    func updates(for types: [HealthObjectType], query: HealthQuery) async throws -> AsyncThrowingStream<HealthStoreChange, Error>
    func enableBackgroundUpdates(for types: [HealthObjectType], frequency: HKUpdateFrequency) async throws
    /// Earliest readable date per type when the user granted limited read access. Types with full access are omitted.
    func earliestAuthorizedDates(for types: [HealthObjectType]) async throws -> [HealthObjectType: Date]
}

public extension HealthStoreClientProtocol {

    func earliestAuthorizedDates(for types: [HealthObjectType]) async throws -> [HealthObjectType: Date] {
        [:]
    }
}

/// The iOS 27 HealthKit client used by `HealthHubClient`.
public actor HealthStoreClient: HealthStoreClientProtocol {

    private let healthStore: HKHealthStore

    public init(healthStore: HKHealthStore = HKHealthStore()) {
        self.healthStore = healthStore
    }

    public func authorizationRequestStatus(for plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestStatus {
        try ensureHealthDataAvailable()

        let status = try await healthStore.statusForAuthorizationRequest(
            toShare: HealthType.shareTypes(from: plan.availableShareTypes),
            read: HealthType.readTypes(plan.availableReadTypes)
        )

        switch status {
        case .unknown:
            return .unknown
        case .shouldRequest:
            return .shouldRequest
        case .unnecessary:
            return .unnecessary
        @unknown default:
            return .unknown
        }
    }

    public func earliestAuthorizedDates(for types: [HealthObjectType]) async throws -> [HealthObjectType: Date] {
        try ensureHealthDataAvailable()

        let dates = try await healthStore.earliestAuthorizedSampleDate(for: Set(types.map(\.readable)))
        return types.reduce(into: [:]) { result, type in
            result[type] = dates[type.readable]
        }
    }

    @discardableResult
    public func requestAuthorization(plan: HealthAuthorizationPlan) async throws -> HealthAuthorizationRequestResult {
        switch try await authorizationRequestStatus(for: plan) {
        case .unnecessary:
            return .notRequired
        case .unknown, .shouldRequest:
            try await healthStore.requestAuthorization(
                toShare: HealthType.shareTypes(from: plan.availableShareTypes),
                read: HealthType.readTypes(plan.availableReadTypes)
            )
            return .requested
        }
    }

    public func sampleSummaries(
        for types: [HealthObjectType],
        query: HealthQuery = .init(),
        unit: HKUnit? = nil
    ) async throws -> [HealthSampleSummary] {
        let predicate = try query.predicate()
        var summaries: [HealthSampleSummary] = []

        for type in types {
            let sampleType = try sampleType(for: type)
            let samplePredicate = HKSamplePredicate<HKSample>.sample(type: sampleType, predicate: predicate)
            let descriptor = HKSampleQueryDescriptor(
                predicates: [samplePredicate],
                sortDescriptors: [query.sortDescriptor()],
                limit: query.limit
            )
            let samples = try await descriptor.result(for: healthStore)
            summaries += samples.map { HealthSampleSummary(sample: $0, unit: unit) }
        }

        return summaries.sorted {
            query.sortOrder == .newestFirst ? $0.endDate > $1.endDate : $0.endDate < $1.endDate
        }
    }

    public func statistics(
        for type: HealthObjectType,
        unit: HKUnit,
        query: HealthQuery = .init()
    ) async throws -> HealthQuantityStatistics {
        guard let quantityType = type.readable as? HKQuantityType else {
            throw HealthHubError.unsupportedType(String(describing: type))
        }

        let predicate = try query.predicate()
        let statistics: HKStatistics? = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<HKStatistics?, Error>) in
            let query = HKStatisticsQuery(
                quantityType: quantityType,
                quantitySamplePredicate: predicate,
                options: [.cumulativeSum, .discreteAverage, .discreteMin, .discreteMax]
            ) { _, result, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: result)
                }
            }
            healthStore.execute(query)
        }

        return HealthQuantityStatistics(
            typeIdentifier: quantityType.identifier,
            unit: unit.unitString,
            sum: statistics?.sumQuantity()?.doubleValue(for: unit),
            average: statistics?.averageQuantity()?.doubleValue(for: unit),
            minimum: statistics?.minimumQuantity()?.doubleValue(for: unit),
            maximum: statistics?.maximumQuantity()?.doubleValue(for: unit)
        )
    }

    public func save(_ objects: [HKObject]) async throws {
        try ensureHealthDataAvailable()
        try await healthStore.save(objects)
    }

    public func delete(_ objects: [HKObject]) async throws {
        try ensureHealthDataAvailable()
        try await healthStore.delete(objects)
    }

    public func anchoredChanges(
        for type: HealthObjectType,
        from anchor: HealthQueryAnchor? = nil,
        query: HealthQuery = .init(),
        unit: HKUnit? = nil
    ) async throws -> HealthAnchoredChange {
        let sampleType = try sampleType(for: type)
        let predicate = try query.predicate()
        let healthKitAnchor = try anchor?.healthKitAnchor()

        return try await withCheckedThrowingContinuation { continuation in
            let anchoredQuery = HKAnchoredObjectQuery(
                type: sampleType,
                predicate: predicate,
                anchor: healthKitAnchor,
                limit: query.limit ?? HKObjectQueryNoLimit,
                resultsHandler: { _, addedSamples, deletedObjects, newAnchor, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let newAnchor else {
                    continuation.resume(throwing: HealthHubError.invalidAnchor)
                    return
                }

                do {
                    continuation.resume(returning: HealthAnchoredChange(
                        addedSamples: (addedSamples ?? []).map { HealthSampleSummary(sample: $0, unit: unit) },
                        deletedObjectIDs: (deletedObjects ?? []).map(\.uuid),
                        anchor: try HealthQueryAnchor(anchor: newAnchor)
                    ))
                } catch {
                    continuation.resume(throwing: error)
                }
            })
            healthStore.execute(anchoredQuery)
        }
    }

    public func synchronize(
        for type: HealthObjectType,
        anchorKey: String,
        anchorStore: any HealthQueryAnchorStoring,
        query: HealthQuery = .init(),
        unit: HKUnit? = nil
    ) async throws -> HealthAnchoredChange {
        let anchor = await anchorStore.anchor(for: anchorKey)
        let change = try await anchoredChanges(for: type, from: anchor, query: query, unit: unit)
        await anchorStore.save(change.anchor, for: anchorKey)
        return change
    }

    public func updates(
        for types: [HealthObjectType],
        query: HealthQuery = .init()
    ) async throws -> AsyncThrowingStream<HealthStoreChange, Error> {
        let predicate = try query.predicate()
        var sampleTypes: [HKSampleType] = []
        for type in types {
            sampleTypes.append(try sampleType(for: type))
        }
        let session = HealthObserverSession(healthStore: healthStore)

        return AsyncThrowingStream { continuation in
            for sampleType in sampleTypes {
                let typeIdentifier = sampleType.identifier
                let observerQuery = HKObserverQuery(sampleType: sampleType, predicate: predicate) { _, completion, error in
                    defer { completion() }

                    if let error {
                        continuation.finish(throwing: error)
                    } else {
                        continuation.yield(HealthStoreChange(typeIdentifier: typeIdentifier))
                    }
                }
                session.add(observerQuery)
            }

            continuation.onTermination = { _ in
                session.stop()
            }
        }
    }

    public func enableBackgroundUpdates(
        for types: [HealthObjectType],
        frequency: HKUpdateFrequency
    ) async throws {
        for type in types {
            try await healthStore.enableBackgroundDelivery(for: try sampleType(for: type), frequency: frequency)
        }
    }

    private func sampleType(for type: HealthObjectType) throws -> HKSampleType {
        guard let sampleType = type.readable as? HKSampleType else {
            throw HealthHubError.unsupportedType(String(describing: type))
        }
        return sampleType
    }

    private func ensureHealthDataAvailable() throws {
        guard HKHealthStore.isHealthDataAvailable() else {
            throw HealthHubError.healthDataUnavailable
        }
    }
}

private final class HealthObserverSession: @unchecked Sendable {
    private let healthStore: HKHealthStore
    private let lock = NSLock()
    private var queries: [HKObserverQuery] = []

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    func add(_ query: HKObserverQuery) {
        lock.lock()
        queries.append(query)
        lock.unlock()
        healthStore.execute(query)
    }

    func stop() {
        lock.lock()
        let activeQueries = queries
        queries.removeAll()
        lock.unlock()
        activeQueries.forEach(healthStore.stop)
    }
}
