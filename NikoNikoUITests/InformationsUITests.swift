//
//  InformationsUITests.swift
//  NikoNikoUITests
//
//  Created by Angelique Babin on 27/12/2021.
//

import XCTest

class InformationsUITests: XCTestCase {
    
    // MARK: - Properties
    
    var app: XCUIApplication!
    
    // MARK: - Tests Life Cycle

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
    
    // MARK: - Tests InformationsViewController UI

    func testTextButtons() throws {
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
    
    // MARK: - Tests WebViewInformationsViewController UI
    
    func testIfButtonShareTapped() throws {
        let moodboardNavigationBar = app.navigationBars["MoodBoard"]
        moodboardNavigationBar.buttons["info"].tap()
        print(app.debugDescription)
        app.otherElements.buttons["devios"].tap()
        XCTAssertEqual(app.otherElements["webView"].exists, true)
        
        app.toolbars["Toolbar"].buttons["Share"].tap()
        app.navigationBars["UIActivityContentView"].buttons["Close"].tap()
        app.webViews.webViews.webViews
            .otherElements["Babin Angelique - AngelAppDev - iOS Mobile Developer / Développeur iOS"]
            .otherElements["AngelAppDev"].images["AngelAppDev"].tap()
        let webNavigationBar = app.navigationBars["Web"]
        let creditsButton = webNavigationBar.buttons["Credits"]
        creditsButton.tap()
        XCTAssertEqual(app.otherElements["webView"].exists, false)
    }
    
    func testIfButtonWebTapped() throws {
        let infoButton = app.navigationBars["MoodBoard"].buttons["info"]
        infoButton.tap()
        app.buttons["badgeLinkedIn"].tap()
        print(app.debugDescription)
        XCTAssertEqual(app.otherElements["webView"].exists, true)
        
        let webNavigationBar = app.navigationBars["Web"]
        webNavigationBar.buttons["Refresh"].tap()
        webNavigationBar.buttons["<<"].tap()
        let creditsButton = webNavigationBar.buttons["Credits"]
        creditsButton.tap()
        XCTAssertEqual(app.otherElements["webView"].exists, false)
        
        app.buttons["iconPngTree"].tap()
        XCTAssertEqual(app.otherElements["webView"].exists, true)
        
        creditsButton.tap()
        XCTAssertEqual(app.otherElements["webView"].exists, false)
        
        let stopButton = app.navigationBars["Credits"].buttons["Stop"]
        stopButton.tap()
        infoButton.tap()
        XCTAssertEqual(app.otherElements["webView"].exists, false)
    }
}
