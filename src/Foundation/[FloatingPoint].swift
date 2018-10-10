//
//  [FloatingPoint].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension FloatingPoint {
    public var degreesToRadians: Self {
        return self * .pi / 180
    }
    
    public var radiansToDegrees: Self {
        return self * 180 / .pi
    }
}
