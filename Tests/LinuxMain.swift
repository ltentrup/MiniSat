import XCTest
@testable import CMiniSatTests
@testable import MiniSatTests

XCTMain([
    testCase(CMiniSatTests.allTests),
    testCase(MiniSatTests.allTests),
])
