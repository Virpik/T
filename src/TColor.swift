//
//  TColor.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func colorWithInt(_ rgbValue: Int) -> UIColor {
        let red = Float((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Float((rgbValue & 0xFF00) >> 8) / 255.0
        let blue = Float(rgbValue & 0xFF) / 255.0

        let color: UIColor = UIColor.init(colorLiteralRed: red, green: green, blue: blue, alpha: 1.0)
        
        return color
    }
}
