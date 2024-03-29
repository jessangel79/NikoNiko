//
//  DataManager.swift
//  NikoNiko
//
//  Created by Angelique Babin on 24/11/2021.
//

import Foundation
import RealmSwift

final class DataManager {
    
    var moodList: Results<Mood>!
    
    func updateMood(realm: Realm? = try? Realm(), moodName: String, forDate date: Date) {
        let notificationToken = notificationToken()
        do {
            moodList = (realm?.objects(Mood.self))
            if moodList.isEmpty {
                addMood(realm, withName: moodName, forDate: date)
            }
            guard let moodToUpdate = moodList.last else { return }
            if moodToUpdate.date.toString(format: FormatDate.formatted.rawValue) == date.toString(format: FormatDate.formatted.rawValue) {
                try realm?.write {
                    moodToUpdate.name = moodName
                }
            } else {
                addMood(realm, withName: moodName, forDate: date)
            }
        } catch let error as NSError {
            print("error : \(error.localizedDescription)")
            return
        }
                
        // Invalidate notification tokens when done observing
        notificationToken.invalidate()
    }
    
    private func addMood(_ realm: Realm? = try? Realm(), withName name: String, forDate date: Date) {
        let newMood = Mood(name: name, date: date, comment: "No comment yet")
        do {
            try realm?.write {
                realm?.add(newMood)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func addComment(_ realm: Realm? = try? Realm(), withComment comment: String) {
        do {
            moodList = (realm?.objects(Mood.self))
            guard let moodToUpdate = moodList.last else { return }
            try realm?.write {
                moodToUpdate.comment = comment
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func notificationToken() -> NotificationToken {
        // Retain notificationToken as long as you want to observe
        let realm = try? Realm()
        moodList = (realm?.objects(Mood.self))
        let notificationToken = moodList.observe { (changes) in
            switch changes {
            case .initial: break
                // Results are now populated and can be accessed without blocking the UI
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed.
                print("Deleted indices: ", deletions)
                print("Inserted indices: ", insertions)
                print("Modified modifications: ", modifications)
            case .error(let error): print(error.localizedDescription)
                // An error occurred while opening the Realm file on the background worker thread
                return
            }
        }
        return notificationToken
    }
    
    func removeAllMoods(realm: Realm? = try? Realm()) {
        do {
            moodList = (realm?.objects(Mood.self))
            try realm?.write {
                realm?.deleteAll()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func inverseMoodList(realm: Realm? = try? Realm()) -> Results<Mood>? {
        moodList = (realm?.objects(Mood.self))
        return moodList.sorted(byKeyPath: "date", ascending: false)
    }
    
    func createMoodListDefault() -> [Mood] {
        var moodListDefault = [Mood]()
        for _ in 1...Cst.nbOfMoods {
            let mood = Mood(name: "puzzledColor", date: Date(), comment: "") // , dateFormatted: String
            moodListDefault.append(mood)
        }
        return moodListDefault
    }
    
    func getCount(realm: Realm? = try? Realm()) -> Int {
        let inverseMoodList = inverseMoodList()
        let moodListDefault = createMoodListDefault()
        guard let inverseMoodList = inverseMoodList else { return 0 }
        if inverseMoodList.isEmpty {
            return moodListDefault.count
        } else {
            return inverseMoodList.count
        }
    }
    
    private func getStatMood(realm: Realm? = try? Realm(), _ fromDate: Date, _ toDate: Date) -> Results<Mood>? {
        moodList = (realm?.objects(Mood.self))
        let statMood = moodList.where {
            $0.date > fromDate && $0.date < toDate.addingTimeInterval(24 * 60 * 60)
        }
        return statMood
    }
    
    private func getMoodCount(_ fromDate: Date, _ toDate: Date, _ name: String) -> Int {
        let statMood = getStatMood(fromDate, toDate)
        let mood = statMood?.where {
            $0.name == name
        }
        return mood?.count ?? 0
    }
    
    private func getLastCommentMood(_ fromDate: Date, _ toDate: Date, _ name: String) -> String {
        let statMood = getStatMood(fromDate, toDate)
        let mood = statMood?.where {
            $0.name == name
        }
        guard let comment = mood?.last?.comment else { return "No comment yet" }
        return comment
    }

    func createMoodTupleList(_ fromDate: Date, _ toDate: Date, _ moodData: MoodData) -> [(nameMood: String, moodData: MoodData)] {
        let fromDateWithAdd = fromDate.addingTimeInterval(60 * 60)
        let toDateWithAdd = toDate.addingTimeInterval(60 * 60)
        var moodList = [(nameMood: String, moodData: MoodData)]()
        let moods = [AssetsImage.smiling, AssetsImage.happy, AssetsImage.neutral, AssetsImage.sad, AssetsImage.disappointed]
        for mood in moods {
            switch moodData {
            case .countMood:
                let count = getMoodCount(fromDateWithAdd, toDateWithAdd, mood.rawValue)
                moodList.append((nameMood: mood.rawValue, moodData: .countMood(count)))
            case .lastComment:
                let lastComment = getLastCommentMood(fromDateWithAdd, toDateWithAdd, mood.rawValue)
                moodList.append((nameMood: mood.rawValue, moodData: .lastComment(lastComment)))
            }
        }
        return moodList
    }
        
//    func createStatMoodTupleList(_ fromDate: Date, _ toDate: Date) -> [(nameMood: String, statMood: Int)] {
//        let fromDateWithAdd = fromDate.addingTimeInterval(60 * 60)
//        let toDateWithAdd = toDate.addingTimeInterval(60 * 60)
//        var statMoodList = [(nameMood: String, statMood: Int)]()
//        let moods = [AssetsImage.smiling, AssetsImage.happy, AssetsImage.neutral, AssetsImage.sad, AssetsImage.disappointed]
//        for mood in moods {
//            let moodCount = (nameMood: mood.rawValue, statMood: getMoodCount(fromDateWithAdd, toDateWithAdd, mood.rawValue))
//            statMoodList.append(moodCount)
//        }
//        return statMoodList
//    }
    
//    func createLastCommentMoodTupleList(_ fromDate: Date, _ toDate: Date) -> [(nameMood: String, lastCommentMood: String)] {
//        let fromDateWithAdd = fromDate.addingTimeInterval(60 * 60)
//        let toDateWithAdd = toDate.addingTimeInterval(60 * 60)
//        var lastCommentMoodList = [(nameMood: String, lastCommentMood: String)]()
//        let moods = [AssetsImage.smiling, AssetsImage.happy, AssetsImage.neutral, AssetsImage.sad, AssetsImage.disappointed]
//        for mood in moods {
//            let lastCommentMood = (nameMood: mood.rawValue, lastCommentMood: getLastCommentMood(fromDateWithAdd, toDateWithAdd, mood.rawValue))
//            lastCommentMoodList.append(lastCommentMood)
//        }
//        return lastCommentMoodList
//    }

}
