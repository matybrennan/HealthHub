//
//  ConfigurationService.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit
import UIKit

@Observable
public final class ConfigurationService: ConfigurationServiceProtocol {

    static let appleHealthAppURL = "x-apple-health://"

    public let healthStore: HealthStoreProtocol

    public enum State: Equatable {
        case idle
        case hasRequestedHealthKitInfo(Bool)
    }

    public private(set) var state: State = .idle

    public init(healthStore: HealthStoreProtocol) {
        self.healthStore = healthStore
    }
    
    public func requestAuthorization(toShare share: [SharableType], toRead read: [ReadableType]) async throws {
        let shareTypes = HealthType.shareTypes(share)
        let readTypes = HealthType.readTypes(read)
        try await healthStore.requestAuthorization(toShare: shareTypes, read: readTypes)
        state = .hasRequestedHealthKitInfo(true)
    }
    
    public func navigateToHealthSettings() {
        UIApplication.shared.open(URL(string: ConfigurationService.appleHealthAppURL)!, options: [:], completionHandler: nil)
    }
}
