//
//  Date.swift
//  NikoNiko
//
//  Created by Angelique Babin on 24/11/2021.
//

import Foundation

extension Date {
    
    /// format type date in type string
    func toString(format: String = "yyyy-MM-dd'T'HH:mm:ssZZZZZ") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self).capitalized
    }
}
