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
    
    // MARK: - Properties
    
    private let adMobService = AdMobService()
    
    // MARK: - Actions
    
    @IBAction func deleteAllDatasButtonPressed(_ sender: UIButton) {
//        let dataManager = DataManager()
//        dataManager.removeAllMoods()
//        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adMobService.setAdMob(bannerView, self)
    }
    
    // MARK: - Methods

}
