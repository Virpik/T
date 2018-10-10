//
//  [UIView][Initals].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

public extension UIView {
    
    public convenience init(width: CGFloat, height: CGFloat) {
        let size = CGSize(width: width, height: height)
        self.init(size: size)
    }
    
    public convenience init(size: CGSize) {
        let frame = CGRect(origin: CGPoint.zero, size: size)
        self.init(frame: frame)
    }
    
    public static func default1x1() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    public static func default10x10() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    public static func default20x20() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    }
    
    public static func default50x50() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
    public static func default100x100() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    public static func defaultScreen() -> Self {
        return self.init(frame: UIScreen.main.bounds)
    }
}
