//
//  SymptomsServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation

public protocol SymptomsServiceProtocol: AnyObject {
    
    func acne(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func appetiteChanges(handler: @escaping (MBAsyncCallResult<AppetiteChanges>) -> Void) throws
    func bladderIncontinence(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func bodyAndMuscleAche(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func chestTightnessOrPain(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func chills(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func congestion(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func constipation(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func coughing(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func diarrhea(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func drySkin(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func fainting(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func fatigue(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func fever(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func hairLoss(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func headache(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func heartBurn(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func hotFlushes(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func lossOfSmell(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func lossOfTaste(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func lowerBackPain(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func memoryLapse(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func nausea(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func nightSweats(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func pelvicPain(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func rapidPoundingOrFlutteringHeartbeat(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func runnyNose(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func shortnessOfBreath(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func skippedHeartbeat(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func sleepChanges(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func soreThroat(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func vomiting(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
    func wheezing(handler: @escaping (MBAsyncCallResult<GenericSymptomModel>) -> Void) throws
}
