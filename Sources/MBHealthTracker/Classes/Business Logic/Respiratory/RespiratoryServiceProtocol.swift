//
//  RespiratoryServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 4/2/2022.
//

import Foundation

public protocol RespiratoryServiceProtocol: AnyObject {
    
    func respiratoryRate() async throws -> RespiratoryRate
}
