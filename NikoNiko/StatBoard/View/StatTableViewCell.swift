//
//  StatTableViewCell.swift
//  NikoNiko
//
//  Created by Angelique Babin on 03/12/2021.
//

import UIKit

class StatTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var statLabel: UILabel!
    
    // MARK: - Properties
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var moodNames = [NameMood.happy.rawValue, NameMood.smiling.rawValue, NameMood.sad.rawValue, NameMood.neutral.rawValue, NameMood.disappointed.rawValue]
    
//    var statMoodDictionnary: [String: Int]? {
//        didSet {
//
////            moodImageView.image = UIImage(named: statMoodDictionnary?.index(forKey: NameMood.sad))
//        }
//    }
    
//    var mood: Mood? {
//        didSet {
//            dayOfWeekLabel.text = mood?.date.dayOfWeek()
//            dateLabel.text = mood?.date.toString().transformDate()
//            moodHistoryImageView.image = UIImage(named: mood?.name ?? "puzzledColor")
//        }
//    }
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Methods

    func setupCell(_ indexPath: IndexPath, _ statMoodDictionnary: [String: Int]) {
        let arr = statMoodDictionnary.map { "\($0.key),\($0.value)" }
        print(arr)
        let moodIndex = arr[indexPath.row]
        statLabel.text = moodIndex.cutStartString()
        moodImageView.image = UIImage(named: moodIndex.cutEndString())
        print(moodIndex.cutStartString())
        print(moodIndex.cutEndString())
    }
    
//    func setupCell(_ indexPath: IndexPath, _ inverseMoodList: Results<Mood>?) {
//        if let inverseMoodList = inverseMoodList {
//            if !inverseMoodList.isEmpty {
//                mood = inverseMoodList[indexPath.item]
//            } else {
//                let dataManager = DataManager()
//                let moodListDefault = dataManager.createMoodListDefault()
//                moodDefault = moodListDefault[indexPath.item]
//            }
//        }
//    }
}
