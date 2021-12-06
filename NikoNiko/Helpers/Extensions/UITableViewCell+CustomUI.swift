//
//  UITableViewCell+CustomUI.swift
//  NikoNiko
//
//  Created by Angelique Babin on 04/12/2021.
//

import UIKit

// MARK: - Extension to custom buttons, views and labels

extension UITableViewCell {
    
    // MARK: - ImageView custom
    
    /// custom view with shadow
    func customShadowImageView(imageView: UIImageView) {
        imageView.clipsToBounds = false
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
