import XCTest
@testable import MBHealthTracker

final class MBHealthTrackerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MBHealthTracker().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
