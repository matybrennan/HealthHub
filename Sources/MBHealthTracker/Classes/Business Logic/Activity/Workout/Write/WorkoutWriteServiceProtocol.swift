//
//  WorkoutWriteServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 2/19/18.
//

import Foundation

public protocol WorkoutWriteServiceProtocol: Sendable {
    func saveWorkout(workout: MBWorkout.Item, extra: [String: Sendable]?) async throws
}
