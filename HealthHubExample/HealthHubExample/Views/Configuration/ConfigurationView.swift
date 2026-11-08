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

        let shareTypes: [HealthObjectType] = [.stepCount, .workout, .heartRate, .weight, .activeEnergy]
        var readTypes: [HealthObjectType] = [.stepCount, .workout, .heartRate, .weight, .activeEnergy, .sleepAnalysis]

        if #available(iOS 27.0, *) {
            readTypes += [.heartRateVariabilityRMSSD, .bleedingAfterMenopause, .menopausalState]
        }

        do {
            try await store.manager.configuration.requestAuthorization(toShare: shareTypes, toRead: readTypes)
        } catch {
            authorizationError = error.localizedDescription
        }
    }
}
