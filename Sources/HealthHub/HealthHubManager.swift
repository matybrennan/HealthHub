//
//  HealthHubManager.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import Combine

public final class HealthHubManager {

    private let configurationService: ConfigurationServiceProtocol
    private let activityManagerService: ActivityManagerProtocol
    private let heartManagerService: HeartManagerProtocol
    private let characteristicsService: CharacteristicServiceProtocol
    private let mobilityService: MobilityServiceProtocol
    private let nutritionService: NutritionServiceProtocol
    private let sleepService: SleepServiceProtocol
    private let bodyMeasurementsService: BodyMeasurementsServiceProtocol
    private let mindfulService: MentalWellbeingServiceProtocol
    private let cycleTrackingService: CycleTrackingProtocol
    private let symptomsService: SymptomsServiceProtocol
    private let respiratoryService: RespiratoryServiceProtocol
    private let vitalsService: VitalsServiceProtocol
    private let otherDataService: OtherDataServiceProtocol
    private let hearingService: HearingServiceProtocol

    public init(
        configuration: ConfigurationServiceProtocol,
        activityManager: ActivityManagerProtocol,
        heartManager: HeartManagerProtocol,
        characteristics: CharacteristicServiceProtocol,
        mobility: MobilityServiceProtocol,
        nutrition: NutritionServiceProtocol,
        sleep: SleepServiceProtocol,
        bodyMeasurements: BodyMeasurementsServiceProtocol,
        mindful: MentalWellbeingServiceProtocol,
        cycleTracking: CycleTrackingProtocol,
        symptoms: SymptomsServiceProtocol,
        respiratory: RespiratoryServiceProtocol,
        vitals: VitalsServiceProtocol,
        otherData: OtherDataServiceProtocol,
        hearing: HearingServiceProtocol
    ) {
        self.configurationService = configuration
        self.activityManagerService = activityManager
        self.heartManagerService = heartManager
        self.characteristicsService = characteristics
        self.mobilityService = mobility
        self.nutritionService = nutrition
        self.sleepService = sleep
        self.bodyMeasurementsService = bodyMeasurements
        self.mindfulService = mindful
        self.cycleTrackingService = cycleTracking
        self.symptomsService = symptoms
        self.respiratoryService = respiratory
        self.vitalsService = vitals
        self.otherDataService = otherData
        self.hearingService = hearing
    }

    public convenience init() {
        self.init(
            configuration: ConfigurationService(healthStore: HealthStoreProvider.shared),
            activityManager: ActivityManager(),
            heartManager: HeartManager(),
            characteristics: CharacteristicService(),
            mobility: MobilityService(),
            nutrition: NutritionService(),
            sleep: SleepService(),
            bodyMeasurements: BodyMeasurementsService(),
            mindful: MentalWellbeingService(),
            cycleTracking: CycleTracking(),
            symptoms: SymptomsService(),
            respiratory: RespiratoryService(),
            vitals: VitalsService(),
            otherData: OtherDataService(),
            hearing: HearingService()
        )
    }
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
    public var hearing: HearingServiceProtocol { hearingService }
}
