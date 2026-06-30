//
//  ContentView.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 29/9/2024.
//

import SwiftUI
import HealthHub

struct ContentView: View {

    @State private var store = Store(manager: HealthHubManager())
    @State private var selectedItem: SidebarItem?

    var body: some View {
        NavigationSplitView {
            sidebar
                .navigationTitle("HealthHub")
        } detail: {
            if let selectedItem {
                detailView(for: selectedItem)
            } else {
                ContentUnavailableView("Select an item", systemImage: "heart.text.square", description: Text("Choose a category from the sidebar"))
            }
        }
    }

    private var sidebar: some View {
        List(selection: $selectedItem) {
            Section("Configuration") {
                Label("Setup", systemImage: "gear")
                    .tag(SidebarItem.configuration)
            }

            Section("Activity") {
                Label("Steps", systemImage: "figure.walk")
                    .tag(SidebarItem.steps)
                Label("Active Energy", systemImage: "flame")
                    .tag(SidebarItem.activeEnergy)
                Label("Workouts", systemImage: "figure.run")
                    .tag(SidebarItem.workouts)
            }

            Section("Heart") {
                Label("Heart Rate", systemImage: "heart")
                    .tag(SidebarItem.heartRate)
            }

            Section("Body Measurements") {
                Label("Weight", systemImage: "scalemass")
                    .tag(SidebarItem.weight)
            }

            Section("Sleep") {
                Label("Sleep Analysis", systemImage: "bed.double")
                    .tag(SidebarItem.sleep)
            }

            Section("Characteristics") {
                Label("User Profile", systemImage: "person")
                    .tag(SidebarItem.characteristics)
            }
        }
    }

    @ViewBuilder
    private func detailView(for item: SidebarItem) -> some View {
        switch item {
        case .configuration:
            ConfigurationView(store: store)
        case .steps:
            StepsExampleView(store: store)
        case .activeEnergy:
            ActiveEnergyExampleView(store: store)
        case .workouts:
            WorkoutsExampleView(store: store)
        case .heartRate:
            HeartRateExampleView(store: store)
        case .weight:
            WeightExampleView(store: store)
        case .sleep:
            SleepExampleView(store: store)
        case .characteristics:
            CharacteristicsExampleView(store: store)
        }
    }
}

enum SidebarItem: Hashable {
    case configuration
    case steps, activeEnergy, workouts
    case heartRate
    case weight
    case sleep
    case characteristics
}

#Preview {
    ContentView()
}
