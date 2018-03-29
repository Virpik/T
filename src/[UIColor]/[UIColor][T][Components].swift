//
//  [UIColor][T][Components].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

public extension UIColor.ExtStatic {
    public typealias RGBAComponents = UIColor.RGBAComponents
    
    public func with(_ components: RGBAComponents) -> UIColor {
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }
}

public extension UIColor.Ext {
    public typealias RGBAComponents = UIColor.RGBAComponents
    
    public var rgbaComponents: RGBAComponents {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.origin.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return RGBAComponents(r: r, g: g, b: b, a: a)
    }
}
