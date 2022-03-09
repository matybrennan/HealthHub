//
//  CycleTrackingProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation

public protocol CycleTrackingProtocol: AnyObject {
    
    func abdominalCramps(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func bloating(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func breastPain(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func cervicalMucusQuality(handler: @escaping (MBAsyncCallResult<CervicalMucusQuality>) -> Void) throws
    func menstrualFlow(handler: @escaping (MBAsyncCallResult<MenstrualFlow>) -> Void) throws
    func moodChanges(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
    func ovulation(handler: @escaping (MBAsyncCallResult<Ovulation>) -> Void) throws
    func sexualActivity(handler: @escaping (MBAsyncCallResult<SexualActivity>) -> Void) throws
    func spotting(handler: @escaping (MBAsyncCallResult<Spotting>) -> Void) throws
    func vaginalDryness(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws
}
