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
    convenience init(hex: Int) {
        let red = Float((hex & 0xFF0000) >> 16) / 255.0
        let green = Float((hex & 0xFF00) >> 8) / 255.0
        let blue = Float(hex & 0xFF) / 255.0
        
        self.init(colorLiteralRed: red, green: green, blue: blue, alpha: 1.0)
    }
}
