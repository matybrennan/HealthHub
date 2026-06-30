//
//  ActiveEnergyExampleView.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 30/6/2026.
//

import SwiftUI
import HealthHub

struct ActiveEnergyExampleView: View {
    let store: Store

    @State private var energy: ActiveEnergy?
    @State private var error: String?

    var body: some View {
        List {
            if let energy {
                Section("Today") {
                    Text("Total: \(String(format: "%.0f", energy.totalCalories)) kcal")
                    if let recent = energy.mostRecent {
                        Text("Most Recent: \(String(format: "%.0f", recent.calories)) kcal")
                    }
                }
            }

            if let error {
                Section("Error") {
                    Text(error).foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Active Energy")
        .task {
            do {
                energy = try await store.manager.activityManager.activeEnergy.activeEnergy(from: .today)
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
