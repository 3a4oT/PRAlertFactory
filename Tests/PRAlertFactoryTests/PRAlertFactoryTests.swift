import XCTest
@testable import PRAlertFactory

final class PRAlertFactoryTests: XCTestCase {
    func testBundleVersion() {
        let bundle: Bundle? =  Bundle(for: PRAlertFactory.self)
        let version: String? = bundle?.infoDictionary?["CFBundleVersion"] as? String
        XCTAssertEqual(version, "0.1.0")
    }

    static var allTests = [
        ("testBundleVersion", testBundleVersion),
    ]
}
