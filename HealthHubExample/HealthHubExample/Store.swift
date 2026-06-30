//
//  Store.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 29/9/2024.
//

import Foundation
import HealthHub

/// A simple observable store that demonstrates how to use HealthHubManager
/// with SwiftUI. In a real app, you'd inject this as an environment object
/// or use a more structured architecture (MVVM, TCA, etc.)
@MainActor
@Observable
final class Store {

    let manager: HealthHubManager

    init(manager: HealthHubManager) {
        self.manager = manager
    }

    // MARK: - Example: Fetching multiple data types

    /// Shows how to fetch data from multiple services
    func fetchDashboard() async {
        do {
            // Activity
            try await manager.activityManager.steps.steps(fromStepsType: .today())
            let energy = try await manager.activityManager.activeEnergy.activeEnergy(from: .today)
            print("Today's energy: \(energy.totalCalories) kcal")

            // Heart - uses @Observable so views update automatically
            try await manager.heartManager.heartRate.heartRate(fromHeartRateType: .today(timeInterval: 60))

            // Body - with new DateRangeType filtering
            let weight = try await manager.bodyMeasurements.weight(from: .lastNDays(30))
            if let latest = weight.mostRecent {
                print("Latest weight: \(latest.kg) kg")
            }

            // Sleep
            let sleep = try await manager.sleep.sleep()
            print("Sleep efficiency: \(Int(sleep.sleepEfficiency * 100))%")

        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    // MARK: - Example: Saving data

    /// Shows how to save a workout
    func saveExampleWorkout() async {
        do {
            let item = Workout.Item(
                duration: 1800,
                energyBurned: 250,
                startDate: Date().addingTimeInterval(-1800),
                endDate: Date(),
                activityType: .running
            )
            try await manager.activityManager.workout.saveWorkout(
                workout: item,
                events: nil,
                routeLocations: nil,
                heartRateSamples: nil,
                extra: nil
            )
            print("Workout saved!")
        } catch {
            print("Save error: \(error.localizedDescription)")
        }
    }

    // MARK: - Example: Using individual services directly

    /// Shows dependency injection with individual services
    func demonstrateDI() async {
        // You can use services directly without the full manager
        let heartManager = HeartManager()
        do {
            let hrv = try await heartManager.heartRateVariability()
            print("HRV (SDNN): \(hrv.averageSDNN) ms")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
