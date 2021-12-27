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

}
