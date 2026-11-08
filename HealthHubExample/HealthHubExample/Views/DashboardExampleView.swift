//
//  DashboardExampleView.swift
//  HealthHubExample
//

import SwiftUI
import HealthHub

struct DashboardExampleView: View {
    let store: Store

    @State private var dashboard: HealthDashboard?
    @State private var isLoading = false
    @State private var error: String?

    var body: some View {
        List {
            if isLoading {
                ProgressView()
            } else if let dashboard {
                Section("Today") {
                    row("Steps", dashboard.stepCount.map(String.init) ?? "No data")
                    row("Active Energy", dashboard.activeEnergyKilocalories.map { "\(Int($0)) kcal" } ?? "No data")
                    row("Average Heart Rate", dashboard.averageHeartRate.map { "\(Int($0)) BPM" } ?? "No data")
                    row("Workouts", String(dashboard.workoutCount))
                    row("Sleep", Duration.seconds(dashboard.sleepDuration).formatted(.units(allowed: [.hours, .minutes])))
                }
            }

            if let error {
                Section("Error") {
                    Text(error)
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Dashboard")
        .task {
            isLoading = true
            defer { isLoading = false }

            do {
                dashboard = try await store.health.dashboard()
            } catch {
                self.error = error.localizedDescription
            }
        }
    }

    private func row(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
    }
}
