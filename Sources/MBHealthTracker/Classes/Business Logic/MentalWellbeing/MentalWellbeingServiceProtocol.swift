//
//  MentalWellbeingService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 24/9/19.
//

import Foundation

public protocol MentalWellbeingServiceProtocol: AnyObject {
    
    func mindfulActivity() async throws -> Mindful
    func save(mindful: Mindful, extra: [String : Any]?) async throws
}
