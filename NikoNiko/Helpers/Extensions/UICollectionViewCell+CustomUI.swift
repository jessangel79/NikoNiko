//
//  UICollectionViewCell+CustomUI.swift
//  NikoNiko
//
//  Created by Angelique Babin on 29/11/2021.
//

import UIKit

// MARK: - Extension to custom buttons, views and labels - UICollectionViewCell

extension UICollectionViewCell {
    
    // MARK: - ImageView custom
    
    /// custom view with shadow
    func customShadowImageView(imageView: UIImageView) {
        imageView.clipsToBounds = false
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    // MARK: - Label custom
    
    func customLabel(label: UILabel, radius: CGFloat, width: CGFloat) {
        guard let backGroundColor = UIColor.appColor(.backGroundColor) else { return }
        guard let fontColor = UIColor.appColor(.fontColor) else { return }
        label.backgroundColor = backGroundColor
        label.numberOfLines = 0
        label.textColor = fontColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        label.layer.cornerRadius = radius
        label.layer.borderWidth = width
        label.layer.borderColor = UIColor.appColor(.fontColor)?.cgColor
        label.layer.masksToBounds = true
    }

}
