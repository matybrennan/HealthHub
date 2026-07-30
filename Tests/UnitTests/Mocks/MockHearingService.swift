import Foundation
@testable import HealthHub

final class MockHearingService: HearingServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0

    var stubbedEnvironmentalAudioExposure = EnvironmentalAudioExposureEvent(items: [])
    var stubbedHeadphoneAudioExposure = HeadphoneAudioExposureEvent(items: [])
    var stubbedAudiogram = AudiogramEntry(items: [])

    private func fetch<T>(_ value: T) async throws -> T {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return value
    }

    func environmentalAudioExposure() async throws -> EnvironmentalAudioExposureEvent { try await fetch(stubbedEnvironmentalAudioExposure) }
    func headphoneAudioExposure() async throws -> HeadphoneAudioExposureEvent { try await fetch(stubbedHeadphoneAudioExposure) }
    func audiogram() async throws -> AudiogramEntry { try await fetch(stubbedAudiogram) }
}
