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
    
    @IBOutlet private var moodTodayButtons: [UIButton]!
    @IBOutlet private weak var historyView: UIView!
    @IBOutlet private var titleLabels: [UILabel]!
    @IBOutlet weak var moodHistoryCollectionView: UICollectionView!

    // MARK: - Properties
    
    private let realm = try? Realm()
    private var inverseMoodList: Results<Mood>?
    private var moodListDefault = [Mood]()
//    private let dataManager = DataManager()

    // MARK: - Actions
    
    @IBAction private func moodTodayButtonsPressed(_ sender: UIButton) {
        guard let moodName = sender.currentTitle else { return }
        getMoodForToday(moodName: moodName)
        getInverseMoodList()
        moodHistoryCollectionView.reloadData()
    }
    
    @IBAction private func deleteAllBarButtonItemPressed(_ sender: UIBarButtonItem) {
        let dataManager = DataManager()
        dataManager.removeAllMoods(realm: realm)
        moodHistoryCollectionView.reloadData()
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        moodHistoryCollectionView.delegate = self
        moodHistoryCollectionView.dataSource = self
        customUI()
        createMoodListDefault()
        setNib()
        getInverseMoodList()
        print("REALM : \(Realm.Configuration.defaultConfiguration.fileURL!)") // for db Realm Studio
        moodHistoryCollectionView.reloadData()
        moodHistoryCollectionView.collectionViewLayout = setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        moodHistoryCollectionView.reloadData()
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        moodHistoryCollectionView.collectionViewLayout.invalidateLayout()
//    }

    // MARK: - Methods

    private func customUI() {
        customShadowButtons(buttons: moodTodayButtons)
        customShadowView(view: historyView)
        customView(view: historyView, radius: 20, width: 0.8, colorBorder: #colorLiteral(red: 0.04181067646, green: 0, blue: 0.6056833863, alpha: 1))
        customShadowLabels(labels: titleLabels)
        customCollectionView(collectionView: moodHistoryCollectionView, radius: 20, width: 0.1, colorBorder: .clear)
    }
    
    private func setNib() {
        let nib = UINib(nibName: Cst.MoodHistoryCollectionViewCell, bundle: nil)
        moodHistoryCollectionView.register(nib, forCellWithReuseIdentifier: Cst.MoodHistoryCell)
    }
    
    func setLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 120)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private func createMoodListDefault() {
        let dataManager = DataManager()
        moodListDefault = dataManager.createMoodListDefault()
    }
    
    private func getMoodForToday(moodName: String) {
        let dataManager = DataManager()
        let currentDate = Date()
        dataManager.updateMood(realm: self.realm, moodName: moodName, forDate: currentDate)
        print("current date : \(currentDate)")
        print("moodName : \(moodName)")
    }
    
    private func getInverseMoodList() {
        let dataManager = DataManager()
        inverseMoodList = dataManager.inverseMoodList(realm: self.realm)
    }
}

extension MoodBoardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let inverseMoodList = inverseMoodList else { return 0 }
        if inverseMoodList.isEmpty {
            return moodListDefault.count
        } else {
            return inverseMoodList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let moodHistoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cst.MoodHistoryCell, for: indexPath) as? MoodHistoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let inverseMoodList = inverseMoodList {
            if !inverseMoodList.isEmpty {
                let mood = inverseMoodList[indexPath.item]
                moodHistoryCell.mood = mood
            } else {
                let moodDefault = moodListDefault[indexPath.item]
                moodHistoryCell.moodDefault = moodDefault
            }
        }
        return moodHistoryCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 120)
    }
}
