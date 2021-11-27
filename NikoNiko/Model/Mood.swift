//
//  Mood.swift
//  NikoNiko
//
//  Created by Angelique Babin on 24/11/2021.
//

import Foundation
import RealmSwift

class Mood: Object {
//    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name = ""
    @Persisted(indexed: true) var date = Date() // ""
    @Persisted var dateFormatted = ""
    
    convenience init(name: String, date: Date, dateFormatted: String) {
        self.init()
        self.name = name
        self.date = date
        self.dateFormatted = dateFormatted
    }
}
