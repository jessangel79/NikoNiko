//
//  SettingsViewController.swift
//  NikoNiko
//
//  Created by Angelique Babin on 02/12/2021.
//

import UIKit
import RealmSwift
import GoogleMobileAds

class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var useDeviceSettingsSwitch: UISwitch!
    @IBOutlet private weak var themeSwitch: UISwitch!
    
    // MARK: - Properties
    
    private let adMobService = AdMobService()
    private var cuteTheme = false
    private var theme = Theme.def.rawValue
    private var useDeviceSetting = true
    
    // MARK: - Actions
    
    @IBAction private func closeModalBarButtonTapped(_ sender: UIBarButtonItem) {
        UserSettings.useDeviceSetting = useDeviceSetting
        UserSettings.cuteTheme = cuteTheme
        UserSettings.theme = theme
        performSegue(withIdentifier: Cst.Segue.ToMoodBoard, sender: self)
    }
    
    @IBAction private func useDeviceSettingsSwitchSelected(_ sender: UISwitch) {
        useDeviceSetting = sender.isOn
    }
    
    @IBAction private func themeSwitchSelected(_ sender: UISwitch) {
        if !sender.isOn {
            theme = Theme.def.rawValue
            cuteTheme = false
        } else {
            theme = Theme.cute.rawValue
            cuteTheme = true
        }
    }
    
    @IBAction private func deleteAllDatasButtonPressed(_ sender: UIButton) {
        let dataManager = DataManager()
        guard let inverseMoodList = dataManager.inverseMoodList() else { return }
        if !inverseMoodList.isEmpty {
            resetAll()
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserDefaults()
        adMobService.setAdMob(bannerView, self)
    }
    
    // MARK: - Methods

    private func loadUserDefaults() {
        theme = UserSettings.theme
        cuteTheme = UserSettings.cuteTheme
        themeSwitch.isOn = UserSettings.cuteTheme
        useDeviceSetting = UserSettings.useDeviceSetting
    }

    private func resetAll() {
        let destructiveAction = UIAlertAction(title: "Reset all", style: .destructive, handler: { action in
            let dataManager = DataManager()
            dataManager.removeAllMoods()
            self.performSegue(withIdentifier: Cst.Segue.ToMoodBoard, sender: self)
        })
        showResetAlert(destructiveAction: destructiveAction)
    }

}
