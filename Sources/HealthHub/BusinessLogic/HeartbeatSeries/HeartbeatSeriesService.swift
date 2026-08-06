//
//  HeartbeatSeriesService.swift
//  HealthHub
//
//  Created by Copilot on 7/8/2026.
//

import Foundation
import HealthKit

public final class HeartbeatSeriesService {

    public init() { }
}

// MARK: - HeartbeatSeriesServiceProtocol
extension HeartbeatSeriesService: HeartbeatSeriesServiceProtocol {

    public func heartbeatSeries() async throws -> HeartbeatSeries {
        try ensureHealthDataAvailable()
        let sortDescriptor = SortDescriptor(\HKHeartbeatSeriesSample.endDate, order: .reverse)
        let descriptor = HKSampleQueryDescriptor(predicates: [.heartbeatSeries()], sortDescriptors: [sortDescriptor])
        let samples = try await descriptor.result(for: HealthStoreProvider.shared)

        let items = samples.map { sample in
            HeartbeatSeries.Item(startDate: sample.startDate, endDate: sample.endDate)
        }

        return HeartbeatSeries(items: items)
    }

    public func heartbeats(for sample: HKHeartbeatSeriesSample) async throws -> [HeartbeatSeries.Heartbeat] {
        try ensureHealthDataAvailable()
        let descriptor = HKHeartbeatSeriesQueryDescriptor(sample)
        var items: [HeartbeatSeries.Heartbeat] = []

        for try await heartbeat in descriptor.results(for: HealthStoreProvider.shared) {
            items.append(
                HeartbeatSeries.Heartbeat(
                    timeSinceSeriesStart: heartbeat.timeIntervalSinceStart,
                    precededByGap: heartbeat.precededByGap
                )
            )
        }

        return items
    }

    public func saveHeartbeatSeries(model: HeartbeatSeries.Record, extra: [String: Sendable]?) async throws {
        try ensureHealthDataAvailable()
        guard !model.heartbeats.isEmpty else {
            throw AsyncParsingError.unableToParse("Heartbeat series must contain at least one heartbeat")
        }
        guard let type = HKObjectType.seriesType(forIdentifier: HKDataTypeIdentifierHeartbeatSeries) else {
            throw AsyncParsingError.unableToParse("Unable to create heartbeat series type")
        }

        try HealthParser.checkSharingAuthorizationStatus(for: type)

        let builder = HKHeartbeatSeriesBuilder(healthStore: HealthStoreProvider.shared, device: nil, start: model.startDate)
        if let metadata = Self.metadata(from: extra), !metadata.isEmpty {
            try await builder.addMetadata(metadata)
        }

        for heartbeat in model.heartbeats.sorted(by: { $0.timeSinceSeriesStart < $1.timeSinceSeriesStart }) {
            try await builder.addHeartbeat(at: heartbeat.timeSinceSeriesStart, precededByGap: heartbeat.precededByGap)
        }

        _ = try await builder.finishSeries()
    }
}

// MARK: - Private
private extension HeartbeatSeriesService {

    static func metadata(from extra: [String: Sendable]?) -> [String: Any]? {
        extra?.reduce(into: [String: Any]()) { result, item in
            result[item.key] = item.value
        }
    }
}
