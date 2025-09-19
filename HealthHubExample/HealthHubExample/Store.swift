//
//  Store.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 29/9/2024.
//

import Foundation
import HealthHub
import Combine

@MainActor
@Observable
final class Store {

    let manager: HealthHubManager
    private var cancellables = [AnyCancellable]()

    init(manager: HealthHubManager) {
        self.manager = manager
        configure()
    }

    func configure() {
        //
    }

    func runTest() async {
        do {
            let result = try await manager.heartManager.atrialFibrillation()
            print("result: \(result)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
