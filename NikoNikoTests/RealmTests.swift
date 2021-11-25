//
//  RealmTests.swift
//  NikoNikoTests
//
//  Created by Angelique Babin on 25/11/2021.
//

import XCTest
@testable import NikoNiko
import RealmSwift

class RealmTests: XCTestCase {
    
    // MARK: - Properties
    
    let config = Realm.Configuration(inMemoryIdentifier: "RealmTests")
    let dataManager = DataManager()

    // MARK: - Tests Life Cycle
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "RealmTests"
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Helpers
    
    // MARK: - Tests DataManager
    
    func testsaveMoodIfCurrentDateIsTodayAndMoodListIsEmpty() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        let currentDate = "2021-11-25 10:53:16 +0000".toDate()
        XCTAssertTrue(testRealm.objects(Mood.self).isEmpty)
        dataManager.saveMood(realm: testRealm, moodName: "happy", currentDate: currentDate)
        XCTAssertFalse(testRealm.objects(Mood.self).isEmpty)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "happy")
        XCTAssertEqual(testRealm.objects(Mood.self).first?.date, "2021-11-25")
    }
    
    func testSaveMoodIfCurrentDateIsTodayAndUpdateMood() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        let currentDate = "2021-11-25 10:53:16 +0000".toDate()
        dataManager.saveMood(realm: testRealm, moodName: "happy", currentDate: currentDate)
        XCTAssertFalse(testRealm.objects(Mood.self).isEmpty)
        dataManager.saveMood(realm: testRealm, moodName: "sad", currentDate: currentDate)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "sad")
    }
    
    func testSaveMoodIfCurrentDateIsNotToday() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        let currentDate = "2021-11-25 10:53:16 +0000".toDate()
        dataManager.saveMood(realm: testRealm, moodName: "happy", currentDate: currentDate)
        let newDate = "2021-11-26 10:53:16 +0000".toDate()
        dataManager.saveMood(realm: testRealm, moodName: "neutral", currentDate: newDate)
        let newDate2 = "2021-11-27 10:53:16 +0000".toDate()
        dataManager.saveMood(realm: testRealm, moodName: "sad", currentDate: newDate2)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "happy")
        XCTAssertEqual(testRealm.objects(Mood.self)[1].name, "neutral")
        print("count Mood in test :\(testRealm.objects(Mood.self).count)")
        
    }
    
//    func testUpdateMood() throws {
//        guard let testRealm = try? Realm(configuration: config) else { return }
//        let currentDate = "2021-11-25 10:53:16 +0000".toDate()
//        dataManager.saveMood(realm: testRealm, moodName: "happy", currentDate: currentDate)
// //        dataManager.updateMood(realm: testRealm, moodName: "sad")
//        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "sad")
//    }
    
    func testDeleteAllMoods() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        let currentDate = "2021-11-25 10:53:16 +0000".toDate()
        dataManager.saveMood(realm: testRealm, moodName: "happy", currentDate: currentDate)
        dataManager.deleteAllMood(realm: testRealm)
        XCTAssertTrue(testRealm.objects(Mood.self).isEmpty)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
