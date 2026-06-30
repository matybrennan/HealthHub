//
//  StepsExampleView.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 30/6/2026.
//

import SwiftUI
import HealthHub

struct StepsExampleView: View {
    let store: Store

    @State private var isLoading = false
    @State private var error: String?

    var body: some View {
        List {
            Section("Today") {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Total: \(store.manager.activityManager.steps.today.total) steps")
                    if let peak = store.manager.activityManager.steps.today.peakInterval {
                        Text("Peak: \(peak.count) steps")
                    }
                }
            }

            if let error {
                Section("Error") {
                    Text(error).foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Steps")
        .task {
            isLoading = true
            do {
                try await store.manager.activityManager.steps.steps(fromStepsType: .today())
            } catch {
                self.error = error.localizedDescription
            }
            isLoading = false
        }
    }
}
