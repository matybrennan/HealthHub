//
//  ActiveEnergyModels.swift
//  HealthHub
//
//  Created by matybrennan on 27/11/18.
//

import Foundation

public struct ActiveEnergy: Sendable {
    public let calories: Double

    public init(calories: Double) {
        self.calories = calories
    }
}
