//
//  MBHealthTracker.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation

open class MBHealthTracker {
    
    public init() { }
    
    private lazy var privateConfiguration: ConfigurationServiceProtocol = {
        return ConfigurationService()
    }()
    
    private lazy var privateActivityManager: ActivityManagerProtocol = {
        return ActivityManager()
    }()
    
    private lazy var privateHeartRate: HeartRateServiceProtocol = {
        return HeartRateService()
    }()
    
    private lazy var privateCharacteristicsService: CharacteristicServiceProtocol = {
        return CharacteristicService()
    }()
    
    private lazy var privateNutritionService: NutritionServiceProtocol = {
        return NutritionService()
    }()
    
    private lazy var privateSleepService: SleepServiceProtocol = {
        return SleepService()
    }()
    
    private lazy var privateBodyService: BodyServiceProtocol = {
        return BodyService()
    }()
    
    private lazy var privateMindfulService: MindfulnessServiceProtocol = {
        return MindfulnessService()
    }()
    
    private lazy var privateCycleTrackingService: CycleTrackingProtocol = {
        CycleTracking()
    }()
    
    public lazy var privateVitalsService: VitalsServiceProtocol = {
        VitalsService()
    }()
}

extension MBHealthTracker: MBHealthTrackerProtocol {
    
    /// Handles logic for permissions, navigation to health app
    public var configuration: ConfigurationServiceProtocol {
        return privateConfiguration
    }
    
    public var activityManager: ActivityManagerProtocol {
        return privateActivityManager
    }
    
    /// handles gathering logic from healthKit regarding heartRate details
    public var heartRate: HeartRateServiceProtocol {
        return privateHeartRate
    }
    
    /// handles gathering personal information about user
    public var characteristics: CharacteristicServiceProtocol {
        return privateCharacteristicsService
    }
    
    /// handles gathering logic about any nutrition info from healthstore
    public var nutritionService: NutritionServiceProtocol {
        return privateNutritionService
    }
    
    public var sleep: SleepServiceProtocol {
        return privateSleepService
    }
    
    public var body: BodyServiceProtocol {
        return privateBodyService
    }
    
    public var mindful: MindfulnessServiceProtocol {
        return privateMindfulService
    }
    
    public var cycleTracking: CycleTrackingProtocol {
        return privateCycleTrackingService
    }
    
    public var vitals: VitalsServiceProtocol {
        return privateVitalsService
    }
}
