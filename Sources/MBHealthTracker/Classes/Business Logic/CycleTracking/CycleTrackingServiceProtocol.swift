//
//  CycleTrackingProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation

public protocol CycleTrackingProtocol: AnyObject {
    
    func abdominalCramps(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func acne(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func appetiteChanges(handler: @escaping (MBAsyncCallResult<AppetiteChanges>) -> Void) throws
    func bladderIncontinence(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func bloating(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func breastPain(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func cervicalMucusQuality(handler: @escaping (MBAsyncCallResult<CervicalMucusQuality>) -> Void) throws
    func chills(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func constipation(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func diarrhea(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func drySkin(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func fatigue(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func hairLoss(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func headache(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func hotFlashes(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func lowerBackPain(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func memoryLapse(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func menstrualFlow(handler: @escaping (MBAsyncCallResult<MenstrualFlow>) -> Void) throws
    func moodChanges(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func nausea(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func nightSweats(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func ovulation(handler: @escaping (MBAsyncCallResult<Ovulation>) -> Void) throws // UPDATE
    
    func sexualActivity(handler: @escaping (MBAsyncCallResult<SexualActivity>) -> Void) throws
    func spotting(handler: @escaping (MBAsyncCallResult<Spotting>) -> Void) throws
}
