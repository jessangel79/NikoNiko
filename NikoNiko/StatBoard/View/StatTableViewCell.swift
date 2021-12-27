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
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        customShadowImageView(imageView: moodImageView)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {    super.traitCollectionDidChange(previousTraitCollection)
        customShadowImageView(imageView: moodImageView)
    }
    
    // MARK: - Methods
    
    func setupCellWithTuple(_ indexPath: IndexPath, _ statMoodTupleList: [(nameMood: String, statMood: Int)]) {
        let moodRow = statMoodTupleList[indexPath.row]
        statLabel.text = String(moodRow.statMood)
        moodImageView.image = UIImage.appImage(AssetsImage(rawValue: moodRow.nameMood) ?? .puzzledColor)
    }
}
