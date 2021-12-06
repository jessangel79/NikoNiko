//
//  FormateDate.swift
//  NikoNiko
//
//  Created by Angelique Babin on 24/11/2021.
//

import Foundation

/// formatted = "yyyy-MM-dd"
/// noFormatted = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
/// onDisplay = "dd/MM/yyyy"
enum FormatDate: String {
    case formatted = "yyyy-MM-dd"
    case noFormatted = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    case onDisplay = "dd/MM/yyyy"
}
