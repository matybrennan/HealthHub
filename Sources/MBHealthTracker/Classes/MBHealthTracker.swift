//
//  MBHealthTracker.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import Combine

@MainActor
final class MBHealthTracker: ObservableObject, Sendable {

    public lazy var mbHealthHandler = MBHealthHandler()
    
    nonisolated public init() { }

    private lazy var privateConfiguration = ConfigurationService(handler: mbHealthHandler)
    private lazy var privateActivityManager = ActivityManager()
    private lazy var privateHeart = HeartService()
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
