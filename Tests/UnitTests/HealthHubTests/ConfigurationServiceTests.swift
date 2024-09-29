import Testing
@testable import HealthHub

@Suite("ConfigurationServiceTests Suite")
struct ConfigurationServiceTests {

    @Test("ConfigurationService")
    func configurationServiceRqeuestAuthorization() async throws {
        let mock = HealthHandlerMock()
        let service = ConfigurationService(handler: mock, healthStore: HealthStoreMock())
        try await service.requestAuthorization(toShare: HealthObjectType.allCases, toRead: HealthObjectType.allCases)
        #expect(mock.state == .hasRequestedHealthKitInfo(true))
    }
}
