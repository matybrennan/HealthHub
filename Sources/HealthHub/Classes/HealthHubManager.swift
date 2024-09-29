//
//  HealthHubManager.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import Combine

public final class HealthHubManager: ObservableObject, @unchecked Sendable {

    public lazy var healthHandler = HealthHandler()

    public init() { }

    private lazy var privateConfiguration = ConfigurationService(handler: healthHandler, healthStore: healthStore)
    private lazy var privateActivityManager = ActivityManager()
    private lazy var privateHeartManager = HeartManager()
    private lazy var privateCharacteristicsService = CharacteristicService()
    private lazy var privateMobilityService = MobilityService()
    private lazy var privateNutritionService = NutritionService()
    private lazy var privateSleepService = SleepService()
    private lazy var privateBodyMeasurementsService = BodyMeasurementsService()
    private lazy var privateMindfulService = MentalWellbeingService()
    private lazy var privateCycleTrackingService = CycleTracking()
    private lazy var privateSymptomsService = SymptomsService()
    private lazy var privateRespiratoryService = RespiratoryService()
    private lazy var privateVitalsService = VitalsService()
    private lazy var privateOtherDataService = OtherDataService()
}


extension HealthHubManager: HealthHubManagerProtocol {
    
    public var configuration: ConfigurationServiceProtocol {
        privateConfiguration
    }
    
    public var activityManager: ActivityManagerProtocol {
        privateActivityManager
    }
    
    public var heartManager: HeartManagerProtocol {
        privateHeartManager
    }
    
    public var characteristics: CharacteristicServiceProtocol {
        privateCharacteristicsService
    }

    public var mobility: MobilityServiceProtocol {
        privateMobilityService
    }

    public var nutrition: NutritionServiceProtocol {
        privateNutritionService
    }
    
    public var sleep: SleepServiceProtocol {
        privateSleepService
    }
    
    public var bodyMeasurements: BodyMeasurementsServiceProtocol {
        privateBodyMeasurementsService
    }
    
    public var mindful: MentalWellbeingServiceProtocol {
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
