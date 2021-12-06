//
//  AppDelegate.swift
//  NikoNiko
//
//  Created by Angelique Babin on 22/11/2021.
//

import UIKit
import RealmSwift
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setColorNavBar()
        setRealm()
        setAdMob()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
    // MARK: - Methods
    
    private func setColorNavBar() {
        guard let myFontNavBar = UIFont(name: "Monaco", size: 25) else { return }
        let myFontcolor =  UIColor(displayP3Red: 0.02, green: 0.00, blue: 0.60, alpha: 1.00)
        UIBarButtonItem.appearance().tintColor = myFontcolor
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: myFontcolor, .font: myFontNavBar]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: myFontcolor, .font: myFontNavBar]
        
        let myBackgroundColor = UIColor(displayP3Red: 0.44, green: 0.71, blue: 0.98, alpha: 1.0)
        navBarAppearance.backgroundColor = myBackgroundColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
        guard let myFontBarButtonItem = UIFont(name: "Monaco", size: 15) else { return }
        UIBarButtonItem.appearance().setTitleTextAttributes([.font: myFontBarButtonItem], for: UIControl.State.normal)
    }
    
    private func setRealm() {
        let config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { (migration: Migration, oldSchemaVersion: UInt64) in
                
            })
        Realm.Configuration.defaultConfiguration = config
        //        deleteRealmIfMigrationNeeded: true
    }
    
    private func setAdMob() {
        let ads = GADMobileAds.sharedInstance()
        ads.start { status in
            // Optional: Log each adapter's initialization latency.
            let adapterStatuses = status.adapterStatusesByClassName
            for adapter in adapterStatuses {
                let adapterStatus = adapter.value
                NSLog("Adapter Name: %@, Description: %@, Latency: %f", adapter.key,
                      adapterStatus.description, adapterStatus.latency)
            }
            
        }
        //        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ GADSimulatorID, "04b5955b04ab689e9a3e11e6927572c3" ]
    }
}
