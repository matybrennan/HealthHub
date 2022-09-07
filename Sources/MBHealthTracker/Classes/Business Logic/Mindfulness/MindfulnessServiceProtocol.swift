//
//  MindfulnessServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 24/9/19.
//

import Foundation

public protocol MindfulnessServiceProtocol: AnyObject {
    
    func mindfulActivity() async throws -> Mindful
    func save(mindful: Mindful.Info, extra: [String : Any]?) async throws
}
