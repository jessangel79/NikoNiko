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
    private var realm: Realm?
    
    init() {
        realm = try? Realm()
        moodList = realm?.objects(Mood.self)
    }
    
    func getMoodCount() -> Int {
        return moodList.count
    }
    
    func getMood(atIndex index: Int) -> Mood {
        return moodList[index]
    }
    
    func addMood(withName name: String, forDate date: Date) {
        let dateStr = date.toString(format: FormatDate.formatted.rawValue)
        let newMood = Mood(name: name, date: dateStr)
        do {
//            if moodList.isEmpty {
                try realm?.write {
                    realm?.add(newMood)
                }
//            }
//            for moodToUpdate in moodList {
//                if moodToUpdate.date == date.toString(format: FormatDate.formatted.rawValue) {
//                    //                        let moodList = (realm?.objects(Mood.self))!
//                    //                        let moodToUpdate = moodList[0]
//                    try realm?.write {
////                        realm?.add(newMood)
//                        moodToUpdate.name = name
//                    }
//                } else {
//                    try realm?.write {
//                        realm?.add(newMood)
//                    }
//                }
//            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func updateMood(moodName: String, forDate date: Date) {
        do {
            if moodList.isEmpty {
                addMood(withName: moodName, forDate: date)
            }
            guard let moodToUpdate = moodList.last else { return }
            if moodToUpdate.date == date.toString(format: FormatDate.formatted.rawValue) {
                //                        let moodList = (realm?.objects(Mood.self))!
                //                        let moodToUpdate = moodList[0]
                try realm?.write {
                    moodToUpdate.name = moodName
                }
            } else {
                addMood(withName: moodName, forDate: date)
            }
            //            print("count Mood in update Mood :\(moodList.count)")
        } catch let error as NSError {
            print("error : \(error.localizedDescription)")
        }
    }
    
//    func filterDate(date: String) {
//        let dateOfMood = moodList.where {
//            $0.date.contains(date)
//        }
//        print("date Of Mood : \(dateOfMood)")
//    }
    
    func removeMood(date: Date) {
        do {
            try realm?.write {
                guard let moodToDelete = moodList.last else { return }
//                let moodListCount = moodList.count
//                let moodToDelete = moodList[moodListCount-1]
                if moodToDelete.date == date.toString(format: FormatDate.formatted.rawValue) {
                    realm?.delete(moodToDelete)
                }
//                for moodToRemove in moodList {
//                    if moodToRemove.date == date.toString(format: FormatDate.formatted.rawValue) {
//                        realm?.delete(moodToRemove)
//                    }
//                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func removeMood(atIndex index: Int) {
        do {
            try realm?.write {
                realm?.delete(getMood(atIndex: index))
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func removeAllMood() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - TEST
    
    func saveMood(realm: Realm?, moodName: String, currentDate: Date) {
        do {
            let currentDateStr = currentDate.toString(format: FormatDate.formatted.rawValue)
            let mood = Mood(name: moodName, date: currentDateStr)
            print("currentDateStr : \(currentDateStr)")
            moodList = (realm?.objects(Mood.self))!
          
            let notificationToken = notificationToken()
            
            if moodList.isEmpty {
                try realm?.write {
                    realm?.add(mood)
                }
            } else {
                for moodToUpdate in moodList {
                    
                    if moodToUpdate.date < currentDate.toString(format: FormatDate.formatted.rawValue) {

                        if moodToUpdate.date < currentDate.toString(format: FormatDate.formatted.rawValue) {
                            try realm?.write {
                                realm?.add(mood)
                            }
                        } else {
                            try realm?.write {
                                moodToUpdate.name = moodName
                            }
                        }
                    }
                }
            }
            print("moodList in saveMood :\(String(describing: moodList))")
                        
            // Invalidate notification tokens when done observing
            notificationToken.invalidate()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    
        //        do {
        //            let moodList = (realm?.objects(Mood.self))!
        //            if !moodList.isEmpty {
        //                let moodToUpdate = moodList[0]
        //                for moodToUpdate in moodList {
        //                    if moodToUpdate.date == currentDate.toString(format: FormatDate.formatted.rawValue) {
        //                        updateMood(realm: realm, moodName: moodName, currentDate: currentDate)
        //                    }
        //            else {
        //                        try addToRealm(realm, mood)
        //                    }
        //                }
        
        //            } else {
        //                try addToRealm(realm, mood)
        //            }
        //        } catch let error as NSError {
        //            print(error.localizedDescription)
        //        }
    }
    
    
    func updateMoodOld(realm: Realm?, moodName: String, currentDate: Date, mood: Mood, moodToUpdate: Mood) {
        do {
//            let moodList = (realm?.objects(Mood.self))!
//            for moodToUpdate in moodList {
//                if moodToUpdate.date == currentDate.toString(format: FormatDate.formatted.rawValue) {
                    //                        let moodList = (realm?.objects(Mood.self))!
                    //                        let moodToUpdate = moodList[0]
                    try realm?.write {
                        moodToUpdate.name = moodName
                    }
//                } else {
//                    try addToRealm(realm, mood)
//                }
//            }
//            print("count Mood in update Mood :\(moodList.count)")
        } catch let error as NSError {
            print("error : \(error.localizedDescription)")
        }
    }
    
    private func addToRealm(_ realm: Realm?, _ mood: Mood) throws -> Void? {
        return try realm?.write {
            realm?.add(mood)
        }
    }
    
    func deleteAllMood(realm: Realm?) {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch let error as NSError {
            print("error : \(error.localizedDescription)")
        }
        
        //        realm?.beginWrite()
        //        realm?.delete((realm?.objects(Mood.self))!)
        //        try? realm?.commitWrite()
    }
    
    func deleteMood(realm: Realm?) {
        do {
            let moodList = (realm?.objects(Mood.self))!
            try realm?.write {
                realm?.delete(moodList)
            }
            displayMoodCount(realm: realm)
        } catch let error as NSError {
            print("error : \(error.localizedDescription)")
        }
    }
    
    private func deleteMood2(_ realm: Realm?) throws {
        // All modifications to a realm must happen in a write block.
        let moodToDelete = moodList[0]
        try realm?.write {
            // Delete the LocalOnlyQsTask.
            realm?.delete(moodToDelete)
        }
        print("A list of all moodList after deleting one: \(String(describing: moodList))")
    }
    
    func notificationToken() -> NotificationToken {
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
    
    // debug
    func displayMoodCount(realm: Realm?) {
        let moodList = realm?.objects(Mood.self)
        print("il y a \(String(describing: moodList?.count)) Mood dans la liste")
    }
}
