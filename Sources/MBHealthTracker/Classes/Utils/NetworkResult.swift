//
//  NetworkResult.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/12/18.
//

import Foundation

public enum MBAsyncCallResult<T> {
    case success(T)
    case failed(Error)
}

public enum MBAsyncParsingError: LocalizedError {
    case unableToParse(String)
    
    public var errorDescription: String? {
        switch self {
        case let .unableToParse(value):
            "Unable to parse: \(value)"
        }
    }
}
