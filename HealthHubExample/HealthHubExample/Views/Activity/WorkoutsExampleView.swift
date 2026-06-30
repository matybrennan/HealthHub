//
//  WorkoutsExampleView.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 30/6/2026.
//

import SwiftUI
import HealthHub

struct WorkoutsExampleView: View {
    let store: Store

    @State private var workouts: Workout?
    @State private var error: String?

    var body: some View {
        List {
            if let workouts {
                Section("This Week (\(workouts.items.count) workouts)") {
                    ForEach(workouts.items.prefix(10), id: \.startDate) { item in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.activityType.name)
                                .font(.headline)
                            HStack {
                                Text(item.durationFormatted)
                                Spacer()
                                Text("\(String(format: "%.0f", item.energyBurned)) kcal")
                            }
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 2)
                    }
                }
            }

            if let error {
                Section("Error") {
                    Text(error).foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Workouts")
        .task {
            do {
                workouts = try await store.manager.activityManager.workout.workouts(fromWorkoutType: .thisWeek)
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
