//
//  NetworkResult.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/12/18.
//

import Foundation

/// Result can come back empty meaning may not have access to property or its empty
public enum AsyncCallResult<T> {
    case success(T)
    case failed(Error)
}

public enum MBAsyncParsingError: LocalizedError {
    case unableToParse(String)
    
    public var errorDescription: String? {
        switch self {
        case let .unableToParse(value): return "Unable to parse: \(value)"
        }
    }
}
