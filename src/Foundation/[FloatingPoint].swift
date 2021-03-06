//
//  [FloatingPoint].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension FloatingPoint {
    
    /// Текущее значение как градусы в радианах
    public var degreesToRadians: Self {
        return self * .pi / 180
    }
    
    /// Текущее значение как радианы в градусах
    public var radiansToDegrees: Self {
        return self * 180 / .pi
    }
}
