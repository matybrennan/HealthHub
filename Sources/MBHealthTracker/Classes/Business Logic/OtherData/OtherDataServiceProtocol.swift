//
//  OtherDataServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation

public protocol OtherDataServiceProtocol: AnyObject {
    
    func alcoholConsumption(handler: @escaping (MBAsyncCallResult<AlcoholConsumption>) -> Void) throws
}
