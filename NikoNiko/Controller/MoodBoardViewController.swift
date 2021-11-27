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
    @IBOutlet private var dayOfWeekLabels: [UILabel]!
    @IBOutlet private var dateLabels: [UILabel]!
    
    // MARK: - Properties
    
    private let realm = try? Realm()
//    private let dataManager = DataManager()
    private var lastMoods = [Mood]()

    // MARK: - Actions
    
    @IBAction func moodTodayButtonsPressed(_ sender: UIButton) {
        guard let moodName = sender.currentTitle else { return }
        getMoodForToday(moodName: moodName)
        getLastMoods()
        setMoodHistoryImages()
        setDateLabels()
        setDayOfWeekLabels()
//        setMoodDatas()
    }
    
    @IBAction func deleteAllBarButtonItemPressed(_ sender: UIBarButtonItem) {
        let dataManager = DataManager()
        dataManager.removeAllMoods(realm: realm)
        for moodHistoryImageView in moodHistoryImageViews {
            moodHistoryImageView.image = UIImage(named: "puzzledColor")
        }
        for dateLabel in dateLabels {
            dateLabel.text = "--/--"
        }
        for dayOfLabel in dayOfWeekLabels {
            dayOfLabel.text = "Day"
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
        print("REALM : \(Realm.Configuration.defaultConfiguration.fileURL!)") // for db Realm Studio
        getLastMoods()
        setMoodHistoryImages()
        setDateLabels()
        setDayOfWeekLabels()
//        setMoodDatas()
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
    
    /// ok
    private func setMoodHistoryImages() {
        print("lastMoods : \(lastMoods)")
        if !lastMoods.isEmpty {
            for moodHistoryImageView in moodHistoryImageViews {
                if moodHistoryImageView.tag == 0 && lastMoods.count >= 1 {
                    moodHistoryImageView.image = UIImage(named: lastMoods.first?.name ?? "puzzledColor")
                } else if moodHistoryImageView.tag == 1 && lastMoods.count >= 2 {
                    moodHistoryImageView.image = UIImage(named: lastMoods[1].name)
                } else if moodHistoryImageView.tag == 2 && lastMoods.count >= 3 {
                    moodHistoryImageView.image = UIImage(named: lastMoods[2].name)
                } else if moodHistoryImageView.tag == 3 && lastMoods.count >= 4 {
                    moodHistoryImageView.image = UIImage(named: lastMoods[3].name)
                } else if moodHistoryImageView.tag == 4 && lastMoods.count >= 5 {
                    moodHistoryImageView.image = UIImage(named: lastMoods[4].name)
                }
            }
        }
    }
    
    private func setDateLabels() {
        if !lastMoods.isEmpty {
            for dateLabel in dateLabels {
                if dateLabel.tag == 0 && lastMoods.count >= 1 {
                    dateLabel.text = lastMoods.first?.date.toString().transformDate()
                } else if dateLabel.tag == 1 && lastMoods.count >= 2 {
                    dateLabel.text = lastMoods[1].date.toString().transformDate()
                } else if dateLabel.tag == 2 && lastMoods.count >= 3 {
                    dateLabel.text = lastMoods[2].date.toString().transformDate()
                } else if dateLabel.tag == 3 && lastMoods.count >= 4 {
                    dateLabel.text = lastMoods[3].date.toString().transformDate()
                } else if dateLabel.tag == 4 && lastMoods.count >= 5 {
                    dateLabel.text = lastMoods[4].date.toString().transformDate()
                }
            }
        }
    }
    
    private func setDayOfWeekLabels() {
        if !lastMoods.isEmpty {
            for dayOfLabel in dayOfWeekLabels {
                if dayOfLabel.tag == 0 && lastMoods.count >= 1 {
                    dayOfLabel.text = lastMoods.first?.date.dayOfWeek()
                } else if dayOfLabel.tag == 1 && lastMoods.count >= 2 {
                    dayOfLabel.text = lastMoods[1].date.dayOfWeek()
                } else if dayOfLabel.tag == 2 && lastMoods.count >= 3 {
                    dayOfLabel.text = lastMoods[2].date.dayOfWeek()
                } else if dayOfLabel.tag == 3 && lastMoods.count >= 4 {
                    dayOfLabel.text = lastMoods[3].date.dayOfWeek()
                } else if dayOfLabel.tag == 4 && lastMoods.count >= 5 {
                    dayOfLabel.text = lastMoods[4].date.dayOfWeek()
                }
            }
        }
    }
    
//        private func setMoodDatas() {
//            print("lastMoods : \(lastMoods)")
//            if !lastMoods.isEmpty {
//                for moodHistoryImageView in moodHistoryImageViews {
//                    if lastMoods.count >= 1 {
//                        if moodHistoryImageView.tag == 0 {
//                            moodHistoryImageView.image = UIImage(named: lastMoods.first?.name ?? "puzzledColor")
//                        }
//                    } else if lastMoods.count >= 2 {
//                        if moodHistoryImageView.tag == 1 {
//                            moodHistoryImageView.image = UIImage(named: lastMoods[1].name)
//                        }
//                    } else if lastMoods.count >= 3 {
//                        if moodHistoryImageView.tag == 2 {
//                            moodHistoryImageView.image = UIImage(named: lastMoods[2].name)
//
//                        }
//                    } else if lastMoods.count >= 4 {
//                        if moodHistoryImageView.tag == 3 {
//                            moodHistoryImageView.image = UIImage(named: lastMoods[3].name)
//                        }
//                    } else if lastMoods.count >= 5 {
//                        if moodHistoryImageView.tag == 4 {
//                            moodHistoryImageView.image = UIImage(named: lastMoods[4].name)
//                        }
//                    }
//                }
//            }
//        }

}
