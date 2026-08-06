//
//  HeartbeatSeriesServiceProtocol.swift
//  HealthHub
//
//  Created by Copilot on 7/8/2026.
//

import Foundation
import HealthKit

public protocol HeartbeatSeriesServiceProtocol {

    func heartbeatSeries() async throws -> HeartbeatSeries
    func heartbeats(for sample: HKHeartbeatSeriesSample) async throws -> [HeartbeatSeries.Heartbeat]
    func saveHeartbeatSeries(model: HeartbeatSeries.Record, extra: [String: Sendable]?) async throws
}
