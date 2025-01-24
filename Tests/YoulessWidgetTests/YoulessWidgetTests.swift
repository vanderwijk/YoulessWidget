import XCTest
@testable import YoulessWidget

class YoulessWidgetTests: XCTestCase {

    var youlessService: YoulessService!

    override func setUp() {
        super.setUp()
        youlessService = YoulessService()
    }

    override func tearDown() {
        youlessService = nil
        super.tearDown()
    }

    func testFetchEnergyUsage() {
        let expectation = self.expectation(description: "Fetch energy usage data")
        
        youlessService.fetchEnergyUsage { result in
            switch result {
            case .success(let energyUsage):
                XCTAssertNotNil(energyUsage)
                XCTAssertGreaterThan(energyUsage.pwr, 0)
            case .failure(let error):
                XCTFail("Failed to fetch energy usage: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}