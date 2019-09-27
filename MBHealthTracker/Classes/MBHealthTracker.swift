//
//  MBHealthTracker.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import HealthKit

open class MBHealthTracker {
    
    public init() { }
    
    lazy var privateConfiguration: ConfigurationServiceProtocol = {
        return ConfigurationService()
    }()
    
    lazy var privateHeartRate: HeartRateServiceProtocol = {
        return HeartRateService()
    }()
    
    lazy var privateSteps: StepsServiceProtocol = {
        return StepsService()
    }()
    
    lazy var privateWorkoutReadService: WorkoutReadServiceProtocol = {
        return WorkoutReadService()
    }()
    
    lazy var privateWorkoutWriteService: WorkoutWriteServiceProtocol = {
        return WorkoutWriteService()
    }()
    
    lazy var privateWorkout: WorkoutManagerProtocol = {
        return WorkoutManager(readService: self.privateWorkoutReadService, writeService: self.privateWorkoutWriteService)
    }()
    
    lazy var privateCharacteristicsService: CharacteristicServiceProtocol = {
        return CharacteristicService()
    }()
    
    lazy var privateNutritionService: NutritionServiceProtocol = {
        return NutritionService()
    }()
    
    lazy var activeEnergyService: ActiveEnergyServiceProtocol = {
        return ActiveEnergyService()
    }()
    
    lazy var sleepService: SleepServiceProtocol = {
        return SleepService()
    }()
    
    lazy var bodyService: BodyServiceProtocol = {
        return BodyService()
    }()
    
    lazy var mindfulService: MindfulnessServiceProtocol = {
        return MindfulnessService()
    }()
    
    lazy var reproductiveService: ReproductiveServiceProtocol = {
        ReproductiveService()
    }()
}

extension MBHealthTracker: MBHealthTrackerProtocol {
    
    /// Handles logic for permissions, navigation to health app
    public var configuration: ConfigurationServiceProtocol {
        return privateConfiguration
    }
    
    /// handles gathering logic from healthKit regarding heartRate details
    public var heartRate: HeartRateServiceProtocol {
        return privateHeartRate
    }
    
    /// handles gathering logic from healthKit regarding stepCount details
    public var steps: StepsServiceProtocol {
        return privateSteps
    }
    
    /// handles gathering logic from healthKit regarding workouts
    public var workout: WorkoutManagerProtocol {
        return privateWorkout
    }
    
    /// handles gathering personal information about user
    public var characteristics: CharacteristicServiceProtocol {
        return privateCharacteristicsService
    }
    
    /// handles gathering logic about any nutrition info from healthstore
    public var nutritionService: NutritionServiceProtocol {
        return privateNutritionService
    }
    
    /// handles gathering logic about active energy burned from healthstore
    public var activeEnergy: ActiveEnergyServiceProtocol {
        return activeEnergyService
    }
    
    public var sleep: SleepServiceProtocol {
        return sleepService
    }
    
    public var body: BodyServiceProtocol {
        return bodyService
    }
    
    public var mindful: MindfulnessServiceProtocol {
        return mindfulService
    }
    
    public var reproductive: ReproductiveServiceProtocol {
        return reproductiveService
    }
}
