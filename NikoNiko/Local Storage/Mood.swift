//
//  Mood.swift
//  NikoNiko
//
//  Created by Angelique Babin on 24/11/2021.
//

import Foundation
import RealmSwift

class Mood: Object {
    @Persisted var name = ""
//    @Persisted var date = Date()
    @Persisted(indexed: true) var date = Date()
    
    convenience init(name: String, date: Date = Date()) {
        self.init()
        self.name = name
        self.date = date
    }
}
