//
//  TColor.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    public struct RGBAComponents {
        public var r: CGFloat = 0
        public var g: CGFloat = 0
        public var b: CGFloat = 0
        public var a: CGFloat = 0
    }

    public static func random() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
    
    public var rgbaComponents: RGBAComponents {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return RGBAComponents(r: r, g: g, b: b, a: a)
    }
    
    public convenience init(hex: Int) {
        let red = Float((hex & 0xFF0000) >> 16) / 255.0
        let green = Float((hex & 0xFF00) >> 8) / 255.0
        let blue = Float(hex & 0xFF) / 255.0
        
        self.init(red: red.cgFloat, green: green.cgFloat, blue: blue.cgFloat, alpha: 1.0)
    }

    public convenience init(sHex: String) {
        let hex = sHex
        
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue: UInt32 = 0
        
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

    public func transparency(_ f: CGFloat) -> UIColor {
        return self.withAlphaComponent(f)
    }
    
    /// +/- 1.000
    public func light(_ f: CGFloat) -> UIColor {
        let components = self.rgbaComponents
        
        let r = max(0, min(components.r + f, 1))
        let g = max(0, min(components.g + f, 1))
        let b = max(0, min(components.b + f, 1))
        
        let color = UIColor(red: r, green: g, blue: b, alpha: components.a)
        
        return color
    }
    
    public var hex: String {
        return self.hexDescription()
    }
    
    public func hexDescription(_ includeAlpha: Bool = false) -> String {
        guard self.cgColor.numberOfComponents == 4 else {
            return "Color not RGB."
        }
        
        let a = self.cgColor.components!.map {
            Int($0 * CGFloat(255))
        }
        
        let color = String.init(format: "%02x%02x%02x", a[0], a[1], a[2])
        
        if includeAlpha {
            let alpha = String.init(format: "%02x", a[3])
            return "\(color)\(alpha)"
        }
        
        return color
    }
}
