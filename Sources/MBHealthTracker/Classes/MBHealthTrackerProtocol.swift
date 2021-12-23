//
//  MBHealthTrackerProtocol.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation

public protocol MBHealthTrackerProtocol: AnyObject {
    
    var configuration: ConfigurationServiceProtocol { get }
    
    var activityManager: ActivityManagerProtocol { get }
    
    var heartRate: HeartRateServiceProtocol { get }
    
    var characteristics: CharacteristicServiceProtocol { get }
    
    var nutritionService: NutritionServiceProtocol { get }
    
    var sleep: SleepServiceProtocol { get }
    
    var body: BodyServiceProtocol { get }
    
    var mindful: MindfulnessServiceProtocol { get }
    
    var cycleTracking: CycleTrackingProtocol { get }
    
    var vitals: VitalsServiceProtocol { get }
}
