//
//  InformationsViewControllerUITests.swift
//  NikoNikoUITests
//
//  Created by Angelique Babin on 27/12/2021.
//

import XCTest

class InformationsViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launchEnvironment["view"] = "InformationsViewController"
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice.shared.orientation = .portrait
    }

    override func tearDownWithError() throws {}

    func testTapInfoButton() throws {
        app.navigationBars["MoodBoard"].buttons["info"].tap()
        print(app.debugDescription)
        XCTAssertEqual(app.otherElements
                        .element
                        .staticTexts["Icon : Avion png de .pngtree.com"]
                        .exists, true)
        XCTAssertEqual(app.otherElements
                        .element
                        .staticTexts["Développeuse mobile iOS - Angélique Babin - AngeAppDev"]
                        .exists, true)

        app.navigationBars["Credits"].buttons["Stop"].tap()
        XCTAssertEqual(app.otherElements
                        .element
                        .staticTexts["Icon : Avion png de .pngtree.com"]
                        .exists, false)
        XCTAssertEqual(app.otherElements
                        .element
                        .staticTexts["Développeuse mobile iOS - Angélique Babin - AngeAppDev"]
                        .exists, false)
    }

}
