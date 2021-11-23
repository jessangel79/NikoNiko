//
//  MoodBoardViewController.swift
//  NikoNiko
//
//  Created by Angelique Babin on 22/11/2021.
//

import UIKit

class MoodBoardViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var allLabels: [UILabel]!
    
    @IBOutlet var moodImageViews: [UIImageView]!
    
    // MARK: - Properties

    // MARK: - Actions
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        customAllLabels(allLabels: allLabels, radius: 5, width: 1.0, colorBackground: #colorLiteral(red: 0.2436142266, green: 0.8575767279, blue: 0.9419901967, alpha: 1), colorBorder: #colorLiteral(red: 0.04181067646, green: 0, blue: 0.6056833863, alpha: 1))
        customShadowImageViews(imageViews: moodImageViews)
        customImageViews(imageViews: moodImageViews, colorBorder: #colorLiteral(red: 0.04181067646, green: 0, blue: 0.6056833863, alpha: 1))
    }

}
