//
//  MoodHistoryCollectionViewCell.swift
//  NikoNiko
//
//  Created by Angelique Babin on 29/11/2021.
//

import UIKit
import RealmSwift

class MoodHistoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private var moodHistoryImageView: UIImageView!
    @IBOutlet private var dayOfWeekLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    // MARK: - Properties
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var mood: Mood? {
        didSet {
            dayOfWeekLabel.text = mood?.date.dayOfWeek()
            dateLabel.text = mood?.date.toString().transformDate()
            moodHistoryImageView.image = UIImage(named: mood?.name ?? "puzzledColor")
        }
    }
    
    var moodDefault: Mood? {
        didSet {
            dayOfWeekLabel.text = "Day"
            dateLabel.text = "--/--"
            moodHistoryImageView.image = UIImage(named: moodDefault?.name ?? "puzzledColor")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        customShadowImageView(imageView: moodHistoryImageView)
    }

    func setupCell(_ indexPath: IndexPath, _ inverseMoodList: Results<Mood>?) {
        if let inverseMoodList = inverseMoodList {
            if !inverseMoodList.isEmpty {
                mood = inverseMoodList[indexPath.item]
            } else {
                let dataManager = DataManager()
                let moodListDefault = dataManager.createMoodListDefault()
                moodDefault = moodListDefault[indexPath.item]
            }
        }
    }
}
