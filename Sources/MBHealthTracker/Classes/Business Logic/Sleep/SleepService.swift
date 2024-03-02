//
//  SleepService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 1/12/18.
//

import Foundation
import HealthKit

public class SleepService {
    
    public init() { }
}

// MARK: - SleepCase
extension SleepService: SleepCase { }

// MARK: - SleepServiceProtocol
extension SleepService: SleepServiceProtocol {
    
    public func sleep() async throws -> Sleep {
        try await baseSleep()
    }
    
    public func save(model: Sleep, extra: [String : Any]?) async throws {
        try await baseSaveSleep(model: model, extra: extra)
    }
}
