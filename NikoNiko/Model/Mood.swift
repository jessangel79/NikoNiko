//
//  Mood.swift
//  NikoNiko
//
//  Created by Angelique Babin on 24/11/2021.
//

import Foundation
import RealmSwift

class Mood: Object {
    @objc dynamic var name = ""
    @objc dynamic var currentDate = ""
}
