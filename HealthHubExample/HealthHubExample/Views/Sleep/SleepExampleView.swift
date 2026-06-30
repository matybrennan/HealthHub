//
//  SleepExampleView.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 30/6/2026.
//

import SwiftUI
import HealthHub

struct SleepExampleView: View {
    let store: Store

    @State private var sleep: Sleep?
    @State private var error: String?

    var body: some View {
        List {
            if let sleep {
                Section("Summary") {
                    Text("Total Sleep: \(String(format: "%.1f", sleep.totalSleepDuration / 3600)) hrs")
                    Text("In Bed: \(String(format: "%.1f", sleep.totalInBedDuration / 3600)) hrs")
                    Text("Efficiency: \(Int(sleep.sleepEfficiency * 100))%")
                }

                Section("Stages") {
                    Text("Core: \(String(format: "%.0f", sleep.coreSleepDuration / 60)) min")
                    Text("Deep: \(String(format: "%.0f", sleep.deepSleepDuration / 60)) min")
                    Text("REM: \(String(format: "%.0f", sleep.remSleepDuration / 60)) min")
                }

                Section("Sessions") {
                    let sessions = sleep.sessions()
                    Text("\(sessions.count) sleep session(s)")
                }
            }

            if let error {
                Section("Error") {
                    Text(error).foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Sleep")
        .task {
            do {
                sleep = try await store.manager.sleep.sleep()
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
