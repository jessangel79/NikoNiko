//
//  MoodBoardViewControllerUITests.swift
//  MoodBoardViewControllerUITests
//
//  Created by Angelique Babin on 09/12/2021.
//

import XCTest

class MoodBoardViewControllerUITests: XCTestCase {
    
    // MARK: - Properties
    
    var app: XCUIApplication!
    
    // MARK: - Tests Life Cycle

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launchEnvironment["view"] = "MoodBoardViewController"
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice.shared.orientation = .portrait
//        print(app.debugDescription)
    }

    override func tearDownWithError() throws {}
    
    // MARK: - Tests MoodBoardViewControllerUI
    
    func testTapOnMoodButton() throws {
        app.buttons["happy"].tap()
        let dateString = Date().toString().transformDate()
        guard let dayOfWeek = Date().dayOfWeek() else { return }
        XCTAssertTrue(app.collectionViews.cells.staticTexts[dateString].exists)
        XCTAssertTrue(app.collectionViews.cells.images.element.exists)
        print(dateString)
        print(dayOfWeek)
        print(Date())
        XCTAssertEqual(app.collectionViews.cells.otherElements.otherElements.staticTexts[dayOfWeek].exists, true)
        XCTAssertEqual(app.collectionViews.cells.otherElements.otherElements.staticTexts[dateString].exists, true)
        XCTAssertEqual(app.otherElements.element.staticTexts["smiling"].exists, true)
        XCTAssertEqual(app.otherElements.element.staticTexts["happy"].exists, true)
        XCTAssertEqual(app.otherElements.element.staticTexts["neutral"].exists, true)
        XCTAssertEqual(app.otherElements.element.staticTexts["sad"].exists, true)
        XCTAssertEqual(app.otherElements.element.staticTexts["disappointed"].exists, true)
        XCTAssertEqual(app.otherElements.element.staticTexts["puzzledColor"].exists, false)
    }
    
    func testLongPressRecognizerOnMoodButton() throws {
        app.buttons["smiling"].tap()
        let smilingButton = app.buttons["smiling"]
        smilingButton.press(forDuration: 3.6);
//        smilingButton.press(forDuration: 1.2);
        app.alerts["Do you have a comment to add ?"].scrollViews.otherElements.buttons["Add"].tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

// MARK: - Extension Date to UI Tests

extension Date {
    
    func toString(format: String = "yyyy-MM-dd'T'HH:mm:ssZZZZZ") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func getCurrentMonth() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self).capitalized
    }
    
    func getCurrentYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self).capitalized
    }
}

// MARK: - Extension String to UI Tests

extension String {
    /// transform date no formatted in date formatted
    func transformDate() -> String {
        var dateTemp = ""
        let initialString = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        if let date = dateFormatter.date(from: initialString) {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.month, .day], from: date)
            
            guard let month = dateComponents.month else { return "" }
            guard let day = dateComponents.day else { return "" }
            dateTemp = "\(day)/\(month)"
        }
        return dateTemp
    }
}
