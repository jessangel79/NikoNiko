//
//  DataManager.swift
//  NikoNiko
//
//  Created by Angelique Babin on 24/11/2021.
//

import Foundation
import RealmSwift

final class DataManager {
    
    func saveMood(realm: Realm?, moodName: String, currentDate: Date) {
        let mood = Mood()
        let currentDateStr = currentDate.toString(format: FormatDate.formatted.rawValue)
        mood.name = moodName
        mood.currentDate = currentDateStr
        print("currentDateStr : \(currentDateStr)")
        do {
            try realm?.write {
                realm?.add(mood)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteAllMood(realm: Realm?) {
        realm?.beginWrite()
        realm?.delete((realm?.objects(Mood.self))!)
        try? realm?.commitWrite()
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
    
    // debug
    func displayMoodCount(realm: Realm?) {
        let moodList = realm?.objects(Mood.self)
        print("il y a \(String(describing: moodList?.count)) Mood dans la liste")
    }
}
