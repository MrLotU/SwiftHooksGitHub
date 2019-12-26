import XCTest
@testable import SwiftHooksGitHub

final class SwiftHooksGitHubTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftHooksGitHub().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
