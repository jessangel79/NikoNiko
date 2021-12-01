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
        guard let date = formatter.date(from: self) else { return Date() }
        return date
    }
    
    /// transform date no formatted in date formatted
    func transformDate() -> String {
        var dateTemp = ""
        let initialString = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        if let date = dateFormatter.date(from: initialString) {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.month, .day], from: date)
            
            guard let month = dateComponents.month else { return "" }
            guard let day = dateComponents.day else { return "" }
            dateTemp = "\(day)/\(month)"
        }
        return dateTemp
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
