//
//  MoodHistoryCollectionViewCell.swift
//  NikoNiko
//
//  Created by Angelique Babin on 29/11/2021.
//

import UIKit

class MoodHistoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private var moodHistoryImageView: UIImageView!
    @IBOutlet private var dayOfWeekLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    // MARK: - Properties
    
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
            moodHistoryImageView.image = UIImage(named: "puzzledColor")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        customShadowImageView(imageView: moodHistoryImageView)
    }

}
