//
//  Store.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 29/9/2024.
//

import Foundation
import HealthHub
import Combine

@Observable
final class Store {

    private let manager: HealthHubManager
    private var cancellables = [AnyCancellable]()

    init(manager: HealthHubManager) {
        self.manager = manager

        configure()
    }

    func configure() {
        manager.healthHandler.$state.sink { state in
            switch state {
            case .idle:
                print("idle")
            case .hasRequestedHealthKitInfo(let value):
                print("value: \(value)")
            }
        }.store(in: &cancellables)
    }

    func configurePermissions() async {
        try? await manager.configuration.requestAuthorization(toShare: HealthObjectType.allCases, toRead: HealthObjectType.allCases)
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
