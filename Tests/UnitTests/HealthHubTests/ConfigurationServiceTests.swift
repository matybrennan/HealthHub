import Testing
@testable import HealthHub

@Suite("ConfigurationServiceTests Suite")
struct ConfigurationServiceTests {

    @Test("ConfigurationService")
    func configurationServiceRqeuestAuthorization() async throws {
        let mock = HealthHandlerMock()
        let service = ConfigurationService(handler: mock, healthStore: HealthStoreMock())
        try await service.requestAuthorization(toShare: MBObjectType.allCases, toRead: MBObjectType.allCases)
        #expect(mock.state == .hasRequestedHealthKitInfo(true))
    }
}
