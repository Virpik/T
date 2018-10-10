//
//  [UIColor][T][Hex].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

public extension UIColor {
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
