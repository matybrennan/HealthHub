//
//  ConfigurationView.swift
//  HealthHubExample
//

import SwiftUI
import HealthHub

struct ConfigurationView: View {

    let store: Store

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

            Button("Request Authorization") {
                Task {
                    try? await store.manager.configuration.requestAuthorization(
                        toShare: [HealthObjectType.stepCount, .workout, .heartRate, .weight, .activeEnergy],
                        toRead: [HealthObjectType.stepCount, .workout, .heartRate, .weight, .activeEnergy, .sleepAnalysis]
                    )
                }
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
        .navigationTitle("Configuration")
    }
}
