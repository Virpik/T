//
//  [CGFloat].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension CGFloat {
    public static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

public extension CGFloat {
    public var uInt32: UInt32 {
        return UInt32(self)
    }
    
    public var float: Float {
        return Float(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var int: Int {
        return Int(self)
    }
    
    public var string: String {
        return "\(self)"
    }
}
