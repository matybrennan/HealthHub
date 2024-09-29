//
//  ConfigurationService.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit
import UIKit

public final class ConfigurationService: ConfigurationServiceProtocol {

    static let appleHealthAppURL = "x-apple-health://"
    
    public let handler: HealthHandlable
    public let healthStore: HealthStoreProtocol

    public init(handler: HealthHandlable, healthStore: HealthStoreProtocol) {
        self.handler = handler
        self.healthStore = healthStore
    }
    
    public func requestAuthorization(toShare share: [SharableType], toRead read: [ReadableType]) async throws {
        let shareTypes = HealthType.shareTypes(share)
        let readTypes = HealthType.readTypes(read)
        try await healthStore.requestAuthorization(toShare: shareTypes, read: readTypes)
        handler.updateState(.hasRequestedHealthKitInfo(true))
    }
    
    public func navigateToHealthSettings() async {
        #if canImport(UIKit)
        await MainActor.run {
            UIApplication.shared.open(URL(string: ConfigurationService.appleHealthAppURL)!, options: [:], completionHandler: nil)
        }
        #endif
    }
}
