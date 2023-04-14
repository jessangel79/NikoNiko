//
//  StringExtensionTests.swift
//  SunsetAppTests
//
//  Created by Angelique Babin on 13/11/2021.
//

import XCTest
@testable import NikoNiko

class StringExtensionTests: XCTestCase {
    
    // MARK: - Test Extension String
    
    func testStringToDate() throws {
        let date = "2021-11-25"
        let testDate = "2021-11-25T16:15:52+00:00".toDate()
        XCTAssertEqual(testDate.toString(format: FormatDate.formatted.rawValue), date)
    }
    
    func testTransformDateNoFormattedInDateFormatted() throws {
        XCTAssertEqual("24/11", "2021-11-24T16:15:52+00:00".transformDate())
    }
    
    func testStringIsBank() throws {
        let string = ""
        XCTAssertTrue(string.isBlank)
        let stringNotBlank = "Test"
        XCTAssertFalse(stringNotBlank.isBlank)
    }
    
    func testStringTrimWhitespaces() throws {
        let string = " Test "
        XCTAssertEqual(string.trimWhitespaces, "Test")
    }

}
