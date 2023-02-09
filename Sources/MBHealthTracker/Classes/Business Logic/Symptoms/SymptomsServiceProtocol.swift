//
//  SymptomsServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation

public protocol SymptomsServiceProtocol: AnyObject {
    
    func abdominalCramps() async throws -> GenericSymptomModel
    func acne() async throws -> GenericSymptomModel
    func appetiteChanges() async throws -> AppetiteChanges
    func bladderIncontinence() async throws -> GenericSymptomModel
    func bodyAndMuscleAche() async throws -> GenericSymptomModel
    func chestTightnessOrPain() async throws -> GenericSymptomModel
    func chills() async throws -> GenericSymptomModel
    func congestion() async throws -> GenericSymptomModel
    func constipation() async throws -> GenericSymptomModel
    func coughing() async throws -> GenericSymptomModel
    func diarrhea() async throws -> GenericSymptomModel
    func drySkin() async throws -> GenericSymptomModel
    func fainting() async throws -> GenericSymptomModel
    func fatigue() async throws -> GenericSymptomModel
    func fever() async throws -> GenericSymptomModel
    func hairLoss() async throws -> GenericSymptomModel
    func headache() async throws -> GenericSymptomModel
    func heartBurn() async throws -> GenericSymptomModel
    func hotFlushes() async throws -> GenericSymptomModel
    func lossOfSmell() async throws -> GenericSymptomModel
    func lossOfTaste() async throws -> GenericSymptomModel
    func lowerBackPain() async throws -> GenericSymptomModel
    func memoryLapse() async throws -> GenericSymptomModel
    func nausea() async throws -> GenericSymptomModel
    func nightSweats() async throws -> GenericSymptomModel
    func pelvicPain() async throws -> GenericSymptomModel
    func rapidPoundingOrFlutteringHeartbeat() async throws -> GenericSymptomModel
    func runnyNose() async throws -> GenericSymptomModel
    func shortnessOfBreath() async throws -> GenericSymptomModel
    func skippedHeartbeat() async throws -> GenericSymptomModel
    func sleepChanges() async throws -> GenericSymptomModel
    func soreThroat() async throws -> GenericSymptomModel
    func vomiting() async throws -> GenericSymptomModel
    func wheezing() async throws -> GenericSymptomModel
}
