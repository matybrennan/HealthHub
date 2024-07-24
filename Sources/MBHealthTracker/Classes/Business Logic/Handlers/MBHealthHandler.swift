//
//  MBHealthHandler.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/2/2023.
//

import Foundation

public final class MBHealthHandler: ObservableObject {

    public init() { }
    
    public enum State: Sendable {
        case idle
        case hasRequestedHealthKitInfo(Bool)
    }
    
    @Published public private(set) var state: State = .idle
    
    public func resetState() {
        state = .idle
    }

    public func updateState(_ state: State) {
        self.state = state
        resetState()
    }
}
