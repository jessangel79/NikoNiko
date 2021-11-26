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
    @Persisted var date = ""
    @Persisted var dateNoFormatted = ""
    
    convenience init(name: String, date: String, dateNoFormatted: String) {
        self.init()
        self.name = name
        self.date = date
        self.dateNoFormatted = dateNoFormatted
    }
}
