//
//  [Float].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension Float {
    
    public var uInt32: UInt32 {
        return UInt32(self)
    }
    
    public var cgFloat: CGFloat {
        return CGFloat(self)
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
