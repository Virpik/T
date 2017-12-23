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
    struct RGBAComponents {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
    }
    
    var rgbaComponents: RGBAComponents {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return RGBAComponents(r: r, g: g, b: b, a: a)
    }
    
    convenience init(hex: Int) {
        let red = Float((hex & 0xFF0000) >> 16) / 255.0
        let green = Float((hex & 0xFF00) >> 8) / 255.0
        let blue = Float(hex & 0xFF) / 255.0
        
        self.init(red: red.cgFloat, green: green.cgFloat, blue: blue.cgFloat, alpha: 1.0)
    }
    
    static func random() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
    
    func transparency(_ f: CGFloat) -> UIColor {
        return self.withAlphaComponent(f)
    }
    
    /// +/- 1.000
    func light(_ f: CGFloat) -> UIColor {
        let components = self.rgbaComponents
        
        let r = max(0, min(components.r + f, 1))
        let g = max(0, min(components.g + f, 1))
        let b = max(0, min(components.b + f, 1))
        
        let color = UIColor(red: r, green: g, blue: b, alpha: components.a)
        
        return color
    }
}
