import Testing
@testable import MBHealthTracker

@Suite("ConfigurationServiceTests Suite")
struct StepsServiceTests {

    @Test("ConfigurationServiceService update")
    func configurationServiceUpdate() async throws {
        let mock = HealthHandlerMock()
        let service = ConfigurationService(handler: mock, healthStore: HealthStoreMock())
        try await service.requestAuthorization(toShare: MBObjectType.allCases, toRead: MBObjectType.allCases)
        #expect(mock.state == .hasRequestedHealthKitInfo(true))
    }
}
