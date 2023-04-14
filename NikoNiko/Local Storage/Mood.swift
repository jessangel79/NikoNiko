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
    @Persisted(indexed: true) var date = Date()
    @Persisted var comment = ""
    
    convenience init(name: String, date: Date = Date(), comment: String) {
        self.init()
        self.name = name
        self.date = date
        self.comment = comment
    }
}
