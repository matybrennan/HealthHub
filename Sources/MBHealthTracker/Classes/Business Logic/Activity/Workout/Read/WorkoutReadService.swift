//
//  WorkoutReadService.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation
import HealthKit

public final class WorkoutReadService {
    
    @MainActor
    struct Unit {
        static let workoutEnergy = HKUnit.smallCalorie()
        static let workoutDistance = HKUnit.meter()
    }
    
    public init() { }
}

// MARK: - FetchWorkoutSample
extension WorkoutReadService: FetchWorkoutSample { }

// MARK: - WorkoutReadServiceProtocol
extension WorkoutReadService: WorkoutReadServiceProtocol {
    
    public func workouts(fromWorkoutType type: WorkoutType) async throws -> MBWorkout {
        
        var pred: NSPredicate?
        
        switch type {
        case .today:
            pred = try NSPredicate.today()
        case .thisWeek:
            pred = try NSPredicate.thisWeek()
        case .all:
            pred = nil
        }
        let samples = try await fetchWorkoutSamples(workoutIdentifier: .workoutType(), predicate: pred, sortDescriptors: [], limit: nil)
        let workoutItems = samples.map {
            MBWorkout.Item(duration: $0.duration, energyBurned: $0.totalEnergyBurned?.doubleValue(for: Unit.workoutEnergy) ?? 0, distance: $0.totalDistance?.doubleValue(for: Unit.workoutDistance) ?? 0, startDate: $0.startDate, endDate: $0.endDate, activityType: $0.workoutActivityType)
        }
        
        let workout = MBWorkout(items: workoutItems)
        return workout
    }
}
