//
//  SettingsViewControllerUITests.swift
//  NikoNikoUITests
//
//  Created by Angelique Babin on 27/12/2021.
//

import XCTest

class SettingsViewControllerUITests: XCTestCase {
    
    // MARK: - Properties
    
    var app: XCUIApplication!
    
    // MARK: - Tests Life Cycle

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launchEnvironment["view"] = "SettingsViewController"
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice.shared.orientation = .portrait
    }
    
    override func tearDownWithError() throws {}
    
    // MARK: - Tests SettingsViewControllerUI

    func testResetAllButtonInSettings() throws {
        app.buttons["happy"].tap()
        app.navigationBars["MoodBoard"].buttons["settings"].tap()
        print(app.debugDescription)
        app.buttons["Delete all your datas ?"].staticTexts["Delete all your datas ?"].tap()
        XCTAssertTrue(app.alerts.element.exists)
        XCTAssertEqual(app.alerts.staticTexts["Warning Reset All"].exists, true)
        XCTAssertEqual(app.otherElements.element.staticTexts["puzzledColor"].exists, false)
        XCTAssertEqual(app.otherElements.element.staticTexts["Use device settings"].exists, true)
        XCTAssertEqual(app.otherElements.element.staticTexts["Cute theme"].exists, true)
        XCTAssertEqual(app.switches.element.exists, true)

        app.alerts["Warning Reset All"].scrollViews.otherElements.buttons["Reset all"].tap()
        guard let dayOfWeek = Date().dayOfWeek() else { return }
        let dateString = Date().toString().transformDate()
        XCTAssertFalse(app.collectionViews.cells.staticTexts[dayOfWeek].exists)
        XCTAssertFalse(app.collectionViews.cells.staticTexts[dateString].exists)
        XCTAssertTrue(app.collectionViews.cells.images.element.exists)
    }
    
    func testSwitchExists() throws {
        app.navigationBars["MoodBoard"].buttons["settings"].tap()
        print(app.debugDescription)
        XCTAssertEqual(app.otherElements.staticTexts["Use device settings"].exists, true)
        XCTAssertEqual(app.otherElements.staticTexts["Cute theme"].exists, true)

        app.navigationBars["Settings"].buttons["Done"].tap()
        XCTAssertEqual(app.otherElements.staticTexts["Use device settings"].exists, false)
        XCTAssertEqual(app.otherElements.staticTexts["Cute theme"].exists, false)
        
        app.navigationBars["MoodBoard"].buttons["settings"].tap()
        XCTAssertEqual(app.otherElements.staticTexts["Use device settings"].exists, true)
        XCTAssertEqual(app.otherElements.staticTexts["Cute theme"].exists, true)
        
        app.navigationBars["Settings"].buttons["Cancel"].tap()
        XCTAssertEqual(app.otherElements.staticTexts["Use device settings"].exists, false)
        XCTAssertEqual(app.otherElements.staticTexts["Cute theme"].exists, false)
    }

//    func disableSwitch(app: XCUIApplication, switchPath: XCUIElement) {
//        if switchPath.value.debugDescription == "1" {
//            switchPath.tap()
//        }
//    }
    
//    func enableSwitch(app: XCUIApplication, switchPath: XCUIElement) {
//        if !(switchPath.value.debugDescription == "Optional(1)") {
//            switchPath.tap()
//        }
//    }
}

//extension XCUIElement {
//    var isOn: Bool? {
//        return (self.value as? String).map { $0 == "1" }
//    }
//}
