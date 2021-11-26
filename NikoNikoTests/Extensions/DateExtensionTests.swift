//
//  DateExtensionTests.swift
//  SunsetAppTests
//
//  Created by Angelique Babin on 08/11/2021.
//

import XCTest
@testable import NikoNiko

class DateExtensionTests: XCTestCase {
    
    // MARK: - Test Extension Date
    
    func testDateToString() throws {
        let dateInDate = "2021-11-24T16:15:52+00:00".toDate()
        XCTAssertEqual(dateInDate.toString(format: FormatDate.formatted.rawValue), "2021-11-24")
    }
    
    func testDayOfWeek() throws {
        let dateInDate = "2021-11-24T16:15:52+00:00".toDate().dayOfWeek()
        XCTAssertEqual(dateInDate, "Wed")
    }
}
