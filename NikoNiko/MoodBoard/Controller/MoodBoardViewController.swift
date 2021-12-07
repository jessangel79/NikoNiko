//
//  MoodBoardViewController.swift
//  NikoNiko
//
//  Created by Angelique Babin on 22/11/2021.
//

import UIKit
import RealmSwift
import GoogleMobileAds

final class MoodBoardViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var moodTodayButtons: [UIButton]!
    @IBOutlet private weak var historyView: UIView!
    @IBOutlet private var titleLabels: [UILabel]!
    @IBOutlet weak var moodHistoryCollectionView: UICollectionView!
    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var todayLabel: UILabel!
    
    // MARK: - Properties
    
    private var inverseMoodList: Results<Mood>?
    private let adMobService = AdMobService()
    private var useDeviceSetting = true
    private var cuteTheme = false
    private var theme = Theme.def.rawValue

    // MARK: - Actions
    
    @IBAction private func moodTodayButtonsPressed(_ sender: UIButton) {
        guard let moodName = sender.currentTitle else { return }
        getMoodForToday(moodName: moodName)
        getInverseMoodList()
        moodHistoryCollectionView.reloadData()
    }
        
    @IBAction private func unwindToViewController(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.setImageButtons()
                self.moodHistoryCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moodHistoryCollectionView.delegate = self
        moodHistoryCollectionView.dataSource = self
        loadUserDefaults()
        setImageButtons()
        customUI()
        moodHistoryCollectionView.register(MoodHistoryCollectionViewCell.nib,
                                           forCellWithReuseIdentifier: MoodHistoryCollectionViewCell.identifier)
        getInverseMoodList()
        print("REALM : \(Realm.Configuration.defaultConfiguration.fileURL!)") // for db Realm Studio
        moodHistoryCollectionView.reloadData()
        moodHistoryCollectionView.collectionViewLayout = setLayout()
        adMobService.setAdMob(bannerView, self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadUserDefaults()
        setImageButtons()
        getInverseMoodList()
        moodHistoryCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {    super.traitCollectionDidChange(previousTraitCollection)
        customUIDefaultMode()
        customShadowLabel(label: todayLabel)
        setImageButtons()
        moodHistoryCollectionView.reloadData()
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        moodHistoryCollectionView.collectionViewLayout.invalidateLayout()
//    }

    // MARK: - Methods

    private func customUI() {
        customUIDefaultMode()
        customShadowLabels(labels: titleLabels)
        customCollectionView(collectionView: moodHistoryCollectionView, radius: 20, width: 0.1, colorBorder: .clear)
    }
    
    private func customUIDefaultMode() {
        customShadowButtons(buttons: moodTodayButtons)
        customShadowView(view: historyView)
        guard let borderColor = UIColor.appColor(.backGroundColor) else { return }
        customView(view: historyView, radius: 20, width: 0.8, colorBorder: borderColor)
    }
    
    private func setLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 120)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private func loadUserDefaults() {
        useDeviceSetting = UserSettings.useDeviceSetting
        cuteTheme = UserSettings.cuteTheme
        theme = UserSettings.theme
    }
    
    private func setImageButtons() {
//        if cuteTheme {
//            for moodTodayButton in moodTodayButtons {
//                if moodTodayButton.tag == 0 {
//                    moodTodayButton.imageView?.image = UIImage(named: "def-smiling") // UIImage.appImage(.smiling)
//                } else if moodTodayButton.tag == 1 {
//                    moodTodayButton.imageView?.image = UIImage.appImage(.happy)
//                } else if moodTodayButton.tag == 2 {
//                    moodTodayButton.imageView?.image = UIImage.appImage(.neutral)
//                } else if moodTodayButton.tag == 3 {
//                    moodTodayButton.imageView?.image = UIImage.appImage(.sad)
//                } else if moodTodayButton.tag == 4 {
//                    moodTodayButton.imageView?.image = UIImage.appImage(.disappointed)
//                }
//            }
//        }
    }
    
    private func getMoodForToday(moodName: String) {
        let dataManager = DataManager()
        let currentDate = Date()
        dataManager.updateMood(moodName: moodName, forDate: currentDate)
        print("current date : \(currentDate)")
        print("moodName : \(moodName)")
    }
    
    private func getInverseMoodList() {
        let dataManager = DataManager()
        inverseMoodList = dataManager.inverseMoodList()
    }
    
}

// MARK: - UICollectionViewDataSource - UICollectionViewDelegate

extension MoodBoardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dataManager = DataManager()
        return dataManager.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let moodHistoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodHistoryCollectionViewCell.identifier, for: indexPath) as? MoodHistoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        moodHistoryCell.setupCell(indexPath, inverseMoodList)
        return moodHistoryCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 120)
    }
}
