//
//  String.swift
//  NikoNiko
//
//  Created by Angelique Babin on 24/11/2021.
//

import Foundation
 
extension String {
    
    /// format type string in type date
    func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZZZZZ") -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self) ?? Date()
    }

    /// get current date
//    func getCurrentDate(dateFormat: String) -> String {
//        let currentDate = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = dateFormat
//        let stringDate = dateFormatter.string(from: currentDate)
//        return stringDate
//    }
}
