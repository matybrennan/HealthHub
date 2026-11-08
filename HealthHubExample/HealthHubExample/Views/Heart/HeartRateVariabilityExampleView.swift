//
//  HeartRateVariabilityExampleView.swift
//  HealthHubExample
//

import SwiftUI
import HealthHub

struct HeartRateVariabilityExampleView: View {
    let store: Store

    @State private var rmssd: HeartRateVariabilityRMSSD?
    @State private var isLoading = false
    @State private var error: String?

    var body: some View {
        List {
            if #available(iOS 27.0, *) {
                if isLoading {
                    ProgressView()
                } else if let rmssd, !rmssd.items.isEmpty {
                    Section("RMSSD") {
                        Text("Average: \(String(format: "%.1f", rmssd.averageRMSSD)) ms")
                        if let recent = rmssd.mostRecent {
                            Text("Most Recent: \(String(format: "%.1f", recent.rmssd)) ms")
                            Text(recent.date.formatted(date: .abbreviated, time: .shortened))
                                .foregroundStyle(.secondary)
                        }
                        Text("Readings: \(rmssd.items.count)")
                    }
                } else if error == nil {
                    ContentUnavailableView("No RMSSD Readings", systemImage: "waveform.path.ecg", description: Text("No RMSSD heart-rate variability readings are available."))
                }
            } else {
                ContentUnavailableView("Requires iOS 27", systemImage: "iphone", description: Text("RMSSD heart-rate variability is available on iOS 27 and later."))
            }

            if let error {
                Section("Error") {
                    Text(error)
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Heart Rate Variability")
        .task {
            guard #available(iOS 27.0, *) else { return }

            isLoading = true
            defer { isLoading = false }

            do {
                rmssd = try await store.manager.heartManager.heartRateVariabilityRMSSD()
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
