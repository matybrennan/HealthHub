//
//  ConfigurationService.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit
import UIKit

public class ConfigurationService: ConfigurationServiceProtocol {
    
    static let appleHealthAppURL = "x-apple-health://"
    
    public init() { }
    
    public func requestAuthorization(toShare share: [SharableType], toRead read: [ReadableType]) async throws {
        let shareTypes = MBHealthType.shareTypes(share)
        let readTypes = MBHealthType.readTypes(read)
        try await healthStore.requestAuthorization(toShare: shareTypes, read: readTypes)
    }
    
    public func navigateToHealthSettings() {
        UIApplication.shared.open(URL(string: ConfigurationService.appleHealthAppURL)!, options: [:], completionHandler: nil)
    }
}
