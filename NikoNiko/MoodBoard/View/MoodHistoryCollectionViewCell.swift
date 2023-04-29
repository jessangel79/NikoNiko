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
    private var popupLabel: UILabel?
    private var isPopupVisible = false
    
    var mood: Mood? {
        didSet {
            dayOfWeekLabel.text = mood?.date.dayOfWeek()
            dateLabel.text = mood?.date.toString().transformDate()
            moodHistoryImageView.image = UIImage.appImage(AssetsImage(rawValue: mood?.name ?? "puzzledColor") ?? .puzzledColor)
        }
    }
    
    var moodDefault: Mood? {
        didSet {
            dayOfWeekLabel.text = "Day"
            dateLabel.text = "--/--"
            moodHistoryImageView.image = UIImage.appImage(.puzzledColor)
        }
    }
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customShadowImageView(imageView: moodHistoryImageView)
        createLabelToCommentMood()
        //        moodHistoryImageView.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let comment = self.mood?.comment
        if let touch = touches.first {
            let position = touch.location(in: self)
            if moodHistoryImageView.frame.contains(position) {
                popupLabel?.text = comment
                popupLabel?.center = CGPoint(x: moodHistoryImageView.center.x, y: moodHistoryImageView.center.y - 50)
                popupLabel?.isHidden = false
                isPopupVisible = true
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isPopupVisible {
            popupLabel?.isHidden = true
            isPopupVisible = false
        }
    }
    
    // MARK: - Methods
    
    func setupCell(_ indexPath: IndexPath, _ inverseMoodList: Results<Mood>?) {
        //        if indexPath.item < inverseMoodListCount {
        if let inverseMoodList = inverseMoodList {
            if !inverseMoodList.isEmpty {
                mood = inverseMoodList[indexPath.item]
            } else {
                let dataManager = DataManager()
                let moodListDefault = dataManager.createMoodListDefault()
                moodDefault = moodListDefault[indexPath.item]
            }
        }
        //        } else {
        //            print("error in setupCell")
        //        }
    }
    
    private func createLabelToCommentMood() {
        popupLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 58, height: 58))
        guard let popupLabel = popupLabel else { return }
        popupLabel.isHidden = true
        customLabel(label: popupLabel, radius: 10, width: 1.0)
        addSubview(popupLabel)
    }
    
}
