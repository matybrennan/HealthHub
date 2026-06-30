//
//  HeartRateExampleView.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 30/6/2026.
//

import SwiftUI
import HealthHub

struct HeartRateExampleView: View {
    let store: Store

    @State private var error: String?

    var body: some View {
        List {
            Section("Current") {
                if let current = store.manager.heartManager.heartRate.current {
                    Text("BPM: \(String(format: "%.0f", current.average))")
                } else {
                    Text("No current reading")
                        .foregroundStyle(.secondary)
                }
            }

            Section("Today") {
                let today = store.manager.heartManager.heartRate.today
                if today.count > 0 {
                    Text("Average: \(String(format: "%.0f", today.average)) BPM")
                    if let max = today.overallMax {
                        Text("Max: \(String(format: "%.0f", max)) BPM")
                    }
                    if let min = today.overallMin {
                        Text("Min: \(String(format: "%.0f", min)) BPM")
                    }
                    Text("Readings: \(today.count)")
                } else {
                    Text("No data yet")
                        .foregroundStyle(.secondary)
                }
            }

            if let error {
                Section("Error") {
                    Text(error).foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Heart Rate")
        .task {
            do {
                try await store.manager.heartManager.heartRate.heartRate(fromHeartRateType: .current)
                try await store.manager.heartManager.heartRate.heartRate(fromHeartRateType: .today(timeInterval: 60))
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
