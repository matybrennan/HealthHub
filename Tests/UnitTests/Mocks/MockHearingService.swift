import Foundation
@testable import HealthHub

final class MockHearingService: HearingServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0

    var stubbedEnvironmentalAudioExposure = EnvironmentalAudioExposureEvent(items: [])
    var stubbedEnvironmentalAudioExposureEvent = EnvironmentalAudioExposureNotification(items: [])
    var stubbedEnvironmentalSoundReduction = EnvironmentalSoundReduction(items: [])
    var stubbedHeadphoneAudioExposure = HeadphoneAudioExposureEvent(items: [])
    var stubbedHeadphoneAudioExposureEvent = HeadphoneAudioExposureNotification(items: [])
    var stubbedAudiogram = AudiogramEntry(items: [])

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    func environmentalAudioExposure() async throws -> EnvironmentalAudioExposureEvent { try await fetch(stubbedEnvironmentalAudioExposure) }
    func environmentalAudioExposureEvent() async throws -> EnvironmentalAudioExposureNotification { try await fetch(stubbedEnvironmentalAudioExposureEvent) }
    func environmentalSoundReduction() async throws -> EnvironmentalSoundReduction { try await fetch(stubbedEnvironmentalSoundReduction) }
    func headphoneAudioExposure() async throws -> HeadphoneAudioExposureEvent { try await fetch(stubbedHeadphoneAudioExposure) }
    func headphoneAudioExposureEvent() async throws -> HeadphoneAudioExposureNotification { try await fetch(stubbedHeadphoneAudioExposureEvent) }
    func audiogram() async throws -> AudiogramEntry { try await fetch(stubbedAudiogram) }
}
