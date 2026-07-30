import Foundation
import HealthKit
@testable import HealthHub

final class MockConfigurationService: ConfigurationServiceProtocol {

    var state: ConfigurationService.State = .idle
    var isHealthDataAvailable: Bool = true
    var requestAuthorizationCallCount = 0
    var shouldThrowError: Error?

    func requestAuthorization(toShare share: [ShareableType], toRead read: [ReadableType]) async throws {
        requestAuthorizationCallCount += 1
        if let error = shouldThrowError { throw error }
        state = .hasRequestedHealthKitInfo(true)
    }

    func authorizationStatus(for type: ReadableType) -> HKAuthorizationStatus {
        .notDetermined
    }

    func sharingAuthorizationStatus(for type: ShareableType) -> HKAuthorizationRequestStatus? {
        .shouldRequest
    }

    func navigateToHealthSettings() { }
}
