import Testing
@testable import MBHealthTracker

@Suite("MBHealthTracker Suite")
struct MBHealthTrackerTests {

    @Test("Example")
    func basicComparing() {
        let string = "Hello, World!"
        #expect(string == "Hello, World!")

    }
}
