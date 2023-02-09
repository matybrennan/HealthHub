//
//  MBHealthHandler.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/2/2023.
//

import Foundation

public class MBHealthHandler: ObservableObject {
    
    public init() { }
    
    public enum State {
        case idle
        case hasRequestedHealthKitInfo(Bool)
    }
    
    @Published public var state: State = .idle
    
    public func resetState() {
        state = .idle
    }
}
