//
//  [Int].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension Int {
    
    /// Текущее значение как градусы в радианах
    public var degreesToRadians: Double {
        return Double(self) * .pi / 180
    }
    
    /// Текущее значение как радианы в градусах
    public var radiansToDegrees: Double {
        return Double(self) * 180 / .pi
    }
}

public extension Int {
    public var uInt32: UInt32 {
        return UInt32(self)
    }
    
    public var float: Float {
        return Float(self)
    }
    
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return "\(self)"
    }
    
    public var bool: Bool {
        return (self as NSNumber).boolValue
    }
    
    var number: NSNumber {
        return NSNumber(value: self)
    }
}
