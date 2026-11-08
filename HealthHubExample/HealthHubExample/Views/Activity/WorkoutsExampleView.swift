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
    @State private var preferredZones: WorkoutZoneConfiguration?
    @State private var error: String?

    var body: some View {
        VStack {
            if let workouts {
                List {
                    if let preferredZones {
                        Section("Your heart rate zones") {
                            Text(preferredZones.summary)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Section("This week") {
                        ForEach(Array(workouts.items.prefix(10)), id: \.startDate) { item in
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

                                // Time in each zone is filled in by HealthKit for workouts with heart rate data.
                                if let zones = item.heartRateZones, zones.totalDuration > 0 {
                                    ZoneBreakdownView(group: zones)
                                }
                            }
                            .padding(.vertical, 2)
                        }
                    }
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
                preferredZones = try await store.health.preferredWorkoutZoneConfiguration(for: .heartRate)
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}

/// A bar showing how a workout's time splits across zones, with the longest zone named below it.
private struct ZoneBreakdownView: View {
    let group: WorkoutZoneGroup

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            GeometryReader { proxy in
                HStack(spacing: 1) {
                    ForEach(group.timeInZones, id: \.zone.index) { entry in
                        Rectangle()
                            .fill(color(for: entry.zone.index))
                            .frame(width: proxy.size.width * entry.duration / group.totalDuration)
                    }
                }
            }
            .frame(height: 8)
            .clipShape(Capsule())

            if let longest = group.timeInZones.max(by: { $0.duration < $1.duration }) {
                Text("Mostly zone \(longest.zone.index + 1), \(Int(longest.duration / 60)) min")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    /// Green for the lowest zone through red for the highest.
    private func color(for index: Int) -> Color {
        let lastIndex = max(group.timeInZones.count - 1, 1)
        return Color(hue: 0.33 * (1 - Double(index) / Double(lastIndex)), saturation: 0.8, brightness: 0.9)
    }
}

private extension WorkoutZoneConfiguration {

    /// For example `Z1 <120 · Z2 120-140 · Z3 140+`, in the metric's unit.
    var summary: String {
        let ranges = zones.map { zone in
            switch (zone.minimum, zone.maximum) {
            case let (minimum?, maximum?): "Z\(zone.index + 1) \(Int(minimum))-\(Int(maximum))"
            case let (nil, maximum?): "Z\(zone.index + 1) <\(Int(maximum))"
            case let (minimum?, nil): "Z\(zone.index + 1) \(Int(minimum))+"
            case (nil, nil): "Z\(zone.index + 1)"
            }
        }
        return ranges.joined(separator: " · ") + " \(metric.unit)"
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
