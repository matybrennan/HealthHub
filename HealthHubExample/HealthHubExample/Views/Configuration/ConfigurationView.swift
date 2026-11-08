//
//  ConfigurationView.swift
//  HealthHubExample
//

import SwiftUI
import HealthHub

struct ConfigurationView: View {

    let store: Store
    @State private var isRequestingAuthorization = false
    @State private var authorizationError: String?

    var body: some View {
        VStack(spacing: 20) {
            GroupBox {
                HStack {
                    Text("HealthKit Available")
                    Spacer()
                    Image(systemName: store.manager.configuration.isHealthDataAvailable ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundStyle(store.manager.configuration.isHealthDataAvailable ? .green : .red)
                }
            }

            Button(isRequestingAuthorization ? "Requesting Authorization..." : "Request Authorization") {
                Task {
                    await requestAuthorization()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(!store.manager.configuration.isHealthDataAvailable || isRequestingAuthorization)

            if let authorizationError {
                Text(authorizationError)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Configuration")
    }

    private func requestAuthorization() async {
        isRequestingAuthorization = true
        authorizationError = nil
        defer { isRequestingAuthorization = false }

        let plan = HealthAuthorizationPlan(
            scopes: [.activity, .heart, .body, .sleep],
            toShare: [.workout, .weight, .activeEnergy]
        )

        do {
            try await store.health.requestAuthorization(plan: plan)
        } catch {
            authorizationError = error.localizedDescription
        }
    }
}
