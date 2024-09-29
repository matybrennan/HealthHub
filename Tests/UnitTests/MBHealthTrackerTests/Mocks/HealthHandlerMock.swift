//
//  File.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 29/9/2024.
//

import Foundation
@testable import MBHealthTracker

final class HealthHandlerMock: HealthHandlable, @unchecked Sendable {

    private(set) var state: HealthHandler.State = .idle

    func updateState(_ state: HealthHandler.State) {
        self.state = state
    }

    func resetState() {
        state = .idle
    }
}
