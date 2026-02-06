//
//  HealthHubManager.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import Combine

public final class HealthHubManager {

    public init() { }

    private lazy var configurationService = ConfigurationService(healthStore: HealthStoreProvider.shared)
    private lazy var activityManagerService = ActivityManager()
    private lazy var heartManagerService = HeartManager()
    private lazy var characteristicsService = CharacteristicService()
    private lazy var mobilityService = MobilityService()
    private lazy var nutritionService = NutritionService()
    private lazy var sleepService = SleepService()
    private lazy var bodyMeasurementsService = BodyMeasurementsService()
    private lazy var mindfulService = MentalWellbeingService()
    private lazy var cycleTrackingService = CycleTracking()
    private lazy var symptomsService = SymptomsService()
    private lazy var respiratoryService = RespiratoryService()
    private lazy var vitalsService = VitalsService()
    private lazy var otherDataService = OtherDataService()
}


extension HealthHubManager: HealthHubManagerProtocol {
    
    public var configuration: ConfigurationServiceProtocol { configurationService }
    public var activityManager: ActivityManagerProtocol { activityManagerService }
    public var heartManager: HeartManagerProtocol { heartManagerService }
    public var characteristics: CharacteristicServiceProtocol { characteristicsService }
    public var mobility: MobilityServiceProtocol { mobilityService }
    public var nutrition: NutritionServiceProtocol { nutritionService }
    public var sleep: SleepServiceProtocol { sleepService }
    public var bodyMeasurements: BodyMeasurementsServiceProtocol { bodyMeasurementsService }
    public var mindful: MentalWellbeingServiceProtocol { mindfulService }
    public var cycleTracking: CycleTrackingProtocol { cycleTrackingService }
    public var symptoms: SymptomsServiceProtocol { symptomsService }
    public var respiratory: RespiratoryServiceProtocol { respiratoryService }
    public var vitals: VitalsServiceProtocol { vitalsService }
    public var otherData: OtherDataServiceProtocol { otherDataService }
}
