//
//  ActiveEnergyServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/11/18.
//

import Foundation

public enum ActiveEnergyType {
    case today
    case thisWeek
    case betweenTimePref(start: Date, end: Date)
}

public protocol ActiveEnergyServiceProtocol: AnyObject {
    
    func getActiveEnergy(from type: ActiveEnergyType, completionHandler: @escaping (AsyncCallResult<ActiveEnergy>) -> Void) throws
}
