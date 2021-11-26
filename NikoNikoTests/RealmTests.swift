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
//        print("REALM TEST : \(Realm.Configuration.defaultConfiguration.fileURL!)") // for db Realm Studio
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Helpers
    
    private func addMoods(_ testRealm: Realm) {
        let currentDate = "2021-11-25T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: currentDate)
        let newDate = "2021-11-26T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate)
        let newDate2 = "2021-11-27T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "disappointed", forDate: newDate2)
        let newDate3 = "2021-11-28T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "smiling", forDate: newDate3)
        let newDate4 = "2021-11-29T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: newDate4)
    }
    private func addAllMoods(_ testRealm: Realm) {
        let currentDate = "2021-11-25T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: currentDate)
        let newDate = "2021-11-26T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate)
        let newDate2 = "2021-11-27T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "disappointed", forDate: newDate2)
        let newDate3 = "2021-11-28T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "smiling", forDate: newDate3)
        let newDate4 = "2021-11-29T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: newDate4)
        let newDate5 = "2021-11-30T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: newDate5)
        let newDate6 = "2021-12-01T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate6)
        let newDate7 = "2021-12-02T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "disappointed", forDate: newDate7)
        let newDate8 = "2021-12-03T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "smiling", forDate: newDate8)
        let newDate9 = "2021-12-04T16:15:52+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: newDate9)
    }
    
    private func updateMood(_ testRealm: Realm) {
        let currentDate = "2021-11-25T06:53:40+00:00".toDate()
        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: currentDate)
        dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: currentDate)
    }
    
    // MARK: - Tests DataManager
    
    
    
    func testUpdateMoodIfMoodListIsEmptyAndAddFirstMood() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        let currentDate = "2021-11-25T06:53:40+00:00".toDate()
        XCTAssertTrue(testRealm.objects(Mood.self).isEmpty)
        
        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: currentDate)
        
        XCTAssertFalse(testRealm.objects(Mood.self).isEmpty)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "happy")
        XCTAssertEqual(testRealm.objects(Mood.self).first?.date, "2021-11-25")
    }
    
    func testUpdateMoodIfMoodAlreadyExistAndUpdateMood() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        updateMood(testRealm)
        
        XCTAssertFalse(testRealm.objects(Mood.self).isEmpty)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "sad")
    }
    
    func testUpdateMoodIfAnotherDayIsAdded() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        addMoods(testRealm)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "happy")
        XCTAssertEqual(testRealm.objects(Mood.self)[1].name, "neutral")
        XCTAssertEqual(testRealm.objects(Mood.self)[2].name, "sad")
        XCTAssertTrue(testRealm.objects(Mood.self).count == 3)
    }
    
    func testRemoveAllMoods() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        addMoods(testRealm)
        dataManager.removeAllMoods(realm: testRealm)
        
        XCTAssertTrue(testRealm.objects(Mood.self).isEmpty)
    }
    
    func testDeleteFirstMood() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        addMoods(testRealm)
//        let currentDate = "2021-11-25T16:15:52+00:00".toDate()
//        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: currentDate)
//        let newDate = "2021-11-26T16:15:52+00:00".toDate()
//        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate)
        
        XCTAssertTrue(testRealm.objects(Mood.self).count == 2)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "happy")
        
        dataManager.removeMood(realm: testRealm)
        XCTAssertTrue(testRealm.objects(Mood.self).count == 1)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "neutral")

    }
    
    func testGetLastMoodsIfExist5Moods() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        addMoods(testRealm)
        var lastMoods = [Mood]()
        lastMoods = dataManager.getLastMoods(realm: testRealm)
        print("lastMoods in test : \(lastMoods)")
        XCTAssertFalse(lastMoods.isEmpty)
        XCTAssertEqual(lastMoods.first?.name, "happy")
    }
    
    func testGetLastMoodsIfMoodsIsEmpty() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        var lastMoods = [Mood]()
        lastMoods = dataManager.getLastMoods(realm: testRealm)
        print("lastMoods in test : \(lastMoods)")
        XCTAssertTrue(lastMoods.isEmpty)
    }
    
    func testGetLastMoodsIfMoods() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        addAllMoods(testRealm)
        var lastMoods = [Mood]()
        lastMoods = dataManager.getLastMoods(realm: testRealm)
        print("lastMoods in test : \(lastMoods)")
        XCTAssertFalse(lastMoods.isEmpty)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
