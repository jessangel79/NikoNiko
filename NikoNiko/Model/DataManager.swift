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
            if moodToUpdate.date == date.toString(format: FormatDate.formatted.rawValue) {
                try realm?.write {
                    moodToUpdate.name = moodName
                }
            } else {
                addMood(realm, withName: moodName, forDate: date)
            }
        } catch let error as NSError {
            print("error : \(error.localizedDescription)")
        }
        
        print("count Mood in update Mood :\(moodList.count)")
        print("moodList in update Mood :\(String(describing: moodList))")
        
        // Invalidate notification tokens when done observing
        notificationToken().invalidate()
    }
    
    private func addMood(_ realm: Realm?, withName name: String, forDate date: Date) {
        let dateStr = date.toString(format: FormatDate.formatted.rawValue)
        let dateStrNoFormatted = date.toString(format: FormatDate.noFormatted.rawValue)
        let newMood = Mood(name: name, date: dateStr, dateNoFormatted: dateStrNoFormatted)
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
        //        let moodListCount = moodList.count
        
        if moodList.isEmpty {
            lastMoods = [Mood]()
        } else if moodList.count == 1 {
            guard let firstMood = moodList.first else { return [Mood]() }
            lastMoods.append(firstMood)
        } else if moodList.count == 2 {
            for index in 0...moodList.count {
                lastMoods.append(moodList[index])
            }
        } else {
            for index in 0...4 { // moodListCount-4...moodListCount
                lastMoods.append(moodList[index])
            }
        }
        
//        if moodList.isEmpty {
//            lastMoods = [Mood]()
//        } else {
//            switch moodList.count {
//            case 1:
//                guard let firstMood = moodList.first else { return [Mood]() }
//                lastMoods.append(firstMood)
//            case 2:
//                for index in 0...moodList.count {
//                    lastMoods.append(moodList[index])
//                }
//            case 3:
//                for index in 0...moodList.count {
//                    lastMoods.append(moodList[index])
//                }
//            default:
//                for index in 0...moodList.count { // 0...4
//                    lastMoods.append(moodList[index])
//                }
//            }
//        }
        
        print("lastMoods : \(lastMoods)")
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

    
    // debug
    func displayMoodCount(realm: Realm?) {
        moodList = realm?.objects(Mood.self)
        print("il y a \(String(describing: moodList.count)) Mood dans la liste")
    }
}
