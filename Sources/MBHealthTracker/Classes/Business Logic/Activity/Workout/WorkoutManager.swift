//
//  WorkoutManager.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/17/18.
//

import Foundation
import HealthKit

public class WorkoutManager {
    
    private let workoutReadService: WorkoutReadServiceProtocol
    private let workoutWriteService: WorkoutWriteServiceProtocol
    
    public init(readService: WorkoutReadServiceProtocol, writeService: WorkoutWriteServiceProtocol) {
        workoutReadService = readService
        workoutWriteService = writeService
    }
}

extension WorkoutManager: WorkoutManagerProtocol {
    
    // MARK: Read Service
    
    public func workouts(fromWorkoutType type: WorkoutType) async throws -> MBWorkout {
        try await workoutReadService.workouts(fromWorkoutType: type)
    }
    
    
    // MARK: Write Service
    
    public func saveWorkout(workout: MBWorkout.Item, extra: [String : Any]?) async throws {
        try await workoutWriteService.saveWorkout(workout: workout, extra: extra)
    }
}
