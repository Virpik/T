//
//  [Double].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension Double {
    
    public var uInt32: UInt32 {
        return UInt32(self)
    }
    
    public var float: Float {
        return Float(self)
    }
    
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var int: Int {
        return Int(self)
    }
    
    public var string: String {
        return "\(self)"
    }
    
    public var date: Date {
        return Date(timeIntervalSince1970: self)
    }
}
