//
//  UIColor+Extensions.swift
//  RePlay
//
//  Created by Bennet van der Linden on 30/07/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (CGFloat(((hex & 0xFF0000) >> 16)))/255.0,
            green: (CGFloat(((hex & 0xFF00) >> 8)))/255.0,
            blue: (CGFloat((hex & 0xFF)))/255.0,
            alpha: alpha
        )
    }

    open class var darkText: UIColor {
        return UIColor(hex: 0x284854)
    }

    open class var background: UIColor {
        return UIColor(hex: 0x32CCB0)
    }

    open class var accentYellow: UIColor {
        return UIColor(hex: 0xFFEDA7)
    }

    open class var accentRed: UIColor {
        return UIColor(hex: 0xFF5C58)
    }

    open class var accentPurple: UIColor {
        return UIColor(hex: 0x512C54)
    }
}
