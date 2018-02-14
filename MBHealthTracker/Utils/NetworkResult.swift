//
//  NetworkResult.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/12/18.
//

import Foundation

public enum AsyncCallResult<T> {
    case success(T)
    case failed(Error)
}
