//
//  ConfigurationService.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit


public class ConfigurationService {
    
    static let appleHealthAppURL = "x-apple-health://"
}

extension ConfigurationService: ConfigurationServiceProtocol {
    
    public func requestAuthorization(toShare share: [SharableType], toRead read: [ReadableType], completionHandler: @escaping (MBAsyncCallResult<Bool>) -> Void) {
        
        let shareTypes = MBHealthType.shareTypes(share)
        let readTypes = MBHealthType.readTypes(read)
        
        healthStore.requestAuthorization(toShare: shareTypes, read: readTypes) { (status, error) in
            if let error = error {
                completionHandler(.failed(error))
            } else {
                completionHandler(.success(status))
            }
        }
    }
    
    public func navigateToHealthSettings() {
        UIApplication.shared.open(URL(string: ConfigurationService.appleHealthAppURL)!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
