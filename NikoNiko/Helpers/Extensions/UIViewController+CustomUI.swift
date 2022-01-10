//
//  UIViewController+CustomUI.swift
//  SunsetApp
//
//  Created by Angelique Babin on 24/09/2020.
//

import UIKit

// MARK: - Extension to custom buttons, views and labels - UIViewController

extension UIViewController {

    /// UserInterfaceStyle - Light and Dark Mode
    func setUserInterfaceStyle() {
        if !UserSettings.useDeviceSetting {
            overrideUserInterfaceStyle = .light
        } else {
            overrideUserInterfaceStyle = .unspecified
        }
    }
    
    // MARK: - Buttons custom
    
    /// custom button with shadow
    func customShadowButton(button: UIButton) {
        button.clipsToBounds = false
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.appColor(.fontColor)?.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    /// custom collection buttons with shadow
    func customShadowButtons(buttons: [UIButton]) {
        for button in buttons {
            customShadowButton(button: button)
        }
    }
    
    // MARK: - Labels custom
    
    /// custom label with shadow
    func customShadowLabel(label: UILabel) {
        label.clipsToBounds = false
        label.layer.shadowColor = UIColor.appColor(.fontColor)?.cgColor
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        if traitCollection.userInterfaceStyle == .dark {
            label.layer.shadowOpacity = 1.0
        } else {
            label.layer.shadowOpacity = 0.5
        }
    }
    
    /// custom collection labels with shadow
    func customShadowLabels(labels: [UILabel]) {
        for label in labels {
            customShadowLabel(label: label)
        }
    }

    // MARK: - View custom
    
    /// custom view
    func customView(view: UIView, radius: CGFloat, width: CGFloat, colorBorder: UIColor) {
        view.layer.cornerRadius = radius
        view.layer.borderWidth = width
        view.layer.borderColor = colorBorder.cgColor
    }
    
    /// custom view with shadow
    func customShadowView(view: UIView) {
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.appColor(.fontColor)?.cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    // MARK: - CollectionView custom

    /// custom collectionView
    func customCollectionView(collectionView: UICollectionView, radius: CGFloat, width: CGFloat, colorBorder: UIColor) {
        collectionView.layer.cornerRadius = radius
        collectionView.layer.borderWidth = width
        collectionView.layer.borderColor = colorBorder.cgColor
    }
    
}
