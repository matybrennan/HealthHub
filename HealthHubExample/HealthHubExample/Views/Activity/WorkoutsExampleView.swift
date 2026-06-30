//
//  WorkoutsExampleView.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 30/6/2026.
//

import SwiftUI
import HealthKit
import HealthHub

struct WorkoutsExampleView: View {
    let store: Store

    @State private var workouts: Workout?
    @State private var error: String?

    var body: some View {
        VStack {
            if let workouts {
                List(Array(workouts.items.prefix(10)), id: \.startDate) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.activityType.commonName)
                            .font(.headline)
                        HStack {
                            Text(item.durationFormatted)
                            Spacer()
                            if let energyBurned = item.energyBurned {
                                Text("\(String(format: "%.0f", energyBurned)) kcal")
                            }
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 2)
                }
            }

            if let error {
                Text(error)
                    .foregroundStyle(.red)
                    .padding()
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

extension HKWorkoutActivityType {
    var commonName: String {
        switch self {
        case .running: "Running"
        case .cycling: "Cycling"
        case .walking: "Walking"
        case .swimming: "Swimming"
        case .yoga: "Yoga"
        case .functionalStrengthTraining: "Strength Training"
        case .highIntensityIntervalTraining: "HIIT"
        case .hiking: "Hiking"
        case .dance: "Dance"
        case .cooldown: "Cooldown"
        default: "Workout"
        }
    }
}
