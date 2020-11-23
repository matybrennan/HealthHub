//
//  CharacteristicServiceProtocol.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 5/23/18.
//

import Foundation

public protocol CharacteristicServiceProtocol {
    var biologicalSex: String? { get }
    var bloodType: String? { get }
    var dateOfBirth: DateComponents? { get }
    var skinType: String? { get }
    var isWheelChairUser: Bool? { get }
}
