//
//  UIImage.swift
//  NikoNiko
//
//  Created by Angelique Babin on 07/12/2021.
//

import UIKit

extension UIImage {
    static func appImage(_ name: AssetsImage) -> UIImage? {
        let theme = UserSettings.theme
        let imgName = theme + "-" + name.rawValue
        return UIImage(named: imgName)
    }
}
