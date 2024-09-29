//
//  HealthHubManagerProtocol.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation

public protocol HealthHubManagerProtocol: Sendable {

    var configuration: ConfigurationServiceProtocol { get }
    
    var activityManager: ActivityManagerProtocol { get }
    
    var heartManager: HeartManagerProtocol { get }
    
    var characteristics: CharacteristicServiceProtocol { get }
    
    var mobility: MobilityServiceProtocol { get }

    var nutrition: NutritionServiceProtocol { get }
    
    var sleep: SleepServiceProtocol { get }
    
    var bodyMeasurements: BodyMeasurementsServiceProtocol { get }
    
    var mindful: MentalWellbeingServiceProtocol { get }
    
    var cycleTracking: CycleTrackingProtocol { get }
    
    var symptoms: SymptomsServiceProtocol { get }
    
    var respiratory: RespiratoryServiceProtocol { get }
    
    var vitals: VitalsServiceProtocol { get }
    
    var otherData: OtherDataServiceProtocol { get }
}
