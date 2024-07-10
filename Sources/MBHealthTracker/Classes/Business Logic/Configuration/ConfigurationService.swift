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
    
    public let handler: MBHealthHandler
    
    public init(handler: MBHealthHandler) {
        self.handler = handler
    }
    
    public func requestAuthorization(toShare share: [SharableType], toRead read: [ReadableType]) async throws {
        let shareTypes = MBHealthType.shareTypes(share)
        let readTypes = MBHealthType.readTypes(read)
        try await healthStore.requestAuthorization(toShare: shareTypes, read: readTypes)
        print(Thread.current)
        await handler.updateState(.hasRequestedHealthKitInfo(true))
        print(Thread.current)
    }
    
    public func navigateToHealthSettings() {
        #if canImport(UIKit)
        UIApplication.shared.open(URL(string: ConfigurationService.appleHealthAppURL)!, options: [:], completionHandler: nil)
        #endif
    }
}
