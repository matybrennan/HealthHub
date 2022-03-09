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
        ConfigurationService()
    }()
    
    private lazy var privateActivityManager: ActivityManagerProtocol = {
        ActivityManager()
    }()
    
    private lazy var privateHeart: HeartServiceProtocol = {
        HeartService()
    }()
    
    private lazy var privateCharacteristicsService: CharacteristicServiceProtocol = {
        CharacteristicService()
    }()
    
    private lazy var privateNutritionService: NutritionServiceProtocol = {
        NutritionService()
    }()
    
    private lazy var privateSleepService: SleepServiceProtocol = {
        SleepService()
    }()
    
    private lazy var privateBodyService: BodyServiceProtocol = {
        BodyService()
    }()
    
    private lazy var privateMindfulService: MindfulnessServiceProtocol = {
        MindfulnessService()
    }()
    
    private lazy var privateCycleTrackingService: CycleTrackingProtocol = {
        CycleTracking()
    }()
    
    private lazy var privateSymptomsService: SymptomsServiceProtocol = {
        SymptomsService()
    }()
    
    public lazy var privateRespiratoryService: RespiratoryServiceProtocol = {
        RespiratoryService()
    }()
    
    public lazy var privateVitalsService: VitalsServiceProtocol = {
        VitalsService()
    }()
    
    public lazy var privateOtherDataService: OtherDataServiceProtocol = {
        OtherDataService()
    }()
}

extension MBHealthTracker: MBHealthTrackerProtocol {
    
    public var configuration: ConfigurationServiceProtocol {
        privateConfiguration
    }
    
    public var activityManager: ActivityManagerProtocol {
        privateActivityManager
    }
    
    public var heart: HeartServiceProtocol {
        privateHeart
    }
    
    public var characteristics: CharacteristicServiceProtocol {
        privateCharacteristicsService
    }
    
    public var nutrition: NutritionServiceProtocol {
        privateNutritionService
    }
    
    public var sleep: SleepServiceProtocol {
        privateSleepService
    }
    
    public var body: BodyServiceProtocol {
        privateBodyService
    }
    
    public var mindful: MindfulnessServiceProtocol {
        privateMindfulService
    }
    
    public var cycleTracking: CycleTrackingProtocol {
        privateCycleTrackingService
    }
    
    public var symptoms: SymptomsServiceProtocol {
        privateSymptomsService
    }
    
    public var respiratory: RespiratoryServiceProtocol {
        privateRespiratoryService
    }
    
    public var vitals: VitalsServiceProtocol {
        privateVitalsService
    }
    
    public var otherData: OtherDataServiceProtocol {
        privateOtherDataService
    }
}
