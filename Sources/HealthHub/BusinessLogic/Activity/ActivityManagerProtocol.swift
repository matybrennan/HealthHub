//
//  ActivityManagerProtocol.swift
//  HealthHub
//
//  Created by matybrennan on 9/10/19.
//

import Foundation

public protocol ActivityManagerProtocol {
    var activeEnergy: ActiveEnergyServiceProtocol { get }
    var steps: StepsServiceProtocol { get }
    var workout: WorkoutManagerProtocol { get }
    var activity: ActivityServiceProtocol { get }
}
