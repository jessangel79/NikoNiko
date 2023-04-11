//
//  UserSettings.swift
//  SunsetApp
//
//  Created by Angelique Babin on 01/10/2020.
//

import UIKit

@propertyWrapper
struct MyUserDefaults<DataType> {
    let key: String
    let defaultValue: DataType
    
    var wrappedValue: DataType {
        get {
            guard let value = UserDefaults.standard.object(forKey: key) as? DataType else { return defaultValue }
            return value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct UserSettings {
    
    @MyUserDefaults(key: "useDeviceSetting", defaultValue: true)
    static var useDeviceSetting: Bool
    
    @MyUserDefaults(key: "theme", defaultValue: Theme.def.rawValue)
    static var theme: String
    
    @MyUserDefaults(key: "cuteTheme", defaultValue: false)
    static var cuteTheme: Bool
    
    /// GDPR AdColony
    @MyUserDefaults(key: "gdpr", defaultValue: false)
    static var gdpr: Bool
}
