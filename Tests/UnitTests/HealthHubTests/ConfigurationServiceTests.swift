import Testing
import Foundation
@testable import HealthHub

@Suite("ConfigurationService Suite")
struct ConfigurationServiceTests {

    @Test("Requesting authorization sets state to hasRequestedHealthKitInfo(true)")
    func requestAuthorizationSucceeds() async throws {
        let service = ConfigurationService(healthStore: HealthStoreMock())
        try await service.requestAuthorization(toShare: HealthObjectType.allCases, toRead: HealthObjectType.allCases)
        #expect(service.state == .hasRequestedHealthKitInfo(true))
    }

    @Test("Initial state is idle before any authorization request")
    func initialStateIsIdle() {
        let service = ConfigurationService(healthStore: HealthStoreMock())
        #expect(service.state == .idle)
    }

    @Test("Mock configuration service tracks call count")
    func mockTracksCallCount() async throws {
        let mock = MockConfigurationService()
        #expect(mock.requestAuthorizationCallCount == 0)
        try await mock.requestAuthorization(toShare: [], toRead: [])
        #expect(mock.requestAuthorizationCallCount == 1)
        #expect(mock.state == .hasRequestedHealthKitInfo(true))
    }

    @Test("Mock configuration service propagates errors")
    func mockPropagatesError() async {
        let mock = MockConfigurationService()
        mock.shouldThrowError = NSError(domain: "test", code: 99)
        await #expect(throws: Error.self) {
            try await mock.requestAuthorization(toShare: [], toRead: [])
        }
        #expect(mock.requestAuthorizationCallCount == 1)
    }
}

