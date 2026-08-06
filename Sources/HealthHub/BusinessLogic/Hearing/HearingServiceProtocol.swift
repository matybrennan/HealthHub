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
    func environmentalAudioExposureEvent() async throws -> EnvironmentalAudioExposureNotification
    func environmentalSoundReduction() async throws -> EnvironmentalSoundReduction
    func headphoneAudioExposure() async throws -> HeadphoneAudioExposureEvent
    func headphoneAudioExposureEvent() async throws -> HeadphoneAudioExposureNotification
    func audiogram() async throws -> AudiogramEntry
}
