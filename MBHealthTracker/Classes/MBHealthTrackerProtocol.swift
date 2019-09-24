//
//  MBHealthTrackerProtocol.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit

public protocol MBHealthTrackerProtocol {
    
    var configuration: ConfigurationServiceProtocol { get }
    
    var heartRate: HeartRateServiceProtocol { get }
    
    var steps: StepsServiceProtocol { get }
    
    var workout: WorkoutManagerProtocol { get }
    
    var characteristics: CharacteristicServiceProtocol { get }
    
    var nutritionService: NutritionServiceProtocol { get }
    
    var activeEnergy: ActiveEnergyServiceProtocol { get }
    
    var sleep: SleepServiceProtocol { get }
    
    var body: BodyServiceProtocol { get }
    
    var mindful: MindfulnessServiceProtocol { get }
}
