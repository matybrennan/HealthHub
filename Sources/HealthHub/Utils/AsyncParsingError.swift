//
//  NetworkResult.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/12/18.
//

import Foundation

enum AsyncParsingError: LocalizedError {
    case unableToParse(String)
    case unsupportedOSVersion(String)
    
    public var errorDescription: String? {
        switch self {
        case let .unableToParse(value):
            "Unable to parse: \(value)"
        case let .unsupportedOSVersion(value):
            "\(value) requires a newer OS version than is currently running"
        }
    }
}
