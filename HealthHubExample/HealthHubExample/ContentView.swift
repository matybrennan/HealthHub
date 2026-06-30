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

    var body: some View {
        NavigationStack {
            List {
                Section("Configuration") {
                    HStack {
                        Text("HealthKit Available")
                        Spacer()
                        Image(systemName: store.manager.configuration.isHealthDataAvailable ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundStyle(store.manager.configuration.isHealthDataAvailable ? .green : .red)
                    }

                    Button("Request Authorization") {
                        Task {
                            try? await store.manager.configuration.requestAuthorization(
                                toShare: [.stepCount, .workout, .heartRate, .weight, .activeEnergy],
                                toRead: [.stepCount, .workout, .heartRate, .weight, .activeEnergy, .sleepAnalysis]
                            )
                        }
                    }
                }

                Section("Activity") {
                    NavigationLink("Steps") {
                        StepsExampleView(store: store)
                    }
                    NavigationLink("Active Energy") {
                        ActiveEnergyExampleView(store: store)
                    }
                    NavigationLink("Workouts") {
                        WorkoutsExampleView(store: store)
                    }
                }

                Section("Heart") {
                    NavigationLink("Heart Rate") {
                        HeartRateExampleView(store: store)
                    }
                }

                Section("Body Measurements") {
                    NavigationLink("Weight") {
                        WeightExampleView(store: store)
                    }
                }

                Section("Sleep") {
                    NavigationLink("Sleep Analysis") {
                        SleepExampleView(store: store)
                    }
                }

                Section("Characteristics") {
                    NavigationLink("User Profile") {
                        CharacteristicsExampleView(store: store)
                    }
                }
            }
            .navigationTitle("HealthHub Example")
        }
    }
}

#Preview {
    ContentView()
}
