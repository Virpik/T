//
//  [UInt32].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension UInt32 {
    public var float: Float {
        return Float(self)
    }
    
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var int: Int {
        return Int(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return "\(self)"
    }
}
