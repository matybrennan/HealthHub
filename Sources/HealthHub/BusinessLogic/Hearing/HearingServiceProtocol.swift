//
//  HearingServiceProtocol.swift
//  HealthHub
//
//  Created by Maty Brennan on 29/6/2026.
//

import Foundation

public protocol HearingServiceProtocol {

    // Fetch
    func environmentalAudioExposure() async throws -> EnvironmentalAudioExposureEvent
    func headphoneAudioExposure() async throws -> HeadphoneAudioExposureEvent
    func audiogram() async throws -> AudiogramEntry
}
