//
//  OtherDataServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation

public protocol OtherDataServiceProtocol: AnyObject {
    
    func alcoholConsumption(handler: @escaping (MBAsyncCallResult<AlcoholConsumption>) -> Void) throws
    func alcoholContent(handler: @escaping (MBAsyncCallResult<AlcoholContent>) -> Void) throws
    func handWashing(handler: @escaping (MBAsyncCallResult<HandWashing>) -> Void) throws
    func inhalerUsage(handler: @escaping (MBAsyncCallResult<InhalerUsage>) -> Void) throws
    func insulinDelivery(handler: @escaping (MBAsyncCallResult<InsulinDelivery>) -> Void) throws
    func numberOfTimesFallen(handler: @escaping (MBAsyncCallResult<NumberOfTimesFallen>) -> Void) throws
    func toothBrushing(handler: @escaping (MBAsyncCallResult<ToothBrushing>) -> Void) throws
    func uvExposure(handler: @escaping (MBAsyncCallResult<UVExposure>) -> Void) throws
}
