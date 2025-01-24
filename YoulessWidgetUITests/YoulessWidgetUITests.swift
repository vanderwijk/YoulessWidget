import XCTest

class YoulessWidgetUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        // Verify that the main view displays the energy usage correctly
        let energyUsageLabel = app.staticTexts["EnergyUsageLabel"]
        XCTAssertTrue(energyUsageLabel.exists, "Energy usage label should exist")
        
        // Additional UI tests can be added here
    }
}