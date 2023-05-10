//
//  SettingsViewController.swift
//  NikoNiko
//
//  Created by Angelique Babin on 02/12/2021.
//

import UIKit
import RealmSwift
// import GoogleMobileAds
import AdColony

class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    
//    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var bannerPlacement: UIView!
    @IBOutlet private weak var useDeviceSettingsSwitch: UISwitch!
    @IBOutlet private weak var themeSwitch: UISwitch!
    
    // MARK: - Properties
    
//    private let adMobService = AdMobService()
    private weak var banner: AdColonyAdView?
    private var adColonyService = AdColonyService()
    private var cuteTheme = false
    private var theme = Theme.def.rawValue
    private var useDeviceSetting = true
    
    // MARK: - Actions
    
    @IBAction private func doneModalBarButtonItemTapped(_ sender: UIBarButtonItem) {
        UserSettings.useDeviceSetting = useDeviceSetting
        UserSettings.cuteTheme = cuteTheme
        UserSettings.theme = theme
        performSegue(withIdentifier: Cst.Segue.ToMoodBoard, sender: self)
    }
    
    @IBAction func cancelModalBarButtonItemTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction private func useDeviceSettingsSwitchSelected(_ sender: UISwitch) {
        if sender.isOn {
            useDeviceSetting = true
        } else {
            useDeviceSetting = false
        }
    }
    
    @IBAction private func themeSwitchSelected(_ sender: UISwitch) {
        if sender.isOn {
            theme = Theme.cute.rawValue
            cuteTheme = true
        } else {
            theme = Theme.def.rawValue
            cuteTheme = false
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
        setUserInterfaceStyle()
        
        adColonyService.destroyAd() // TEST
        adColonyService.requestMediumRectBannerAd(Cst.AdColony.BannerMediumRect, self)
//        adMobService.setAdMob(bannerView, self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserInterfaceStyle()
    }
    
    // MARK: - Methods

    private func loadUserDefaults() {
        useDeviceSetting = UserSettings.useDeviceSetting
        useDeviceSettingsSwitch.isOn = useDeviceSetting
        theme = UserSettings.theme
        cuteTheme = UserSettings.cuteTheme
        themeSwitch.isOn = cuteTheme
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

// MARK: - Extension AdColony AdView Delegate

extension SettingsViewController {
    override func adColonyAdViewDidLoad(_ adView: AdColonyAdView) {
        if let oldBanner = self.banner {
            oldBanner.destroy()
        }
        let placementSize = kAdColonyAdSizeMediumRectangle // 320x250
//        let placementSize = self.bannerPlacement.frame.size
        adView.frame = CGRect(x: 0, y: 0, width: placementSize.width, height: placementSize.height)
        self.bannerPlacement.addSubview(adView)
        self.banner = adView
    }
}
