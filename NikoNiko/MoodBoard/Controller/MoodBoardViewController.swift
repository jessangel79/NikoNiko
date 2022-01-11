//
//  MoodBoardViewController.swift
//  NikoNiko
//
//  Created by Angelique Babin on 22/11/2021.
//

import UIKit
import RealmSwift
//import GoogleMobileAds
import AdColony

final class MoodBoardViewController: UIViewController {
            
    // MARK: - Outlets
    
    @IBOutlet private var moodTodayButtons: [UIButton]!
    @IBOutlet private weak var historyView: UIView!
    @IBOutlet private var titleLabels: [UILabel]!
    @IBOutlet private weak var moodHistoryCollectionView: UICollectionView!
    @IBOutlet private weak var todayLabel: UILabel!
//    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var bannerPlacement: UIView!
    
    // MARK: - Properties
    
    private var inverseMoodList: Results<Mood>?
    private weak var banner: AdColonyAdView?
    private var adColonyService = AdColonyService()
//    private let adMobService = AdMobService()

    // MARK: - Actions
    
    @IBAction private func moodTodayButtonsPressed(_ sender: UIButton) {
        guard let moodName = sender.currentTitle else { return }
        getMoodForToday(moodName: moodName)
        getInverseMoodList()
        moodHistoryCollectionView.reloadData()
    }
    
    @IBAction private func unwindToViewController(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                self.setImageButtons()
                self.moodHistoryCollectionView.reloadData()
                self.setUserInterfaceStyle()
                self.customUI()
            }
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("REALM : \(Realm.Configuration.defaultConfiguration.fileURL!)") // for db Realm Studio
        setApp()
        adColonyService.requestBannerAd1(viewController: self)
        
//        adMobService.setAdMob(bannerView, self)
//        adViewDidReceiveAd(bannerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customUI()
        getInverseMoodList()
        moodHistoryCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        adMobService.loadBannerAd(bannerView, view)
//        adMobService.setAdMob(bannerView, self)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {    super.traitCollectionDidChange(previousTraitCollection)
        customUIDefaultMode()
        customShadowLabel(label: todayLabel)
        moodHistoryCollectionView.reloadData()
    }

    // MARK: - Methods
    
    private func setCollectionView() {
        moodHistoryCollectionView.delegate = self
        moodHistoryCollectionView.dataSource = self
        moodHistoryCollectionView.register(MoodHistoryCollectionViewCell.nib,
                                           forCellWithReuseIdentifier: MoodHistoryCollectionViewCell.identifier)
        moodHistoryCollectionView.collectionViewLayout = setLayout()
    }
    
    private func setLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 120)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private func setApp() {
        setCollectionView()
        setUserInterfaceStyle()
        setImageButtons()
        customUI()
        getInverseMoodList()
        moodHistoryCollectionView.reloadData()
    }
    
    private func setImageButtons() {
        for moodTodayButton in moodTodayButtons {
            var img: UIImage?
            switch moodTodayButton.tag {
            case 0:
                img = UIImage.appImage(.smiling)
            case 1:
                img = UIImage.appImage(.happy)
            case 2:
                img = UIImage.appImage(.neutral)
            case 3:
                img = UIImage.appImage(.sad)
            case 4:
                img = UIImage.appImage(.disappointed)
            default:
                img = UIImage.appImage(.puzzledColor)
            }
            img?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            moodTodayButton.setImage(img, for: .normal)
        }
    }

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
    
    private func getMoodForToday(moodName: String) {
        let dataManager = DataManager()
        let currentDate = Date()
        dataManager.updateMood(moodName: moodName, forDate: currentDate)
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

// MARK: - Extension AdColony AdView Delegate

extension MoodBoardViewController {
    
    override func adColonyAdViewDidLoad(_ adView: AdColonyAdView) {
        if let oldBanner = self.banner {
            // remove previous banner if exists
            oldBanner.destroy()
        }
        
        // you can set AdView size to be the same as placement size
        // AdView will take care about banner centering
        let placementSize = self.bannerPlacement.frame.size
        adView.frame = CGRect(x: 0, y: 0, width: placementSize.width, height: placementSize.height)
        
        // add banner to view
        self.bannerPlacement.addSubview(adView)
        
        // store banner reference to be able to clear it later
        self.banner = adView
    }
}
