import Testing
@testable import HealthHub

@Suite("ConfigurationServiceTests Suite")
struct ConfigurationServiceTests {

    @Test("ConfigurationService")
    func configurationServiceRqeuestAuthorization() async throws {
        let service = ConfigurationService(healthStore: HealthStoreMock())
        try await service.requestAuthorization(toShare: HealthObjectType.allCases, toRead: HealthObjectType.allCases)
        #expect(service.state == .hasRequestedHealthKitInfo(true))
    }
}
