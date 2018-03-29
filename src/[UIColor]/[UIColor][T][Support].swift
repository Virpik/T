//
//  [UIColor][T][Support].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

public extension UIColor.Ext {
    public func transparency(_ f: CGFloat) -> UIColor {
        return self.origin.withAlphaComponent(f)
    }
    
    public func invert(originAlpha: Bool = true) -> UIColor {
        let c = self.origin.t.rgbaComponents
        
        let newC = RGBAComponents(r: 1 - c.r, g: 1 - c.g, b: 1 - c.b, a: originAlpha ? c.a : 1 - c.r)
        
        return UIColor.t.with(newC)//t.with(newC)
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
    
}
