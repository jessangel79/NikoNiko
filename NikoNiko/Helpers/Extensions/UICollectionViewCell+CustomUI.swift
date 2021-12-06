//
//  UICollectionViewCell+CustomUI.swift
//  NikoNiko
//
//  Created by Angelique Babin on 29/11/2021.
//

import UIKit

// MARK: - Extension to custom buttons, views and labels

extension UICollectionViewCell {
    
    // MARK: - ImageView custom
    
    /// custom view with shadow
    func customShadowImageView(imageView: UIImageView) {
        imageView.clipsToBounds = false
        imageView.layer.shadowColor = UIColor.black.cgColor // #colorLiteral(red: 0.04181067646, green: 0, blue: 0.6056833863, alpha: 1)
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    // MARK: - View custom
    
    /// custom view
//    func customView(view: UIView, radius: CGFloat, width: CGFloat, colorBorder: UIColor) {
//        view.layer.cornerRadius = radius
//        view.layer.borderWidth = width
//        view.layer.borderColor = colorBorder.cgColor
//    }
}
