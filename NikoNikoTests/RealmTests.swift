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
    
    private func addFirstMood(_ testRealm: Realm) {
        let date = Date()
        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: date)
    }
    
    private func add5Moods(_ testRealm: Realm) {
        dataManager.removeAllMoods(realm: testRealm)
        let date = Date().addingTimeInterval(-(24 * 60 * 60 * 4))
        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: date)
        let newDate = Date().addingTimeInterval(-(24 * 60 * 60 * 3))
        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate)
        let newDate2 = Date().addingTimeInterval(-(24 * 60 * 60 * 2))
        dataManager.updateMood(realm: testRealm, moodName: "disappointed", forDate: newDate2)
        let newDate3 = Date().addingTimeInterval(-(24 * 60 * 60))
        dataManager.updateMood(realm: testRealm, moodName: "smiling", forDate: newDate3)
        let newDate4 = Date()
        dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: newDate4)
    }
    
    /// Add 10 moods
    private func addFullMoods(_ testRealm: Realm) {
        dataManager.removeAllMoods(realm: testRealm)
        let date = Date().addingTimeInterval(-(24 * 60 * 60 * 9))
        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: date)
        let newDate = Date().addingTimeInterval(-(24 * 60 * 60 * 8))
        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate)
        let newDate2 = Date().addingTimeInterval(-(24 * 60 * 60 * 7))
        dataManager.updateMood(realm: testRealm, moodName: "disappointed", forDate: newDate2)
        let newDate3 = Date().addingTimeInterval(-(24 * 60 * 60 * 6))
        dataManager.updateMood(realm: testRealm, moodName: "smiling", forDate: newDate3)
        let newDate4 = Date().addingTimeInterval(-(24 * 60 * 60 * 5))
        dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: newDate4)
        let newDate5 = Date().addingTimeInterval(-(24 * 60 * 60 * 4))
        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: newDate5)
        let newDate6 = Date().addingTimeInterval(-(24 * 60 * 60 * 3))
        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate6)
        let newDate7 = Date().addingTimeInterval(-(24 * 60 * 60 * 2))
        dataManager.updateMood(realm: testRealm, moodName: "disappointed", forDate: newDate7)
        let newDate8 = Date().addingTimeInterval(-(24 * 60 * 60))
        dataManager.updateMood(realm: testRealm, moodName: "smiling", forDate: newDate8)
        let newDate9 = Date()
        dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: newDate9)
    }
    
    private func updateMood(_ testRealm: Realm) {
        dataManager.removeAllMoods(realm: testRealm)
        let date = Date()
        dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: date)
        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: date)
    }
    
    // MARK: - Tests DataManager
    
    func testUpdateMoodIfMoodListIsEmptyAndAddFirstMood() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        dataManager.removeAllMoods(realm: testRealm)
        XCTAssertTrue(testRealm.objects(Mood.self).isEmpty)

        addFirstMood(testRealm)
        XCTAssertFalse(testRealm.objects(Mood.self).isEmpty)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "happy")
        XCTAssertEqual(testRealm.objects(Mood.self).first?.date.toString(format: FormatDate.formatted.rawValue), Date().toString(format: FormatDate.formatted.rawValue))
    }
    
    func testUpdateMoodIfMoodAlreadyExistToTheDateAndUpdateMood() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        updateMood(testRealm)
        XCTAssertFalse(testRealm.objects(Mood.self).isEmpty)
        XCTAssertEqual(testRealm.objects(Mood.self).last?.name, "neutral")
    }
    
    func testUpdateMoodIfAnotherDayIsAdded() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        add5Moods(testRealm)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "happy")
        XCTAssertEqual(testRealm.objects(Mood.self)[1].name, "neutral")
        XCTAssertEqual(testRealm.objects(Mood.self)[2].name, "disappointed")
        XCTAssertEqual(testRealm.objects(Mood.self).last?.name, "sad")
        XCTAssertTrue(testRealm.objects(Mood.self).count == 5)
    }
    
    func testRemoveAllMoods() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        add5Moods(testRealm)
        dataManager.removeAllMoods(realm: testRealm)
        XCTAssertTrue(testRealm.objects(Mood.self).isEmpty)
    }
    
    func testDeleteFirstMood() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        add5Moods(testRealm)
        XCTAssertTrue(testRealm.objects(Mood.self).count == 5)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "happy")
        
        dataManager.removeMood(realm: testRealm)
        XCTAssertTrue(testRealm.objects(Mood.self).count == 4)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "neutral")
    }
    
    func testInverseMoodList() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        addFullMoods(testRealm)
        let inverseMoodList = dataManager.inverseMoodList(realm: testRealm)
        XCTAssertFalse(inverseMoodList.isEmpty)
        XCTAssertEqual(inverseMoodList.first?.name, "sad")
        print(inverseMoodList)
    }
    
    func testCreateMoodListDefault() {
        let moodListDefault = dataManager.createMoodListDefault()
        XCTAssertFalse(moodListDefault.isEmpty)
        XCTAssertEqual(moodListDefault.first?.name, "puzzledColor")
        XCTAssertEqual(moodListDefault.first?.dateFormatted, "--/--")
        XCTAssertTrue(moodListDefault.count == 20)
    }
    
//    func testGetLastMoodsIfExist5Moods() throws {
//        guard let testRealm = try? Realm(configuration: config) else { return }
//        add5Moods(testRealm)
//        var lastMoods = [Mood]()
//        lastMoods = dataManager.getLastMoods(realm: testRealm)
//        print("lastMoods in test : \(lastMoods)")
//        XCTAssertFalse(lastMoods.isEmpty)
//        XCTAssertEqual(lastMoods.last?.name, "sad")
//    }
    
//    func testGetLastMoodsIfMoodsIsEmpty() throws {
//        guard let testRealm = try? Realm(configuration: config) else { return }
//        dataManager.removeAllMoods(realm: testRealm)
//        var lastMoods = [Mood]()
//        lastMoods = dataManager.getLastMoods(realm: testRealm)
//        print("lastMoods in test : \(lastMoods)")
//        XCTAssertTrue(lastMoods.isEmpty)
//    }
    
//    func testGetLastMoodsIfMoods() throws {
//        guard let testRealm = try? Realm(configuration: config) else { return }
//        addFullMoods(testRealm)
////        addFirstMood(testRealm)
////        add5Moods(testRealm)
//        var lastMoods = [Mood]()
//        lastMoods = dataManager.getLastMoods(realm: testRealm)
//        print("lastMoods in test : \(lastMoods)")
//
//        XCTAssertFalse(lastMoods.isEmpty)
//        XCTAssertEqual(testRealm.objects(Mood.self).endIndex, 10)
//        XCTAssertEqual(lastMoods.endIndex, 5)
//        XCTAssertEqual(lastMoods.last?.date.toString(format: FormatDate.formatted.rawValue), Date().toString(format: FormatDate.formatted.rawValue))
//
//    }

    //    func testPerformanceExample() throws {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }

}
