//
//  StatTableViewCell.swift
//  NikoNiko
//
//  Created by Angelique Babin on 03/12/2021.
//

import UIKit

class StatTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var moodImageView: UIImageView!
    @IBOutlet private weak var statLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    
    // MARK: - Properties
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        customShadowImageView(imageView: moodImageView)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {    super.traitCollectionDidChange(previousTraitCollection)
        customShadowImageView(imageView: moodImageView)
    }
    
    // MARK: - Methods
    
    func setupCellWithTuple(_ indexPath: IndexPath, _ statMoodTupleList: [(nameMood: String, statMood: Int)], _ lastCommentMoodTupleList: [(nameMood: String, lastCommentMood: String)]) {
        let moodRow = statMoodTupleList[indexPath.row]
        let lastCommentMoodRow = lastCommentMoodTupleList[indexPath.row]
        statLabel.text = String(moodRow.statMood)
        commentLabel.text = lastCommentMoodRow.lastCommentMood
        moodImageView.image = UIImage.appImage(AssetsImage(rawValue: moodRow.nameMood) ?? .puzzledColor)
    }
    
//    func setupCellWithTuple(_ indexPath: IndexPath, _ statMoodTupleList: [(nameMood: String, statMood: MoodData)], _ lastCommentMoodTupleList: [(nameMood: String, lastCommentMood: MoodData)]) {
//        let moodRow = statMoodTupleList[indexPath.row]
//        let lastCommentMoodRow = lastCommentMoodTupleList[indexPath.row]
//        statLabel.text = String(moodRow.statMood)
//        commentLabel.text = lastCommentMoodRow.lastCommentMood.self
//        moodImageView.image = UIImage.appImage(AssetsImage(rawValue: moodRow.nameMood) ?? .puzzledColor)
//    }
}
