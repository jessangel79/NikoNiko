//
//  StatBoardViewControllerUITests.swift
//  NikoNikoUITests
//
//  Created by Angelique Babin on 27/12/2021.
//

import XCTest

class StatBoardViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launchEnvironment["view"] = "StatBoardViewController"
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice.shared.orientation = .portrait
    }

    override func tearDownWithError() throws {}

    func testTapEndDateInStatistics() throws {
        app.buttons["disappointed"].tap()
        app.tabBars["Tab Bar"].buttons["Statistics"].tap()
        print(app.debugDescription)

        XCTAssertEqual(app.tableRows.cells.element.exists, false)
        XCTAssertEqual(app.tableRows.cells.images.element.exists, false)
        XCTAssertFalse(app.label.isEmpty)

        let datePickersQuery = app.datePickers
        app.textFields["01/11/2021"].tap()
        datePickersQuery.pickers.pickerWheels["December"].swipeUp()

        let doneButton = app.toolbars["Toolbar"].buttons["Done"]
        doneButton.tap()
        app.textFields["30/11/2021"].tap()
        doneButton.tap()
        
        XCTAssertEqual(app.otherElements.element.staticTexts["0"].exists, true)
        XCTAssertEqual(app.otherElements.element.staticTexts["1"].exists, true)
        XCTAssertEqual(app.otherElements.element.staticTexts["2"].exists, false)
        
        app.navigationBars["Mood Stats"].buttons["Refresh"].tap()
        XCTAssertEqual(app.tableRows.cells.element.exists, false)
        XCTAssertEqual(app.tableRows.cells.images.element.exists, false)
        XCTAssertFalse(app.label.isEmpty)
        XCTAssertEqual(app.otherElements.element.staticTexts["Set Dates and click on search to get stats of Moods"].exists, true)
    }
    
    func testSearchButtonInStatistics() throws {
        app.tabBars["Tab Bar"].buttons["Statistics"].tap()
        app.textFields["01/11/2021"].tap()
        app.textFields["30/11/2021"].tap()
        let doneButton = app.toolbars["Toolbar"].buttons["Done"]
        doneButton.tap()
        app.navigationBars["Mood Stats"].buttons["Search"].tap()
        let toDate = Date().toString(format: FormatDate.onDisplay.rawValue)
        let fromDate = Date().addingTimeInterval(-(24 * 60 * 60 * 30)).toString(format: FormatDate.onDisplay.rawValue)
        XCTAssertEqual(app.textFields[fromDate].exists, true)
        XCTAssertEqual(app.textFields[toDate].exists, true)
    }
}

enum FormatDate: String {
    case formatted = "yyyy-MM-dd"
    case noFormatted = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    case onDisplay = "dd/MM/yyyy"
}