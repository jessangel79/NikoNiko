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
        }
                
        // Invalidate notification tokens when done observing
        notificationToken.invalidate()
    }
    
    private func addMood(_ realm: Realm? = try? Realm(), withName name: String, forDate date: Date) {
        let newMood = Mood(name: name, date: date)
        do {
            try realm?.write {
                realm?.add(newMood)
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
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                print(error.localizedDescription)
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
    
    func removeMood(realm: Realm? = try? Realm()) {
        do {
            moodList = (realm?.objects(Mood.self)) // ?
            try realm?.write {
                guard let moodToDelete = moodList.first else { return }
                realm?.delete(moodToDelete)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func inverseMoodList(realm: Realm? = try? Realm()) -> Results<Mood> {
        moodList = (realm?.objects(Mood.self))
        return moodList.sorted(byKeyPath: "date", ascending: false)
    }
    
    func createMoodListDefault() -> [Mood] {
        var moodListDefault = [Mood]()
        for _ in 1...Cst.nbOfMoods {
            let mood = Mood(name: "puzzledColor") // , dateFormatted: String
            moodListDefault.append(mood)
        }
        return moodListDefault
    }
    
    func getCount(realm: Realm? = try? Realm()) -> Int {
        let inverseMoodList = inverseMoodList()
        let moodListDefault = createMoodListDefault()
        var count = Int()
        if inverseMoodList.isEmpty {
            count = moodListDefault.count
        } else {
            count = inverseMoodList.count
        }
        return count
    }
    
    func getStatMood(realm: Realm? = try? Realm(), _ fromDate: Date, _ toDate: Date) -> Results<Mood>? {
        moodList = (realm?.objects(Mood.self))
        let statMood = moodList.where {
            $0.date > fromDate.addingTimeInterval(-(24 * 60 * 60)) && $0.date < toDate
        }
        return statMood
    }
    
    func getMoodCount(_ fromDate: Date, _ toDate: Date, name: String) -> Int? {
        let statMood = getStatMood(fromDate, toDate)
        let mood = statMood?.where {
            $0.name == name
        }
        return mood?.count
    }
    
    func createStatMoodDictionnary(_ fromDate: Date, _ toDate: Date) -> [String: Int] {
        var statMoodDic = [String: Int]()
        statMoodDic[NameMood.sad.rawValue] = getMoodCount(fromDate, toDate, name: NameMood.sad.rawValue)
        statMoodDic[NameMood.happy.rawValue] = getMoodCount(fromDate, toDate, name: NameMood.happy.rawValue)
        statMoodDic[NameMood.smiling.rawValue] = getMoodCount(fromDate, toDate, name: NameMood.smiling.rawValue)
        statMoodDic[NameMood.disappointed.rawValue] = getMoodCount(fromDate, toDate, name: NameMood.disappointed.rawValue)
        statMoodDic[NameMood.neutral.rawValue] = getMoodCount(fromDate, toDate, name: NameMood.neutral.rawValue)
        return statMoodDic
    }
        
//    mood.date < Date().addingTimeInterval(24 * 60 * 60) && mood.date > Date().addingTimeInterval(-(24 * 60 * 60 * Cst.nbOfMoods))
    
    // MARK: - TEST
    
    //    func filterDate(date: String) {
    //        let dateOfMood = moodList.where {
    //            $0.date.contains(date)
    //        }
    //        print("date Of Mood : \(dateOfMood)")
    //    }
    
    //    func removeMood(atIndex index: Int) {
    //        do {
    //            try realm?.write {
    //                realm?.delete(getMood(atIndex: index))
    //            }
    //        } catch let error as NSError {
    //            print(error.localizedDescription)
    //        }
    //    }
    
    //    func getMoodCount() -> Int {
    //        return moodList.count
    //    }
        
    //    func getMood(atIndex index: Int) -> Mood {
    //        return moodList[index]
    //    }

    // debug
//    func displayMoodCount(realm: Realm?) {
//        moodList = realm?.objects(Mood.self)
//        print("il y a \(String(describing: moodList.count)) Mood dans la liste")
//    }
}
