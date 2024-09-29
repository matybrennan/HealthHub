import Testing
@testable import MBHealthTracker

@Suite("HealthTracker Suite")
struct HealthTrackerTests {

    @Test("Example")
    func basicComparing() {
        let string = "Hello, World!"
        #expect(string == "Hello, World!")
    }
}
