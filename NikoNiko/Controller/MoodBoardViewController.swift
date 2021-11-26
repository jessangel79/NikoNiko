//
//  MoodBoardViewController.swift
//  NikoNiko
//
//  Created by Angelique Babin on 22/11/2021.
//

import UIKit
import RealmSwift

final class MoodBoardViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var moodHistoryImageViews: [UIImageView]!
    @IBOutlet private var moodTodayButtons: [UIButton]!
    @IBOutlet private weak var historyView: UIView!
    @IBOutlet private var titleLabels: [UILabel]!
    
    // MARK: - Properties
    
    private let realm = try? Realm()
//    private let dataManager = DataManager()
    private var lastMoods = [Mood]()

    // MARK: - Actions
    
    @IBAction func moodTodayButtonsPressed(_ sender: UIButton) {
        guard let moodName = sender.currentTitle else { return }
        getMoodForToday(moodName: moodName)
    }
    
    @IBAction func deleteAllBarButtonItemPressed(_ sender: UIBarButtonItem) {
        let dataManager = DataManager()
        dataManager.removeAllMoods(realm: realm)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
        print("REALM : \(Realm.Configuration.defaultConfiguration.fileURL!)") // for db Realm Studio
//        getLastMoods()
    }
    
    // MARK: - Methods
    
    private func customUI() {
        customShadowImageViews(imageViews: moodHistoryImageViews)
        customShadowButtons(buttons: moodTodayButtons)
        customShadowView(view: historyView)
        customView(view: historyView, radius: 20, width: 0.8, colorBorder: #colorLiteral(red: 0.04181067646, green: 0, blue: 0.6056833863, alpha: 1))
        customShadowLabels(labels: titleLabels)

    }
    
    private func getMoodForToday(moodName: String) {
        let dataManager = DataManager()
        let currentDate = Date()
        dataManager.updateMood(realm: self.realm, moodName: moodName, forDate: currentDate)
        print("current date : \(currentDate)")
        print("moodName : \(moodName)")
    }
    
    private func getLastMoods() {
        let dataManager = DataManager()
        lastMoods = dataManager.getLastMoods(realm: realm)
    }
    
    private func setMoodHistoryImages() {
        
    }

}
