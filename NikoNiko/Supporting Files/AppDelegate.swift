//
//  AppDelegate.swift
//  NikoNiko
//
//  Created by Angelique Babin on 22/11/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setColorNavBar()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
    private func setColorNavBar() {
        guard let myFontNavBar = UIFont(name: "Monaco", size: 25) else { return }
        let myFontcolor =  UIColor(displayP3Red: 0.02, green: 0.00, blue: 0.60, alpha: 1.00)
        UIBarButtonItem.appearance().tintColor = myFontcolor
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: myFontcolor, .font: myFontNavBar]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: myFontcolor, .font: myFontNavBar]
        
        let myBackgroundColor = UIColor(displayP3Red: 0.439, green: 0.711, blue: 0.977, alpha: 1.0)
        navBarAppearance.backgroundColor = myBackgroundColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
        guard let myFontBarButtonItem = UIFont(name: "Monaco", size: 15) else { return }
        UIBarButtonItem.appearance().setTitleTextAttributes([.font: myFontBarButtonItem], for: UIControl.State.normal)
    }
}
