//
//  WeightExampleView.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 30/6/2026.
//

import SwiftUI
import HealthHub

struct WeightExampleView: View {
    let store: Store

    @State private var weight: BodyWeight?
    @State private var error: String?

    var body: some View {
        List {
            if let weight {
                Section("Recent Entries") {
                    if let recent = weight.mostRecent {
                        Text("Latest: \(String(format: "%.1f", recent.kg)) kg (\(String(format: "%.1f", recent.lbs)) lbs)")
                    }
                    Text("Total entries: \(weight.items.count)")
                }

                Section("With Date Range") {
                    Text("Use `.thisMonth` or `.lastNDays(30)` to filter")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            if let error {
                Section("Error") {
                    Text(error).foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Weight")
        .task {
            do {
                // Demonstrates DateRangeType filtering
                weight = try await store.manager.bodyMeasurements.weight(from: .thisMonth)
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
