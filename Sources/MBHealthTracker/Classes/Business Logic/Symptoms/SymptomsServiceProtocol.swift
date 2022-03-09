//
//  SymptomsServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation

public protocol SymptomsServiceProtocol: AnyObject {
    
    func acne(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func appetiteChanges(handler: @escaping (MBAsyncCallResult<AppetiteChanges>) -> Void) throws
    func bladderIncontinence(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func bodyAndMuscleAche(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func chestTightnessOrPain(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func chills(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func congestion(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func constipation(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func coughing(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func diarrhea(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func drySkin(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func fainting(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func fatigue(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func fever(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func hairLoss(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func headache(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func heartBurn(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func hotFlushes(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func lossOfSmell(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func lossOfTaste(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func lowerBackPain(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func memoryLapse(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func nausea(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func nightSweats(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func pelvicPain(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func rapidPoundingOrFlutteringHeartbeat(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func runnyNose(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func shortnessOfBreath(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func skippedHeartbeat(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func sleepChanges(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func soreThroat(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func vomiting(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func wheezing(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
}
