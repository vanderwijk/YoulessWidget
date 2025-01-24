import XCTest
@testable import YoulessWidgetWidgetExtension

class YoulessWidgetTests: XCTestCase {

    func testWidgetEntryInitialization() {
        let entry = YoulessWidgetEntry(date: Date(), energyUsage: EnergyUsage(cnt: " 45468,786", pwr: 210, lvl: 0, dev: "", det: "", con: "OK", sts: "(47)", cs0: " 0,000", ps0: 0, raw: 0))
        XCTAssertNotNil(entry)
        XCTAssertEqual(entry.energyUsage.pwr, 210)
    }

    func testWidgetProviderFetchesData() {
        let provider = YoulessWidgetProvider()
        let expectation = self.expectation(description: "Fetch energy usage data")

        provider.getTimeline { result in
            switch result {
            case .success(let entries):
                XCTAssertFalse(entries.isEmpty)
                XCTAssertEqual(entries.first?.energyUsage.pwr, 210)
            case .failure(let error):
                XCTFail("Expected successful fetch, but got error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}