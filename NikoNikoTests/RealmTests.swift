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
    
    /// Add 5 moods without comment
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
    
    /// Add 5 moods with comments
    private func add5MoodsWithComments(_ testRealm: Realm) {
        dataManager.removeAllMoods(realm: testRealm)
        let date = Date().addingTimeInterval(-(24 * 60 * 60 * 4))
        dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: date)
        dataManager.addComment(withComment: "I'm really fine")
        let newDate = Date().addingTimeInterval(-(24 * 60 * 60 * 3))
        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate)
        dataManager.addComment(withComment: "Bof")
        let newDate2 = Date().addingTimeInterval(-(24 * 60 * 60 * 2))
        dataManager.updateMood(realm: testRealm, moodName: "disappointed", forDate: newDate2)
        dataManager.addComment(withComment: "Nothing to say")
        let newDate3 = Date().addingTimeInterval(-(24 * 60 * 60))
        dataManager.updateMood(realm: testRealm, moodName: "smiling", forDate: newDate3)
        dataManager.addComment(withComment: "Happy !")
        let newDate4 = Date()
        dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: newDate4)
        dataManager.addComment(withComment: "I'm really sad")
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
    private func add35MoodsWithComments(_ testRealm: Realm) {
        dataManager.removeAllMoods(realm: testRealm)
        
        let newDate = Date() // 1
        dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate)
        dataManager.addComment(withComment: "Bof")
        
        for index in 1...6 { // 6
            let newDate = Date().addingTimeInterval(-(Double(24 * 60 * 60 * index)))
            dataManager.updateMood(realm: testRealm, moodName: "sad", forDate: newDate)
            dataManager.addComment(withComment: "I'm really sad")
        }
        for index in 7...16 { // 10
            let newDate = Date().addingTimeInterval(-(Double(24 * 60 * 60 * index)))
            dataManager.updateMood(realm: testRealm, moodName: "happy", forDate: newDate)
            dataManager.addComment(withComment: "I'm really fine")
        }
        for index in 17...19 { // 3
            let newDate = Date().addingTimeInterval(-(Double(24 * 60 * 60 * index)))
            dataManager.updateMood(realm: testRealm, moodName: "smiling", forDate: newDate)
            dataManager.addComment(withComment: "Happy !")
        }
        for index in 20...26 { // 7
            let newDate = Date().addingTimeInterval(-(Double(24 * 60 * 60 * index)))
            dataManager.updateMood(realm: testRealm, moodName: "neutral", forDate: newDate)
            dataManager.addComment(withComment: "Bof")
        }
        for index in 27...34 { // 8
            let newDate = Date().addingTimeInterval(-(Double(24 * 60 * 60 * index)))
            dataManager.updateMood(realm: testRealm, moodName: "disappointed", forDate: newDate)
            dataManager.addComment(withComment: "Nothing to say")
        }
    }
    
    private func setTextToStat(_ moodRow: (nameMood: String, moodData: MoodData)) -> String {
        var stringCount = ""
        switch moodRow.moodData {
        case .countMood(let count):
            stringCount = String(count)
        case .lastComment:
            stringCount = ""
        }
        return stringCount
    }
    
    private func setTextToCommentMood(_ lastCommentMoodRow: (nameMood: String, moodData: MoodData)) -> String {
        var commentMood = String()
        switch lastCommentMoodRow.moodData {
        case .countMood:
            commentMood = ""
        case .lastComment(let comment):
            commentMood = comment
        }
        return commentMood
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
        XCTAssertEqual(testRealm.objects(Mood.self).first?.comment, "No comment yet")
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
    
    func testGetCountIfInverseListIsEmpty() throws {
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
//        let moodCount = dataManager.getMoodCount(Date().addingTimeInterval(-(24 * 60 * 60 * 22)), Date().addingTimeInterval(-(24 * 60 * 60 * 6)), AssetsImage.happy.rawValue)
//        XCTAssertEqual(moodCount, 10)
//    }
 
    func testCreateStatMoodTupleListWithComments() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        add35MoodsWithComments(testRealm)
        let fromDate = Date().addingTimeInterval(-(24 * 60 * 60 * 22))
        let toDate = Date().addingTimeInterval(-(24 * 60 * 60 * 6))
        let statMoodTupleList = dataManager.createMoodTupleList(fromDate, toDate, MoodData.countMood(0))
        let lastCommentMoodTupleList = dataManager.createMoodTupleList(fromDate, toDate, MoodData.lastComment(""))
                print(statMoodTupleList)
        XCTAssertEqual(statMoodTupleList[0].nameMood, "smiling")
        XCTAssertEqual(statMoodTupleList[1].nameMood, "happy")
        XCTAssertEqual(statMoodTupleList[2].nameMood, "neutral")
        XCTAssertEqual(statMoodTupleList[3].nameMood, "sad")
        XCTAssertEqual(statMoodTupleList[4].nameMood, "disappointed")
        XCTAssertEqual(setTextToStat(statMoodTupleList[0]), "3")
        XCTAssertEqual(setTextToStat(statMoodTupleList[1]), "10")
        XCTAssertEqual(setTextToStat(statMoodTupleList[2]), "2")
        XCTAssertEqual(setTextToStat(statMoodTupleList[3]), "2")
        XCTAssertEqual(setTextToStat(statMoodTupleList[4]), "0")
        XCTAssertEqual(setTextToCommentMood(lastCommentMoodTupleList[0]), "Happy !")
        XCTAssertEqual(setTextToCommentMood(lastCommentMoodTupleList[1]), "I'm really fine")
        XCTAssertEqual(setTextToCommentMood(lastCommentMoodTupleList[2]), "Bof")
        XCTAssertEqual(setTextToCommentMood(lastCommentMoodTupleList[3]), "I'm really sad")
        XCTAssertEqual(setTextToCommentMood(lastCommentMoodTupleList[4]), "No comment yet")
    }
    
    func testBeforeAddCommentMood() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        addFirstMood(testRealm)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.comment, "No comment yet")
    }
    
    func testAddCommentMood() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        addFirstMood(testRealm)
        dataManager.addComment(withComment: "Yes I'm fine")
        XCTAssertEqual(testRealm.objects(Mood.self).last?.comment, "Yes I'm fine")
    }
    
    func testAdd5CommentsTo5Mood() throws {
        guard let testRealm = try? Realm(configuration: config) else { return }
        add5MoodsWithComments(testRealm)
        XCTAssertEqual(testRealm.objects(Mood.self).first?.comment, "I'm really fine")
        XCTAssertEqual(testRealm.objects(Mood.self)[1].comment, "Bof")
        XCTAssertEqual(testRealm.objects(Mood.self)[2].comment, "Nothing to say")
        XCTAssertEqual(testRealm.objects(Mood.self)[3].comment, "Happy !")
        XCTAssertEqual(testRealm.objects(Mood.self).last?.comment, "I'm really sad")
    }
}
