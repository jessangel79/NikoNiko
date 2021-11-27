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
//    private var realm: Realm?
    
//    init() {
//        realm = try? Realm()
//        moodList = realm?.objects(Mood.self)
//    }
    
    func updateMood(realm: Realm?, moodName: String, forDate date: Date) {
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
        notificationToken().invalidate()
    }
    
    private func addMood(_ realm: Realm?, withName name: String, forDate date: Date) {
        let dateStrFormatted = date.toString(format: FormatDate.formatted.rawValue)
        let newMood = Mood(name: name, date: date, dateFormatted: dateStrFormatted)
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
                   fatalError("\(error)")
               }
           }
        return notificationToken
    }
    
    func removeAllMoods(realm: Realm?) {
        do {
            moodList = (realm?.objects(Mood.self))
            try realm?.write {
                realm?.deleteAll()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func removeMood(realm: Realm?) {
        do {
            try realm?.write {
                moodList = (realm?.objects(Mood.self))
                guard let moodToDelete = moodList.first else { return }
                realm?.delete(moodToDelete)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func getLastMoods(realm: Realm?) -> [Mood] {
        var lastMoods = [Mood]()
        moodList = (realm?.objects(Mood.self))
        if moodList.isEmpty {
            lastMoods = [Mood]()
        } else {
            for mood in moodList {
                if mood.date < Date().addingTimeInterval(24 * 60 * 60) && mood.date > Date().addingTimeInterval(-(24 * 60 * 60 * Cst.nbOfMoods)) {
                    lastMoods.append(mood)
                }
            }
        }
        return lastMoods
    }
    
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

    /// debug
//    func displayMoodCount(realm: Realm?) {
//        moodList = realm?.objects(Mood.self)
//        print("il y a \(String(describing: moodList.count)) Mood dans la liste")
//    }
}
