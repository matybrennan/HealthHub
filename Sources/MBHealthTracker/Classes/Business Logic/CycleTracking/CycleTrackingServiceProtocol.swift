//
//  CycleTrackingProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation

public protocol CycleTrackingProtocol: AnyObject {
    
    func abdominalCramps() async throws -> GenericSymptomModel
    func bloating() async throws -> GenericSymptomModel
    func breastPain() async throws -> GenericSymptomModel
    func cervicalMucusQuality() async throws -> CervicalMucusQuality
    func menstrualFlow() async throws -> MenstrualFlow
    func moodChanges() async throws -> GenericSymptomModel
    func ovulation() async throws -> Ovulation
    func pregnancyTestResult() async throws -> PregnancyTestResult
    func progesteroneTestResult() async throws -> ProgesteroneTestResult
    func sexualActivity() async throws -> SexualActivity
    func spotting() async throws -> Spotting
    func vaginalDryness() async throws -> GenericSymptomModel
}
