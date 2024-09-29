//
//  MBHealthHandler.swift
//  HealthHub
//
//  Created by Maty Brennan on 9/2/2023.
//

import Foundation

public protocol HealthHandlable: Sendable {
    func updateState(_ state: HealthHandler.State)
    func resetState()
}

public final class HealthHandler: ObservableObject, HealthHandlable, @unchecked Sendable {

    public init() { }
    
    public enum State: Sendable, Equatable {
        case idle
        case hasRequestedHealthKitInfo(Bool)
    }
    
    @Published public private(set) var state: State = .idle

    public func updateState(_ state: State) {
        self.state = state
        resetState()
    }

    public func resetState() {
        state = .idle
    }
}
