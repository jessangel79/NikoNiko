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
    
//    func setupCellWithTuple(_ indexPath: IndexPath, _ statMoodTupleList: [(nameMood: String, statMood: Int)], _ lastCommentMoodTupleList: [(nameMood: String, lastCommentMood: String)]) {
//        let moodRow = statMoodTupleList[indexPath.row]
//        let lastCommentMoodRow = lastCommentMoodTupleList[indexPath.row]
//        statLabel.text = String(moodRow.statMood)
//        commentLabel.text = lastCommentMoodRow.lastCommentMood
//        moodImageView.image = UIImage.appImage(AssetsImage(rawValue: moodRow.nameMood) ?? .puzzledColor)
//    }
    
//    func setupCellWithTuple(_ indexPath: IndexPath, _ statMoodTupleList: [(nameMood: String, moodData: MoodData)], _ lastCommentMoodTupleList: [(nameMood: String, moodData: MoodData)]) {
//        let moodRow = statMoodTupleList[indexPath.row]
//        let lastCommentMoodRow = lastCommentMoodTupleList[indexPath.row]
//        statLabel.text = String(moodRow.moodData.countMood(0))
//        commentLabel.text = lastCommentMoodRow.moodData.lastComment("")
//    //        statLabel.text = String(moodRow.statMood)
//    //        commentLabel.text = lastCommentMoodRow.lastCommentMood.self
//        moodImageView.image = UIImage.appImage(AssetsImage(rawValue: moodRow.nameMood) ?? .puzzledColor)
//    }
    
//    private func setTextToLabelTest(_ moodTupleList: [(nameMood: String, moodData: MoodData)], _ indexPath: IndexPath) {
//        let moodRow = moodTupleList[indexPath.row]
//        switch moodRow.moodData {
//        case .countMood(_):
//            commentLabel.text = ""
//        case .lastComment(let comment):
//            commentLabel.text = comment
//        }
//    }
    
    private func setTextToStatLabel(_ moodRow: (nameMood: String, moodData: MoodData)) {
        switch moodRow.moodData {
        case .countMood(let count):
            statLabel.text = String(count)
        case .lastComment(_):
            statLabel.text = ""
        }
    }
    
    private func setTextToCommentLabel(_ lastCommentMoodRow: (nameMood: String, moodData: MoodData)) {
        switch lastCommentMoodRow.moodData {
        case .countMood(_):
            commentLabel.text = ""
        case .lastComment(let comment):
            commentLabel.text = comment
        }
    }
    
    func setupCellWithTuple(_ indexPath: IndexPath, _ statMoodTupleList: [(nameMood: String, moodData: MoodData)], _ lastCommentMoodTupleList: [(nameMood: String, moodData: MoodData)]) {
        let moodRow = statMoodTupleList[indexPath.row]
        let lastCommentMoodRow = lastCommentMoodTupleList[indexPath.row]
        setTextToStatLabel(moodRow)
        setTextToCommentLabel(lastCommentMoodRow)
        moodImageView.image = UIImage.appImage(AssetsImage(rawValue: moodRow.nameMood) ?? .puzzledColor)
    }

}
