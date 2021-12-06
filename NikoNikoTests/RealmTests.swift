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
        let testRealm = try? Realm(configuration: config)
        dataManager.removeAllMoods(realm: testRealm)
    }

    override func tearDownWithError() throws {}
    
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
    private func add10Moods(_ testRealm: Realm) {
        dataManager.removeAllMoods(realm: testRealm)
        let newDate9 = Date().addingTimeInterval(-(24 * 60 * 60 * 9))
        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: newDate9)
        let newDate8 = Date().addingTimeInterval(-(24 * 60 * 60 * 8))
        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate8)
        let newDate7 = Date().addingTimeInterval(-(24 * 60 * 60 * 7))
        dataManager.updateMood(realm: testRealm, moodName: "disappointed", forDate: newDate7)
        let newDate6 = Date().addingTimeInterval(-(24 * 60 * 60 * 6))
        dataManager.updateMood(realm: testRealm, moodName: "smiling", forDate: newDate6)
        let newDate5 = Date().addingTimeInterval(-(24 * 60 * 60 * 5))
        dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: newDate5)
        let newDate4 = Date().addingTimeInterval(-(24 * 60 * 60 * 4))
        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: newDate4)
        let newDate3 = Date().addingTimeInterval(-(24 * 60 * 60 * 3))
        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate3)
        let newDate2 = Date().addingTimeInterval(-(24 * 60 * 60 * 2))
        dataManager.updateMood(realm: testRealm, moodName: "disappointed", forDate: newDate2)
        let newDate1 = Date().addingTimeInterval(-(24 * 60 * 60))
        dataManager.updateMood(realm: testRealm, moodName: "smiling", forDate: newDate1)
        let newDate = Date()
        dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: newDate)
    }
    
    /// Add 35 moods
    private func add35Moods(_ testRealm: Realm) {
        dataManager.removeAllMoods(realm: testRealm)
        
        let newDate = Date() // 1
        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate)
        
        for index in 1...6 { // 6
            let newDate = Date().addingTimeInterval(-(Double(24 * 60 * 60 * index)))
            dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: newDate)
        }
        for index in 7...16 { // 10
            let newDate = Date().addingTimeInterval(-(Double(24 * 60 * 60 * index)))
            dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: newDate)
        }
        for index in 17...19 { // 3
            let newDate = Date().addingTimeInterval(-(Double(24 * 60 * 60 * index)))
            dataManager.updateMood(realm: testRealm, moodName: "smiling", forDate: newDate)
        }
        for index in 20...26 { // 7
            let newDate = Date().addingTimeInterval(-(Double(24 * 60 * 60 * index)))
            dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate)
        }
        for index in 27...34 { // 8
            let newDate = Date().addingTimeInterval(-(Double(24 * 60 * 60 * index)))
            dataManager.updateMood(realm: testRealm, moodName: "disappointed", forDate: newDate)
        }
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
    
//    func testDeleteFirstMood() throws {
//        guard let testRealm = try? Realm(configuration: config) else { return }
//        add5Moods(testRealm)
//        XCTAssertTrue(testRealm.objects(Mood.self).count == 5)
//        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "happy")
//
//        dataManager.removeMood(realm: testRealm)
//        XCTAssertTrue(testRealm.objects(Mood.self).count == 4)
//        XCTAssertEqual(testRealm.objects(Mood.self).first?.name, "neutral")
//    }
    
    func testInverseMoodList() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        add10Moods(testRealm)
        guard let inverseMoodList = dataManager.inverseMoodList(realm: testRealm) else { return }
        XCTAssertFalse(inverseMoodList.isEmpty)
        XCTAssertEqual(inverseMoodList.first?.name, "sad")
        XCTAssertEqual(inverseMoodList.last?.name, "happy")
        print(inverseMoodList)
    }
    
    func testCreateMoodListDefault() throws {
        let moodListDefault = dataManager.createMoodListDefault()
        XCTAssertFalse(moodListDefault.isEmpty)
        XCTAssertEqual(moodListDefault.first?.name, "puzzledColor")
        XCTAssertTrue(moodListDefault.count == 20)
        print(moodListDefault)
    }
    
    func testGetCountIfInversListIsEmpty() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        dataManager.removeAllMoods(realm: testRealm)
        guard let inverseMoodList = dataManager.inverseMoodList(realm: testRealm) else { return }
        let getCount = dataManager.getCount(realm: testRealm)
        XCTAssertTrue(inverseMoodList.isEmpty)
        XCTAssertEqual(getCount, 20)
    }
    
    func testGetCountIfInversListIsNotEmpty() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        add10Moods(testRealm)
        guard let inverseMoodList = dataManager.inverseMoodList(realm: testRealm) else { return }
        let getCount = dataManager.getCount(realm: testRealm)
        XCTAssertFalse(inverseMoodList.isEmpty)
        XCTAssertEqual(getCount, 10)
        print(inverseMoodList)
    }
    
//    func testGetStatMood() throws {
//        guard let testRealm = try? Realm(configuration: config) else { return }
//        add35Moods(testRealm)
//        let testRealmFor35Moods = testRealm.objects(Mood.self)
//        let statMood = dataManager.getStatMood(Date().addingTimeInterval(-(24 * 60 * 60 * 22)), Date().addingTimeInterval(-(24 * 60 * 60 * 6)))
//        XCTAssertEqual(statMood?.first?.name, "sad")
//        XCTAssertEqual(statMood?.last?.name, "neutral")
//        XCTAssertEqual(statMood?.first?.date.toString(format: FormatDate.formatted.rawValue), Date().addingTimeInterval(-(24 * 60 * 60 * 5)).toString(format: FormatDate.formatted.rawValue))
//        XCTAssertEqual(statMood?.last?.date.toString(format: FormatDate.formatted.rawValue), Date().addingTimeInterval(-(24 * 60 * 60 * 21)).toString(format: FormatDate.formatted.rawValue))
//        XCTAssertEqual(statMood?.count, 17)
//        print(testRealmFor35Moods)
//        print(testRealmFor35Moods.count)
//    }

//    func testGetStatMoodCount() throws {
//        guard let testRealm = try? Realm(configuration: config) else { return }
//        add35Moods(testRealm)
//        let moodCount = dataManager.getMoodCount(Date().addingTimeInterval(-(24 * 60 * 60 * 22)), Date().addingTimeInterval(-(24 * 60 * 60 * 6)), NameMood.happy.rawValue)
//        XCTAssertEqual(moodCount, 10)
//    }
 
    func testCreateStatMoodTupleList() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        add35Moods(testRealm)
        let statMoodTupleList = dataManager.createStatMoodTupleList(Date().addingTimeInterval(-(24 * 60 * 60 * 22)), Date().addingTimeInterval(-(24 * 60 * 60 * 6)))
        print(statMoodTupleList)
        XCTAssertEqual(statMoodTupleList[0].nameMood, "smiling")
        XCTAssertEqual(statMoodTupleList[1].nameMood, "happy")
        XCTAssertEqual(statMoodTupleList[2].nameMood, "neutral")
        XCTAssertEqual(statMoodTupleList[3].nameMood, "sad")
        XCTAssertEqual(statMoodTupleList[4].nameMood, "disappointed")
        XCTAssertEqual(statMoodTupleList[0].statMood, 3)
        XCTAssertEqual(statMoodTupleList[1].statMood, 10)
        XCTAssertEqual(statMoodTupleList[2].statMood, 2)
        XCTAssertEqual(statMoodTupleList[3].statMood, 2)
        XCTAssertEqual(statMoodTupleList[4].statMood, 0)
    }

    //    func testPerformanceExample() throws {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }

}
