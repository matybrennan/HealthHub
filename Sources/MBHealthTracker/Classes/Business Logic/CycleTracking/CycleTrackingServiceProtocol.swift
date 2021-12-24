//
//  CycleTrackingProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation

public protocol CycleTrackingProtocol: AnyObject {
    
    func abdominalCramps(completionHandler: @escaping (MBAsyncCallResult<AbdominalCramp>) -> Void) throws
    func acne(completionHandler: @escaping (MBAsyncCallResult<Acne>) -> Void) throws
    func basalBodyTemperature(completionHandler: @escaping (MBAsyncCallResult<BasalBodyTemperature>) -> Void) throws
    func cervicalMucusQuality(completionHandler: @escaping (MBAsyncCallResult<CervicalMucusQuality>) -> Void) throws
    func menstrualFlow(completionHandler: @escaping (MBAsyncCallResult<MenstrualFlow>) -> Void) throws
    func ovulation(completionHandler: @escaping (MBAsyncCallResult<Ovulation>) -> Void) throws
    func sexualActivity(completionHandler: @escaping (MBAsyncCallResult<SexualActivity>) -> Void) throws
    func spotting(completionHandler: @escaping (MBAsyncCallResult<Spotting>) -> Void) throws
}
