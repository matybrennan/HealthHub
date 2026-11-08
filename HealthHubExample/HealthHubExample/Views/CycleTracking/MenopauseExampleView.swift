//
//  MenopauseExampleView.swift
//  HealthHubExample
//

import SwiftUI
import HealthHub

struct MenopauseExampleView: View {
    let store: Store

    @State private var state: MenopausalState?
    @State private var bleeding: BleedingAfterMenopause?
    @State private var isLoading = false
    @State private var error: String?

    var body: some View {
        List {
            if #available(iOS 27.0, *) {
                if isLoading {
                    ProgressView()
                } else {
                    stateSection
                    bleedingSection
                }
            } else {
                ContentUnavailableView("Requires iOS 27", systemImage: "iphone", description: Text("Menopause tracking is available on iOS 27 and later."))
            }

            if let error {
                Section("Error") {
                    Text(error)
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Menopause")
        .task {
            guard #available(iOS 27.0, *) else { return }

            isLoading = true
            defer { isLoading = false }

            do {
                state = try await store.manager.cycleTracking.menopausalState()
                bleeding = try await store.manager.cycleTracking.bleedingAfterMenopause()
            } catch {
                self.error = error.localizedDescription
            }
        }
    }

    @ViewBuilder
    private var stateSection: some View {
        if let latest = state?.mostRecent {
            Section("Menopausal State") {
                Text(latest.state.name)
                Text(latest.endDate.formatted(date: .abbreviated, time: .omitted))
                    .foregroundStyle(.secondary)
            }
        } else if error == nil {
            ContentUnavailableView("No Menopausal State", systemImage: "calendar.badge.heart", description: Text("No menopausal state entries are available."))
        }
    }

    @ViewBuilder
    private var bleedingSection: some View {
        if let bleeding, !bleeding.items.isEmpty {
            Section("Bleeding After Menopause") {
                Text("Entries: \(bleeding.items.count)")
                if let latest = bleeding.mostRecent {
                    Text("Most Recent: \(latest.type.name)")
                    Text(latest.endDate.formatted(date: .abbreviated, time: .omitted))
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}
