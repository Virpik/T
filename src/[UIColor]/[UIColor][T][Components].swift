//
//  [UIColor][T][Components].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

extension UIColor.Ext {
    public struct RGBAComponents {
        public var r: CGFloat = 0
        public var g: CGFloat = 0
        public var b: CGFloat = 0
        public var a: CGFloat = 0
    }

    public var rgbaComponents: RGBAComponents {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.origin.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return RGBAComponents(r: r, g: g, b: b, a: a)
    }
}
