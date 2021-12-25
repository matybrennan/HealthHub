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
    func chills(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func basalBodyTemperature(handler: @escaping (MBAsyncCallResult<BasalBodyTemperature>) -> Void) throws
    func cervicalMucusQuality(handler: @escaping (MBAsyncCallResult<CervicalMucusQuality>) -> Void) throws
    func menstrualFlow(handler: @escaping (MBAsyncCallResult<MenstrualFlow>) -> Void) throws
    func ovulation(handler: @escaping (MBAsyncCallResult<Ovulation>) -> Void) throws
    func sexualActivity(handler: @escaping (MBAsyncCallResult<SexualActivity>) -> Void) throws
    func spotting(handler: @escaping (MBAsyncCallResult<Spotting>) -> Void) throws
}
