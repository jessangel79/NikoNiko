//
//  UIColor.swift
//  NikoNiko
//
//  Created by Angelique Babin on 01/12/2021.
//

import UIKit

enum AssetsColor: String {
    case backGroundColor
    case fontColor
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}
