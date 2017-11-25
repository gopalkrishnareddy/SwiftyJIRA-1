#if os(Linux)

import XCTest
@testable import SwiftyJIRATests

XCTMain([
    // SwiftyJIRA
    testCase(IssuesTests.allTests),
])

#endif
